# ADR-001: ProDOS FX vs ProDOS 2.4.3 Compatibility Strategy

**Date:** 2026-03-16
**Status:** Proposed
**Context:** A2osX kernel ProDOS dependency

---

## Context

A2osX currently requires **ProDOS FX** — a fork of ProDOS 2.0.3 — to boot. ProDOS FX adds
three MLI calls that A2osX uses for Unix-style file metadata and permissions:

| Call | Number | Purpose |
|------|--------|---------|
| `MLI.SFINFOEX` | $D4 | Set File Info Extended |
| `MLI.GFINFOEX` | $D5 | Get File Info Extended (stat()) |
| `MLI.ACL`      | $D6 | Access Control List (chmod/chown) |

The wider Apple II community uses **ProDOS 2.4.3** (maintained by John Brooks), which is based
on a different lineage and does not include the $D4–$D6 calls. Users running stock Apple II
hardware with a standard ProDOS ROM or ProDOS 2.4.3 cannot boot A2osX.

### ProDOS Lineage

```
ProDOS 2.0.3 ──┬── ProDOS FX       (A2osX fork: adds $D4/$D5/$D6 + PM loader)
               └── ProDOS 2.0.3    (reference/disassembled, markpmlim/ProDOS8)

ProDOS 2.4.x ─────  John Brooks    (source NOT publicly available as of 2026-03-16)
                     github.com/ProDOS-8 — releases + binaries only
                     ProDOS 2.5 in development: converting from MPW AsmIIGS → Merlin32
```

Both ProDOS FX and ProDOS 2.0.3 share `KVER = $23`. ProDOS 2.4.3 has a different
version byte.

### Current Detection

`SYS/KERNEL.S.INIT2.txt` already probes for FX at boot:
- Calls `MLI.GFINFOEX` ($D5) on a known file
- If `MLI.E.BADCALL` → standard ProDOS (currently hits `bcc *` infinite loop = hard abort)
- If success → ProDOS FX confirmed, boot continues

### ProDOS FX Architecture

- FX extensions live in XDOS at `$DE00` (language card bank 1)
- The `XDOS.CmdNums` dispatch table in ProDOS FX has `D4 D5 D6` where standard ProDOS has `00 00 00`
- ProDOS FX also adds a **PM (Patch Module) loader** — binary files named `PM.*` loaded at
  boot time from the system volume into `$2000` and executed, used for hardware drivers
  (PM.VEDRIVE, PM.RAMWORKS, PM.APPLETALK, etc.)
- PM loading is bootloader-time only; no runtime PM API exists post-boot

---

## Decision

**Not yet decided.** Two candidate strategies:

### Option A: Kernel Shim (A2osX-level fallback) — Recommended Near-Term

When booting on standard ProDOS 2.4.3:

1. Change the `bcc *` boot abort to set a global flag `K.ProDOSFX` (`$FF` = FX present,
   `$00` = standard ProDOS) and continue booting.
2. In `KERNEL.S.PRODOS` (GFINFOEX path): already partially falls back to `GFINFO` ($C4) on
   BADCALL — complete this fallback by synthesizing the missing extended fields with defaults.
3. In `KERNEL.S.STAT` and `KERNEL.S.UNISTD` (ACL path): gate ACL read/write on `K.ProDOSFX`.
   On standard ProDOS, chmod/chown become no-ops (permissions not persisted to disk).

**Pros:** No ProDOS modification; works on any standard ProDOS today.
**Cons:** ACL/permissions are volatile (kernel RAM only, not disk-persisted) on non-FX systems.

### Option B: ProDOS 2.4.3 FX Fork — Long-Term

Port the three FX extensions into ProDOS 2.4.3's codebase to produce "ProDOS 2.4.3 FX":

1. Obtain ProDOS 2.4.3 source (contact John Brooks / ProDOS-8 project — source not yet public)
2. Diff `ProDOS.FX/ProDOS.S.XDOS.F.txt` against `ProDOS.203/` equivalent to isolate additions
3. Integrate `XDOS.SetFileInfoEx`, `XDOS.GetFileInfoEx`, `XDOS.ACL` into 2.4.3's XDOS
4. Add `D4 D5 D6` to 2.4.3's `XDOS.CmdNums` dispatch table

**Pros:** Full disk-persisted ACL support; benefits of 2.4.3 (newer hardware, bug fixes,
Raspberry Pi card, AppleMouse II, Uthernet II).
**Cons:** Non-trivial — 2.4.3 has reorganized internal structures; depends on source access
from John Brooks; effectively a new open-source project.

### Option C: Runtime Binary Patch of 2.4.3

A boot-time patcher that:
1. Scans in-memory XDOS for the known dispatch table signature
2. Injects $D4/$D5/$D6 handler code into available LC RAM space
3. Patches the dispatch table entries

**Pros:** Works on stock 2.4.3 binary without source.
**Cons:** Fragile — depends on 2.4.3's exact memory layout matching expectations;
high risk of breakage across 2.4.x minor versions.

---

## Consequences

**If Option A adopted:**
- A2osX boots on both ProDOS FX and standard ProDOS 2.4.3
- `chmod`/`chown` are silently no-ops on non-FX systems
- File stat() works on both (synthesized fields on non-FX)
- Gate: `K.ProDOSFX` byte in kernel zero-page or BSS

**If Option B adopted:**
- Requires John Brooks' cooperation or ProDOS 2.5 source release
- Larger project scope; should be tracked as a separate initiative
- A2osX should implement Option A first as an interim measure

---

## References

- `SYS/KERNEL.S.INIT2.txt` — ProDOS FX detection (lines ~402–465)
- `SYS/KERNEL.S.PRODOS.txt:431` — GFINFOEX with partial BADCALL fallback
- `SYS/KERNEL.S.STAT.txt:34` — ACL chmod (no fallback)
- `SYS/KERNEL.S.UNISTD.txt:251` — ACL chown (no fallback)
- `ProDOS.FX/ProDOS.S.XDOS.F.txt` — FX dispatch table and handlers
- `ProDOS.FX/ProDOS.S.ILDR.txt` — PM loader implementation
- `INC/MLI.I.txt` — MLI call number constants
- https://github.com/ProDOS-8 — official ProDOS releases (binaries only)
- https://prodos8.com/releases/prodos-243/ — ProDOS 2.4.3 release notes
- https://github.com/markpmlim/ProDOS8 — disassembled ProDOS 2.0.3 in Merlin format

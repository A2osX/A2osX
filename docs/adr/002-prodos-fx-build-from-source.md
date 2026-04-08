# ADR-002: Build ProDOS FX from Source Using xasm++

**Date:** 2026-03-17
**Status:** Accepted -- Implemented
**Context:** ProDOS FX binary provenance and reproducibility

---

## Context

A2osX requires ProDOS FX -- a fork of ProDOS 2.0.3 that adds three MLI calls
($D4 SFINFOEX, $D5 GFINFOEX, $D6 ACL) and a PM (Patch Module) boot loader.
The source lives in `ProDOS.FX/` in this repository.

### How ProDOS FX is structured

`ProDOS.FX/ProDOS.S.txt` assembles the full binary in one pass. It has two main
sections:

**1. Resident code** -- the boot loader and PAKME decompressor, assembled inline:

```
.INB usr/src/prodos.fx/prodos.s.ldr     ; boot loader
.INB usr/src/shared/x.unpak.s           ; PAKME decompressor
.INB usr/src/prodos.fx/prodos.s.logo    ; boot logo (optional)
```

**2. Module data area** -- each module has a 4-byte PAK header followed by its data:

```
PAKME.Table                             ; table of (module-id, ptr-to-PAK) pairs
...
ILDR.PAK  .DA #0                        ; BLBITS = 0 (uncompressed)
          .DA ILDR.LEN                  ; uncompressed size
          .INB usr/src/prodos.fx/prodos.s.ildr  ; module data
```

**3. PAKME footer** -- 10-byte tag used by the runtime loader:

```
.AS "PAKME"   ; magic
.DA $2000     ; binary origin
.DA #count    ; number of modules
.DA PAKME.Table
```

### How .INB works in SCMASM

`.IN` and `.INB` are **source include** directives -- confirmed from
`SCMASM.30/SCMASM.S.DIR2.txt`:

```
*    .IN -- INCLUDE A SOURCE FILE
PSIN  ...
*---CHECK FOR .INBx--------------
      JSR GNC.UC
      CMP #'B'
      BNE .2       ...NOT .INBx
      JSR GNC.UC   GET # OF BLOCKS
```

`.INB` is `.IN` with a block-count suffix (`.INB1`..`.INB9`) for loading large
files. Both load the file via ProDOS and continue assembly from the top of the
included source -- identical to a source include. There is no separate
binary-insert directive in SCMASM; `.INB` is always source inclusion.

In the original Apple II build, `ProDOS.S.ILDR.txt` would first be assembled
separately (saving its binary output via the MAN/SAVE sequence at the file
bottom), PAKME-compressed, and the compressed binary saved back. The `.INB`
in `ProDOS.S.txt` would then insert that pre-compressed binary.

xasm++ implements `.INB` as source inclusion, which replicates the inline
assembly step but skips the compress/reinsert step. This is intentional and
correct -- see below.

### BLBITS = 0 means uncompressed

The PAKME decompressor (`SHARED/X.UNPAK.S.txt`) handles both compressed and
uncompressed chunks:

```asm
X.Unpak   jsr X.Unpak.GetByte   ; read BLBITS
          tax
          bne X.Unpak.PAK       ; non-zero -> decompress
          ; fall through:
X.Unpak.STORE                   ; BLBITS=0 -> raw copy
          jsr X.Unpak.GetULEN
          ; ... copies ULEN bytes from source to destination
```

**BLBITS = 0 is a defined, valid chunk type meaning "data is uncompressed -- copy
verbatim."** The `.DA #0` at each `XXXXX.PAK` label is not a placeholder to be
overwritten -- it is the correct BLBITS value for uncompressed modules.

At boot the loader calls `X.Unpak.XatYA(X)` for each module. With BLBITS=0 it
reads ULEN and copies the raw assembled bytes directly to the module's load
address. The system boots and runs correctly.

### PAKME in the application BIN pipeline (separate concern)

Remy Gibert (A2osX author) has confirmed a separate PAKME usage for application
BINs: after assembling a BIN file, if the binary has a "PAKME" magic footer at
the end, the `PAKME` tool (`BIN/PAKME.S.txt`) is run to produce a compressed
version.

The magic footer is embedded in the source file at assembly time -- confirmed
in `BIN/PAKME.S.txt` itself:

```asm
TAG           .CZ "PAKME"     ; 6 bytes including null terminator
PAKME.HEADER  .BS 10          ; header buffer, populated by PAKME tool at pack time
```

Workflow for applicable BINs:
1. Assemble BIN to uncompressed binary (standard xasm++ output)
2. Detect "PAKME" magic at end of binary
3. Run `PAKME source.bin packed.bin` to produce compressed output

**This BIN packing step is tracked separately (xasm-yrt) and is not part of
ProDOS FX kernel assembly.** The decision below applies only to the kernel.

### PAKME algorithm: migration from X.PAK to X.ARC

Remy has confirmed the PAKME compression algorithm is migrating from the original
bit-counting algorithm (`SHARED/X.PAK.S.txt`) to ARC (`SHARED/X.ARC.S.txt`).
Current `BIN/PAKME.S.txt` still uses `X.Pak`; migration is in progress. This
affects the BIN packing pipeline (xasm-yrt) only -- ProDOS FX uses BLBITS=0
(no compression) regardless of which algorithm PAKME uses.

---

## Decision

**Assemble `ProDOS.FX/ProDOS.S.txt` directly with xasm++ in a single pass,
with BLBITS=0 (uncompressed) for all modules.** No separate per-module
assembly or PAKME compression step is required for the ProDOS FX kernel binary.

```cmake
add_custom_command(
    OUTPUT  ${ASSETS_DIR}/PRODOS
    COMMAND ${XASMPP}
            --cpu 65816 --syntax scmasm --relax-branches
            -I ${STAGE_DIR}
            -o ${ASSETS_DIR}/PRODOS
            -- usr/src/prodos.fx/prodos.s
    WORKING_DIRECTORY ${STAGE_DIR}
    DEPENDS ${CMAKE_SOURCE_DIR}/ProDOS.FX/ProDOS.S.txt
    COMMENT "Assembling ProDOS FX"
)
```

**Verification:**

```
xasm++ build output:  16,683 bytes  (BLBITS=0, all modules uncompressed)
STABLE.800 reference: 16,748 bytes  (older source branch, also BLBITS=0)
```

The 65-byte delta is source evolution between branch `335cd122` (current) and
the `a417f7ab`-era source in STABLE.800 (SYSCALL address changes etc.) -- not
an assembler or compression difference. Both use BLBITS=0.

---

## Alternatives Considered

### A: PAKME-compress ProDOS FX modules (rejected for kernel -- not for BINs)

PAKME compression of ProDOS FX modules would reduce the kernel binary size, but
the decompressor code itself adds overhead; the net effect on the 16KB binary is
negligible or negative. More importantly, BLBITS=0 is a defined valid chunk type
that the decompressor handles correctly. Compression is not required for the
ProDOS FX kernel to boot or operate correctly.

**Note:** PAKME compression IS used for application BINs with a PAKME footer --
this is a separate build pipeline concern tracked as xasm-yrt. The rejection
here is scoped to ProDOS FX kernel assembly only.

### B: Keep pre-built binary blob (rejected -- not reproducible)

Opaque binary that cannot be audited or modified from source.

---

## Consequences

**Positive:**
- Reproducible, auditable ProDOS FX binary built entirely from source
- Single xasm++ invocation -- no multi-phase build, no compression tools
- BLBITS=0 is valid PAKME format; decompressor handles it correctly at runtime

**Negative:**
- ProDOS FX modules are not PAKME-compressed; binary is marginally larger than a
  fully-compressed build would be (difference is negligible at ~16KB)

**Neutral:**
- xasm++ 65816 support (indirect long `lda [$01]` in SEL2) is a prerequisite
  and is already implemented
- Application BIN PAKME packing is a separate cmake pipeline step (xasm-yrt)
- PAKME algorithm migration from X.PAK to X.ARC is tracked under xasm-yrt

---

## References

- `ProDOS.FX/ProDOS.S.txt` -- main ProDOS FX assembly entry point
- `SHARED/X.UNPAK.S.txt` -- PAKME decompressor; BLBITS=0 path at lines 15-17
- `SHARED/X.PAK.S.txt` -- PAKME compressor (original algorithm)
- `SHARED/X.ARC.S.txt` -- ARC compressor (new algorithm, migration in progress)
- `BIN/PAKME.S.txt` -- PAKME application (detects magic footer, compresses BINs)
- `SCMASM.30/SCMASM.S.DIR2.txt` -- .IN/.INB directive handler source
- `cmake/A2osXHelpers.cmake` -- staging setup (symlinks source tree)
- `cmake/CreateImage.cmake` -- disk image build (uses prodos_asset target)
- `docs/adr/001-prodos-fx-vs-243-compatibility.md` -- ProDOS FX compatibility strategy

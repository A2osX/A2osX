# A2osX xasm++ Branch Changes

Changes made on the `xasm++_master` branch relative to upstream `origin/master`.
All changes fix upstream source issues introduced during SRC REORG commits that left
the tree in an unassemblable state. None are xasm++ workarounds — any assembler
would fail on the same issues.

---

## Branch Structure

```
origin/master (92965a78 DOC REORG #4)
  +-- xasm++_master      Upstream source fixes + cmake build (this branch)
        +-- xasm++_binv2 BIN Layout v2 header format for all BIN/SBIN binaries
              +-- xasm++_features  /bin/jobs, /bin/fg, /sbin/loadapp
              +-- xasm++_issues    httpget/telnetd fixes; SOCK.Close (#188)
```

---

## xasm++_master Commits (on top of 92965a78)

### 5bd8cacb — Restore deleted INC files; add net.skt.i and ProDOS FX zp.i

**Problem:** `f2ec8c3f` (SRC REORG #05) deleted four INC files that source files
still reference with `.INB`. Assembly fails immediately with "file not found".

**Restored files (verbatim from f2ec8c3f~1):**
- `INC/ZP.I.txt` — ProDOS zero-page variable definitions (`ZP.BLKNUM`, `ZP.A2L`, etc.)
- `INC/LIBETALK.I.txt` — AppleTalk LIBETALK dispatch table offsets
- `INC/LIB.NET.I.txt` — LIBNET dispatch table offsets
- `INC/LIBTCPIP.I.txt` — LIBTCPIP dispatch table offsets and constants

**net.skt.i additions:** SRC REORG moved the `S.SA.IN` socket struct into
`NET.SKT.I.txt` but did not update the four files that reference the struct.
Added `.INB inc/net.skt.i` after `.INB inc/ip.i` in:
- `BIN/PING.S.txt`, `BIN/TELNET.S.txt`
- `SBIN/HTTPD.S.txt`, `SBIN/TELNETD.S.txt`

**ProDOS FX zp.i:** The original build assembled each module with its own assembler
invocation, so ZP symbols were always in scope from the start. The cmake build uses
single-pass source `.INB` includes. `ProDOS.S.txt` has `.BS $D540-*` fill directives
that need ZP symbols resolved at that point — without them the fill size overflows.
Added `.INB inc/zp.i` near the top of:
- `ProDOS.FX/ProDOS.S.txt`
- `ProDOS.FX/ProDOS.TINY.S..txt`

---

### 1b1d75fc — Add missing INC definitions and LIB/LIBETALK source split

**Problem:** SRC REORG commits added macro calls and constant references to source
files without adding the corresponding definitions to INC headers.

**INC/MACROS.I.txt:**
- Added `SYSCALL` macro (`ldx #_]1 / jsr A2osX.KAPI`) and `SYSCALL2` macro
  (`jsr A2osX.SYSCALL2`). 113 files call `>KAPI` / `>SYSCALL` — all fail with
  "Undefined macro: KAPI" without this.
- Uncommented `PULLA`, `PULLYA`, `PULLB` stack macros — were commented out in a
  prior cleanup but source files still call them.

**INC/A2osX.I.txt:**
- Added `AF.LOCAL`, `AF.INET`, `AF.APPLETALK` socket address family constants.
- Added `S.FD.DSOCK .EQ 2` — FD struct base offset used by LIBTCPIP.I and
  LIBETALK.I; removed during an FD struct reorganisation but still referenced.
- Added `S.PS.F.EVENT .EQ %00000010` and `S.PW .EQ 14` struct constants.
- Added `.INB inc/a2osx.api.i` so KAPI entry point addresses are visible to all
  files that include `a2osx.i` (~25 targets).

**INC/NIC.I.txt:**
- Added `S.DCB.NIC.FLAGS.ARPOFFLOAD` and `S.DCB.NIC.FLAGS.IPOFFLOAD` flag bits
  (renamed to `.F.` style in a reorg; still referenced by old name).

**INC/NET.DHCP.I.txt:**
- Added `S.DHCP.OPTIONS.DHCPDiscover .EQ 1` and `S.DHCP.OPTIONS.DHCPRequest .EQ 3`
  shorthand constants used by `SYS/PM.VEDRIVE.S.txt`.

**INC/LIBTUI.I.txt:**
- Added `LIBTUI.Destroy .EQ 28` and `LIBTUI.Run .EQ 30` dispatch offsets.

**LIB/LIBETALK split:**
The cmake build has a `lib_libetalk` target that assembles `LIB/LIBETALK.S.txt`.
That master file did not exist upstream — LIBETALK was one large file. Created
`LIB/LIBETALK.S.txt` as a master that `.INB`-includes per-protocol sub-files:
`LIBETALK.S.AARP`, `ADSP`, `AEP`, `ATP`, `CFG`, `DDP`, `ELAP`, `FRM`, `NBP`,
`RTMP`, `SKT`, `ZIP`.

---

### 2959021f — Add SYS/VEDRIVE.CONF.txt

The cmake build has a `sys_vedrive_conf` target that installs `SYS/VEDRIVE.CONF.txt`
into the disk image as a text file. The file was missing from the upstream source
tree — cmake fails with "No rule to make target" without it.

Content: default VEDrive network driver configuration (NIC type, slot, MAC address).

---

### df0fa22a — Replace >PSTR with .PS; remove PR#3 preamble

**`>PSTR` fix (`BIN/NFSMOUNT.S.txt`, `SBIN/NFSD.S.txt`):**
Both files use `>PSTR "libtcpip.o"` to store a length-prefixed Pascal string.
`PSTR` is not defined in MACROS.I or anywhere else — it was a macro from an older
build environment. The xasm++ (and SCMASM) built-in directive for Pascal strings
is `.PS`. Replaced `>PSTR "libtcpip.o"` with `.PS "libtcpip.o"`.

**`PR#3` removal (`SBIN/NFSD.S.txt`):**
The first line of the file is literally `PR#3` — the Apple II command to activate
slot 3 (80-column card). A stray line left over from interactive Applesoft or
copy-paste. Not valid assembly; causes an immediate parse error. Removed.

---

### 56ea8f14 — cmake build system

Adds cmake build infrastructure to assemble all A2osX sources with xasm++ and
produce bootable 800K ProDOS FX disk images:
- `a2osx-mini.po` (MINI800) — kernel + shell + core utilities
- `a2osx-full.po` (FULL800) — complete distribution

ProDOS FX boot blocks assembled from source (`SHARED/X.BB.FX.S.txt`,
`SHARED/X.BB.SOS.S.txt`) rather than binary blobs.

---

## xasm++_binv2 Commits (on top of xasm++_master)

### 2d0ae4fb — BIN Layout v2 header format for all BIN/SBIN binaries

Updates all binary file headers from Layout v1 (relative `CS.END-CS.START` /
`DS.END-DS.START` sizes) to Layout v2 (absolute `CS.END`, `DS.END`, `ID.END`
relocation table entries) for the A2osX v2 binary loader.

Files: `BIN/AARP`, `ACC`, `ACOS`, `ADT`, `ATBROWSE`, `ATLOGON`, `ATMOUNT`, `CSH`,
`DNSINFO`, `ETCONFIG`, `FNT2FON`, `GOPHER`, `HMACMD5`, `HTTPGET`, `IRC`, `MD4`,
`MD5`, `NETCONFIG`, `NFSMOUNT`, `NTPDATE`, `USERADD`, `USERDEL`, `USERMOD`, `WHO`;
`SBIN/BBSD`, `CIFSD`, `NFSD`, `VEDD`.

### 23c056fe — Restore ZP.WNDTOP/CV in A2osX.S.txt; fix cmake .i cache staleness

**Problem:** `f2ec8c3f` (SRC REORG #05) removed `.INB inc/zp.i` from `A2osX.S.txt`,
but `A2osX.ScreenDLGR` still uses `ZP.WNDTOP` and `ZP.CV`. Without `zp.i`, both
symbols resolved to 0. The generated code stored the window-top value (20) to
ZP `$00` (`TmpPtr1`) instead of `$22`/`$25`. The text scroll window was never
constrained to the bottom 4 rows, so stale screen content (colorful garbage)
appeared in the mixed-mode text area during logo display — visible as artifacts
in the 4 bottom text rows while the DHGR logo was shown.

**Also fixed:** `cmake/A2osXHelpers.cmake` step-1 `.i`-file copy had a `NOT EXISTS`
guard that left `inc/rom.ii.i` as a stale 100-line cache (ROM calls only) when
`INC/ROM.II.txt` grew to 139 lines (ZP + ROM calls). Guard removed so `.i` files
are always refreshed from their source.

---

## Notes

- `SBIN/CIFSD.S.CORE.txt`: upstream uses `&CheckSMBStatus` (column-0 label with
  `&` prefix). xasm++ supports this natively as of commit `1679721` — no source
  change needed.
- All branches use the local xasm++ binary at build time:
  `cmake -S . -B build -DXASMPP=/path/to/xasm++/build/bin/xasm++`

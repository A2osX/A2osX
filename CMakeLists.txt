cmake_minimum_required(VERSION 3.20)
project(A2osX ASM)

# ─── Tool paths ────────────────────────────────────────────────────────────────

find_program(CADIUS cadius REQUIRED)
find_program(JAVA   java   REQUIRED)
find_program(XASMPP xasm++ PATHS /usr/local/bin REQUIRED)

set(ACX_JAR "" CACHE FILEPATH "Path to AppleCommander acx.jar")

# Auto-detect acx.jar from known locations
if(NOT ACX_JAR OR NOT EXISTS "${ACX_JAR}")
    set(_acx_jar_search_paths
        /usr/local/share/java
        /usr/local/share/applecommander
        /usr/local/lib)
    # Expand $HOME explicitly (find_file doesn't expand $ENV{} in PATHS)
    file(TO_CMAKE_PATH "$ENV{HOME}" _HOME)
    list(APPEND _acx_jar_search_paths "${_HOME}/Projects/Vintage/Apple/samples")
    find_file(_ACX_JAR_FOUND acx.jar PATHS ${_acx_jar_search_paths} NO_DEFAULT_PATH)
    if(_ACX_JAR_FOUND)
        set(ACX_JAR "${_ACX_JAR_FOUND}" CACHE FILEPATH "Path to AppleCommander acx.jar" FORCE)
    endif()
endif()
if(ACX_JAR AND EXISTS "${ACX_JAR}")
    message(STATUS "AppleCommander acx: ${ACX_JAR}")
endif()

# ─── xasm++ flags ──────────────────────────────────────────────────────────────

set(XASMPP_FLAGS --cpu 65c02 --syntax scmasm --relax-branches)

# ─── Staging tree ──────────────────────────────────────────────────────────────

set(STAGE_DIR  ${CMAKE_BINARY_DIR}/stage)
set(ASSETS_DIR ${CMAKE_BINARY_DIR}/assets)

# ─── ProDOS templates ──────────────────────────────────────────────────────────

set(PRODOS_TEMPLATE "" CACHE FILEPATH "Path to blank140k.po")

# Auto-detect 140K template from known locations
if(NOT PRODOS_TEMPLATE OR NOT EXISTS "${PRODOS_TEMPLATE}")
    find_file(PRODOS_TEMPLATE blank140k.po
        PATHS
            ${CMAKE_SOURCE_DIR}/../tools/scmasm/prodos
            /usr/local/share/a2osx
        NO_DEFAULT_PATH)
endif()
if(PRODOS_TEMPLATE AND EXISTS "${PRODOS_TEMPLATE}")
    message(STATUS "ProDOS template: ${PRODOS_TEMPLATE}")
endif()

# ─── 800K ProDOS FX template (generated from source) ─────────────────────────
#
# blank800k_prodosfx.po is generated at build time — no binary blobs needed.
# CreateBlank800k.cmake:
#   1. acx create --prodos --prodos-order -s 800K creates blank 800K ProDOS volume structure
#   2. xasm++ assembles SHARED/X.BB.FX.S.txt  -> block 0 (ProDOS FX bootstrap, canonical source)
#   3. xasm++ assembles SHARED/X.BB.SOS.S.txt -> block 1 (SOS BOOT 1.1, IIgs compat)
#   Both boot blocks are patched into the image.

set(PRODOS800_TEMPLATE  ${CMAKE_BINARY_DIR}/blank800k_prodosfx.po)
set(BOOT0_SOURCE        ${CMAKE_SOURCE_DIR}/SHARED/X.BB.FX.S.txt)
set(SOS_BOOT_SOURCE     ${CMAKE_SOURCE_DIR}/SHARED/X.BB.SOS.S.txt)

if(NOT ACX_JAR OR NOT EXISTS "${ACX_JAR}")
    message(FATAL_ERROR "AppleCommander acx.jar not found.\n"
            "Set ACX_JAR=/path/to/acx.jar or place it in ~/Projects/Vintage/Apple/samples/")
endif()

foreach(_src BOOT0_SOURCE SOS_BOOT_SOURCE)
    if(NOT EXISTS "${${_src}}")
        message(FATAL_ERROR "Boot source not found: ${${_src}}")
    endif()
endforeach()
message(STATUS "ProDOS 800K tmpl: ${PRODOS800_TEMPLATE} (generated)")

# ─── cmake helpers ─────────────────────────────────────────────────────────────

include(cmake/A2osXHelpers.cmake)

# ─── Staging setup ─────────────────────────────────────────────────────────────

a2osx_setup_staging()

# ─── ProDOS FX asset (assembled from source) ───────────────────────────────────

file(MAKE_DIRECTORY ${ASSETS_DIR})
add_custom_command(
    OUTPUT  ${ASSETS_DIR}/PRODOS
    COMMAND ${CMAKE_COMMAND} -E make_directory ${ASSETS_DIR}
    COMMAND ${XASMPP}
            --cpu 65816 --syntax scmasm --relax-branches
            -I ${STAGE_DIR}
            -o ${ASSETS_DIR}/PRODOS
            -- "usr/src/prodos.fx/prodos.s"
    WORKING_DIRECTORY ${STAGE_DIR}
    DEPENDS ${CMAKE_SOURCE_DIR}/ProDOS.FX/ProDOS.S.txt
    COMMENT "Assembling ProDOS FX"
)
add_custom_target(prodos_asset DEPENDS ${ASSETS_DIR}/PRODOS)

# ─── 800K template generation ─────────────────────────────────────────────────
#
# Generates blank800k_prodosfx.po in the build directory.
# Depends on prodos_asset so the PRODOS SYS file is assembled first.

add_custom_command(
    OUTPUT  ${PRODOS800_TEMPLATE}
    COMMAND ${CMAKE_COMMAND}
            -DOUTPUT_IMAGE=${PRODOS800_TEMPLATE}
            -DBOOT0_SOURCE=${BOOT0_SOURCE}
            -DSOS_BOOT_SOURCE=${SOS_BOOT_SOURCE}
            -DPYTHON=python3
            -DXASMPP=${XASMPP}
            -DACX_JAR=${ACX_JAR}
            -DJAVA=${JAVA}
            -P ${CMAKE_SOURCE_DIR}/cmake/CreateBlank800k.cmake
    DEPENDS ${BOOT0_SOURCE} ${SOS_BOOT_SOURCE}
    COMMENT "Generating blank800k_prodosfx.po from source"
)
add_custom_target(blank800k_template DEPENDS ${PRODOS800_TEMPLATE})

# ─── Boot logo (ProDOS PIC $CB) ─────────────────────────────────────────────────

add_custom_command(
    OUTPUT  ${STAGE_DIR}/A2osX.logo
    COMMAND ${CMAKE_COMMAND} -E make_directory ${STAGE_DIR}
    COMMAND python3 ${CMAKE_SOURCE_DIR}/cmake/bmp2logo.py
                    ${CMAKE_SOURCE_DIR}/_Pics/A2osX.logo.bmp
                    ${STAGE_DIR}/A2osX.logo
    DEPENDS ${CMAKE_SOURCE_DIR}/_Pics/A2osX.logo.bmp
            ${CMAKE_SOURCE_DIR}/cmake/bmp2logo.py
    COMMENT "Converting A2osX boot logo"
)
add_custom_target(a2osx_logo DEPENDS ${STAGE_DIR}/A2osX.logo)

# ─── A2osX system loader ────────────────────────────────────────────────────────

a2osx_assemble(a2osx_system A2osX.S.txt A2OSX.SYSTEM FF 2000)

# ─── Kernel ────────────────────────────────────────────────────────────────────

a2osx_assemble(kernel        SYS/KERNEL.S.txt      sys/kernel     FF 2000)
a2osx_assemble(sys_km_inet   SYS/KM.INET.S.txt     sys/km.inet    FF 2000)
a2osx_assemble(sys_km_pascal SYS/KM.PASCAL.S.txt   sys/km.pascal  FF 2000)

# ─── BIN ───────────────────────────────────────────────────────────────────────

a2osx_assemble(bin_aarp      BIN/AARP.S.txt        bin/aarp       06 2000)
a2osx_assemble(bin_acc       BIN/ACC.S.txt         bin/acc        06 2000)
a2osx_assemble(bin_acos      BIN/ACOS.S.txt        bin/acos       06 2000)
a2osx_assemble(bin_adt       BIN/ADT.S.txt         bin/adt        06 2000)
a2osx_assemble(bin_arc       BIN/ARC.S.txt         bin/arc        06 2000)
a2osx_assemble(bin_arcme     BIN/ARCME.S.txt       bin/arcme      06 2000)
a2osx_assemble(bin_arp       BIN/ARP.S.txt         bin/arp        06 2000)
a2osx_assemble(bin_asm       BIN/ASM.S.txt         bin/asm        06 2000)
a2osx_assemble(bin_asm_6502  BIN/ASM.6502.S.txt    bin/asm.6502   06 2000)
a2osx_assemble(bin_asm_65816 BIN/ASM.65816.S.txt   bin/asm.65816  06 2000)
a2osx_assemble(bin_asm_65c02 BIN/ASM.65C02.S.txt   bin/asm.65C02  06 2000)
a2osx_assemble(bin_asm_65r02 BIN/ASM.65R02.S.txt   bin/asm.65R02  06 2000)
a2osx_assemble(bin_asm_sw16  BIN/ASM.SW16.S.txt    bin/asm.SW16   06 2000)
a2osx_assemble(bin_asm_z80   BIN/ASM.Z80.S.txt     bin/asm.Z80    06 2000)
a2osx_assemble(bin_atbrowse  BIN/ATBROWSE.S.txt    bin/atbrowse   06 2000)
a2osx_assemble(bin_atlogon   BIN/ATLOGON.S.txt     bin/atlogon    06 2000)
a2osx_assemble(bin_atmount   BIN/ATMOUNT.S.txt     bin/atmount    06 2000)
a2osx_assemble(bin_attr      BIN/ATTR.S.txt        bin/attr       06 2000)
a2osx_assemble(bin_bf        BIN/BF.S.txt          bin/bf         06 2000)
a2osx_assemble(bin_bmp2pix   BIN/BMP2PIX.S.txt     bin/bmp2pix    06 2000)
a2osx_assemble(bin_cat       BIN/CAT.S.txt         bin/cat        06 2000)
a2osx_assemble(bin_cc        BIN/CC.S.txt          bin/cc         06 2000)
a2osx_assemble(bin_chaux     BIN/CHAUX.S.txt       bin/chaux      06 2000)
a2osx_assemble(bin_chgrp     BIN/CHGRP.S.txt       bin/chgrp      06 2000)
a2osx_assemble(bin_chmod     BIN/CHMOD.S.txt       bin/chmod      06 2000)
a2osx_assemble(bin_chown     BIN/CHOWN.S.txt       bin/chown      06 2000)
a2osx_assemble(bin_chtyp     BIN/CHTYP.S.txt       bin/chtyp      06 2000)
a2osx_assemble(bin_cmp       BIN/CMP.S.txt         bin/cmp        06 2000)
a2osx_assemble(bin_cp        BIN/CP.S.txt          bin/cp         06 2000)
a2osx_assemble(bin_csh       BIN/CSH.S.txt         bin/csh        06 2000)
a2osx_assemble(bin_cut       BIN/CUT.S.txt         bin/cut        06 2000)
a2osx_assemble(bin_dnsinfo   BIN/DNSINFO.S.txt     bin/dnsinfo    06 2000)
a2osx_assemble(bin_du        BIN/DU.S.txt          bin/du         06 2000)
a2osx_assemble(bin_edit      BIN/EDIT.S.txt        bin/edit       06 2000)
a2osx_assemble(bin_etconfig  BIN/ETCONFIG.S.txt    bin/etconfig   06 2000)
a2osx_assemble(bin_fnt2fon   BIN/FNT2FON.S.txt     bin/fnt2fon    06 2000)
a2osx_assemble(bin_font2fon  BIN/FONT2FON.S.txt    bin/font2fon   06 2000)
a2osx_assemble(bin_format    BIN/FORMAT.S.txt      bin/format     06 2000)
a2osx_assemble(bin_forth     BIN/FORTH.S.txt       bin/forth      06 2000)
a2osx_assemble(bin_gopher    BIN/GOPHER.S.txt      bin/gopher     06 2000)
a2osx_assemble(bin_grep      BIN/GREP.S.txt        bin/grep       06 2000)
a2osx_assemble(bin_hmacmd5   BIN/HMACMD5.S.txt     bin/hmacmd5    06 2000)
a2osx_assemble(bin_httpget   BIN/HTTPGET.S.txt     bin/httpget    06 2000)
a2osx_assemble(bin_ifconfig  BIN/IFCONFIG.S.txt    bin/ifconfig   06 2000)
a2osx_assemble(bin_irc       BIN/IRC.S.txt         bin/irc        06 2000)
a2osx_assemble(bin_kconfig   BIN/KCONFIG.S.txt     bin/kconfig    06 2000)
a2osx_assemble(bin_kill      BIN/KILL.S.txt        bin/kill       06 2000)
a2osx_assemble(bin_lc        BIN/LC.S.txt          bin/lc         06 2000)
a2osx_assemble(bin_ls        BIN/LS.S.txt          bin/ls         06 2000)
a2osx_assemble(bin_lsdev     BIN/LSDEV.S.txt       bin/lsdev      06 2000)
a2osx_assemble(bin_lsfd      BIN/LSFD.S.txt        bin/lsfd       06 2000)
a2osx_assemble(bin_lsof      BIN/LSOF.S.txt        bin/lsof       06 2000)
a2osx_assemble(bin_mac2unix  BIN/MAC2UNIX.S.txt    bin/mac2unix   06 2000)
a2osx_assemble(bin_man       BIN/MAN.S.txt         bin/man        06 2000)
a2osx_assemble(bin_md4       BIN/MD4.S.txt         bin/md4        06 2000)
a2osx_assemble(bin_md5       BIN/MD5.S.txt         bin/md5        06 2000)
a2osx_assemble(bin_mem       BIN/MEM.S.txt         bin/mem        06 2000)
a2osx_assemble(bin_memdump   BIN/MEMDUMP.S.txt     bin/memdump    06 2000)
a2osx_assemble(bin_mkdir     BIN/MKDIR.S.txt       bin/mkdir      06 2000)
a2osx_assemble(bin_more      BIN/MORE.S.txt        bin/more       06 2000)
a2osx_assemble(bin_mv        BIN/MV.S.txt          bin/mv         06 2000)
a2osx_assemble(bin_netconfig BIN/NETCONFIG.S.txt   bin/netconfig  06 2000)
a2osx_assemble(bin_netstat   BIN/NETSTAT.S.txt     bin/netstat    06 2000)
a2osx_assemble(bin_nfsmount  BIN/NFSMOUNT.S.txt    bin/nfsmount   06 2000)
a2osx_assemble(bin_nl        BIN/NL.S.txt          bin/nl         06 2000)
a2osx_assemble(bin_nscutil   BIN/NSCUTIL.S.txt     bin/nscutil    06 2000)
a2osx_assemble(bin_ntpdate   BIN/NTPDATE.S.txt     bin/ntpdate    06 2000)
a2osx_assemble(bin_od        BIN/OD.S.txt          bin/od         06 2000)
a2osx_assemble(bin_pak       BIN/PAK.S.txt         bin/pak        06 2000)
a2osx_assemble(bin_pakme     BIN/PAKME.S.txt       bin/pakme      06 2000)
a2osx_assemble(bin_ping      BIN/PING.S.txt        bin/ping       06 2000)
a2osx_assemble(bin_ps        BIN/PS.S.txt          bin/ps         06 2000)
a2osx_assemble(bin_rm        BIN/RM.S.txt          bin/rm         06 2000)
a2osx_assemble(bin_route     BIN/ROUTE.S.txt       bin/route      06 2000)
a2osx_assemble(bin_sed       BIN/SED.S.txt         bin/sed        06 2000)
a2osx_assemble(bin_seq       BIN/SEQ.S.txt         bin/seq        06 2000)
a2osx_assemble(bin_sh        BIN/SH.S.txt          bin/sh         06 2000)
a2osx_assemble(bin_shutdown  BIN/SHUTDOWN.S.txt    bin/shutdown   06 2000)
a2osx_assemble(bin_spdiag    BIN/SPDIAG.S.txt      bin/spdiag     06 2000)
a2osx_assemble(bin_stat      BIN/STAT.S.txt        bin/stat       06 2000)
a2osx_assemble(bin_telnet    BIN/TELNET.S.txt      bin/telnet     06 2000)
a2osx_assemble(bin_term      BIN/TERM.S.txt        bin/term       06 2000)
a2osx_assemble(bin_uc        BIN/UC.S.txt          bin/uc         06 2000)
a2osx_assemble(bin_uname     BIN/UNAME.S.txt       bin/uname      06 2000)
a2osx_assemble(bin_unarc     BIN/UNARC.S.txt       bin/unarc      06 2000)
a2osx_assemble(bin_unix2mac  BIN/UNIX2MAC.S.txt    bin/unix2mac   06 2000)
a2osx_assemble(bin_unpak     BIN/UNPAK.S.txt       bin/unpak      06 2000)
a2osx_assemble(bin_useradd   BIN/USERADD.S.txt     bin/useradd    06 2000)
a2osx_assemble(bin_userdel   BIN/USERDEL.S.txt     bin/userdel    06 2000)
a2osx_assemble(bin_usermod   BIN/USERMOD.S.txt     bin/usermod    06 2000)
a2osx_assemble(bin_vi        BIN/VI.S.txt          bin/vi         06 2000)
a2osx_assemble(bin_wc        BIN/WC.S.txt          bin/wc         06 2000)
a2osx_assemble(bin_who       BIN/WHO.S.txt         bin/who        06 2000)
a2osx_assemble(bin_xargs     BIN/XARGS.S.txt       bin/xargs      06 2000)
a2osx_assemble(bin_xmastree  BIN/XMASTREE.S.txt    bin/xmastree   06 2000)

# ─── BIN text scripts (ProDOS TXT $04) ───────────────────────────────────────
# Note: ATLOGOFF, GROUPADD, GROUPDEL, GROUPMOD, PASSWD, SU, SUDO, UMOUNT are
# currently empty stub files in master — omitted until implemented.
a2osx_textfile(bin_adm       BIN/ADM.txt           bin/adm        0000)
a2osx_textfile(bin_help      BIN/HELP.txt          bin/help       0000)
a2osx_textfile(bin_which     BIN/WHICH.txt         bin/which      0000)

# ─── DRV ─────────────────────────────────────────────────────────────────────

a2osx_assemble(drv_dan2eth   DRV/DAN2ETH.DRV.S.txt   drv/dan2eth.drv    06 2000)
a2osx_assemble(drv_dhgr      DRV/DHGR.DRV.S.txt      drv/dhgr.drv       06 2000)
a2osx_assemble(drv_grappler  DRV/GRAPPLER.DRV.S.txt  drv/grappler.drv   06 2000)
a2osx_assemble(drv_grapplerp DRV/GRAPPLERP.DRV.S.txt drv/grapplerp.drv  06 2000)
a2osx_assemble(drv_hgr       DRV/HGR.DRV.S.txt       drv/hgr.drv        06 2000)
a2osx_assemble(drv_lancegs   DRV/LANCEGS.DRV.S.txt   drv/lancegs.drv    06 2000)
a2osx_assemble(drv_mkboard   DRV/MKBOARD.DRV.S.txt   drv/mkboard.drv    06 2000)
a2osx_assemble(drv_mouse     DRV/MOUSE.DRV.S.txt     drv/mouse.drv      06 2000)
a2osx_assemble(drv_pic       DRV/PIC.DRV.S.txt       drv/pic.drv        06 2000)
a2osx_assemble(drv_pppssc    DRV/PPPSSC.DRV.S.txt    drv/pppssc.drv     06 2000)
a2osx_assemble(drv_sptape    DRV/SPTAPE.DRV.S.txt    drv/sptape.drv     06 2000)
a2osx_assemble(drv_ssc       DRV/SSC.DRV.S.txt       drv/ssc.drv        06 2000)
a2osx_assemble(drv_ssc_i     DRV/SSC.I.DRV.S.txt     drv/ssc.i.drv      06 2000)
a2osx_assemble(drv_uthernet  DRV/UTHERNET.DRV.S.txt  drv/uthernet.drv   06 2000)
a2osx_assemble(drv_uthernet2 DRV/UTHERNET2.DRV.S.txt drv/uthernet2.drv  06 2000)
a2osx_assemble(drv_uther2ai  DRV/UTHER2.AI.DRV.S.txt drv/uther2.ai.drv  06 2000)
a2osx_assemble(drv_udeth     DRV/UDETH.DRV.S.txt     drv/udeth.drv      06 2000)
a2osx_assemble(drv_udeth_d   DRV/UDETH.D.DRV.S.txt   drv/udeth.d.drv    06 2000)

# ─── LIB ─────────────────────────────────────────────────────────────────────
# Note: LIBPAK and LIBTCPIP are no longer standalone — LIBTCPIP is produced
# by km.inet; LIBPAK was removed from master source.

a2osx_assemble(lib_libblkdev   LIB/LIBBLKDEV.S.txt     lib/libblkdev      06 2000)
a2osx_assemble(lib_libblkdev_o LIB/LIBBLKDEV.O.S.txt   lib/libblkdev.o    06 0000)
a2osx_assemble(lib_libcrypt    LIB/LIBCRYPT.S.txt      lib/libcrypt       06 2000)
a2osx_assemble(lib_libgui      LIB/LIBGUI.S.txt        lib/libgui         06 2000)
a2osx_assemble(lib_libgui_o    LIB/LIBGUI.O.S.txt      lib/libgui.o       06 0000)
a2osx_assemble(lib_libtui      LIB/LIBTUI.S.txt        lib/libtui         06 2000)
# LIBTUI.O.S.txt has a space in the filename upstream — use the full path
a2osx_assemble(lib_libtui_o    "LIB/LIBTUI.O.S .txt"  lib/libtui.o       06 0000)

a2osx_assemble(lib_libetalk    LIB/LIBETALK.S.txt      lib/libetalk       06 2000)

# ─── SBIN ────────────────────────────────────────────────────────────────────

a2osx_assemble(sbin_bbsd     SBIN/BBSD.S.txt          sbin/bbsd          06 2000)
a2osx_assemble(sbin_cifsd    SBIN/CIFSD.S.txt         sbin/cifsd         06 2000)
a2osx_assemble(sbin_getty    SBIN/GETTY.S.txt         sbin/getty         06 2000)
a2osx_assemble(sbin_gui      SBIN/GUI.S.txt           sbin/gui           06 2000)
a2osx_assemble(sbin_httpd    SBIN/HTTPD.S.txt         sbin/httpd         06 2000)
a2osx_assemble(sbin_init     SBIN/INITD.S.txt         sbin/initd         06 2000)
a2osx_assemble(sbin_insdrv   SBIN/INSDRV.S.txt        sbin/insdrv        06 2000)
a2osx_assemble(sbin_login    SBIN/LOGIN.S.txt         sbin/login         06 2000)
a2osx_assemble(sbin_nfsd     SBIN/NFSD.S.txt          sbin/nfsd          06 2000)
a2osx_assemble(sbin_telnetd  SBIN/TELNETD.S.txt       sbin/telnetd       06 2000)
a2osx_assemble(sbin_vedd     SBIN/VEDD.S.txt          sbin/vedd          06 2000)

# ─── SYS / Platform Modules ──────────────────────────────────────────────────
# PM.VEDRIVE moved to ProDOS.FX/ in master.

a2osx_assemble(sys_pm_vedrive  ProDOS.FX/PM.VEDRIVE.S.txt  sys/pm.vedrive  06 2000)

# ─── SYS text config files (ProDOS TXT $04) ──────────────────────────────────

a2osx_textfile(sys_vedrive_conf SYS/VEDRIVE.CONF.txt sys/vedrive.conf 0000)

# ─── Mini image (800K) ────────────────────────────────────────────────────────

set(MINI_IMAGE ${CMAKE_BINARY_DIR}/a2osx-mini.po)

set(MINI_TARGETS
    prodos_asset
    a2osx_logo
    a2osx_system
    kernel sys_km_inet sys_km_pascal
    bin_cat bin_chtyp bin_cp bin_cut bin_dnsinfo bin_edit bin_grep
    bin_httpget bin_kill bin_ls bin_lsdev bin_lsof bin_md5
    bin_mem bin_mkdir bin_more bin_mv bin_netstat bin_nscutil bin_ping
    bin_ps bin_rm bin_sh bin_shutdown bin_telnet
    drv_ssc drv_ssc_i drv_mouse
    lib_libblkdev lib_libtui lib_libblkdev_o
    sbin_getty sbin_init sbin_insdrv sbin_login sbin_telnetd)

add_custom_command(
    OUTPUT  ${MINI_IMAGE}
    COMMAND ${CMAKE_COMMAND}
            -DCADIUS=${CADIUS} -DJAVA=${JAVA} -DAC_JAR=${AC_JAR}
            -DIMAGE_FILE=${MINI_IMAGE} -DIMAGE_TYPE=800
            -DVOLUME_NAME=MINI800
            -DPRODOS800_TEMPLATE=${PRODOS800_TEMPLATE}
            -DSTAGE_DIR=${STAGE_DIR} -DASSETS_DIR=${ASSETS_DIR}
            -DSRC_DIR=${CMAKE_SOURCE_DIR}
            -P ${CMAKE_SOURCE_DIR}/cmake/CreateImage.cmake
    DEPENDS ${MINI_TARGETS} prodos_asset blank800k_template
    COMMENT "Creating mini 800K image"
)
add_custom_target(mini ALL DEPENDS ${MINI_IMAGE})

# ─── Full image (800K) ────────────────────────────────────────────────────────

set(FULL_IMAGE ${CMAKE_BINARY_DIR}/a2osx-full.po)

set(FULL_TARGETS
    prodos_asset
    a2osx_logo
    a2osx_system
    kernel sys_km_inet sys_km_pascal
    bin_aarp bin_acc bin_acos bin_arc bin_arcme bin_arp bin_asm
    bin_asm_6502 bin_asm_65816 bin_asm_65c02 bin_asm_65r02
    bin_asm_sw16 bin_asm_z80
    bin_atbrowse bin_atlogon bin_atmount
    bin_attr bin_bf bin_bmp2pix
    bin_cat bin_cc bin_chaux bin_chgrp bin_chmod bin_chown bin_chtyp
    bin_cmp bin_cp bin_csh bin_cut bin_dnsinfo bin_du bin_edit
    bin_etconfig bin_fnt2fon bin_font2fon bin_format bin_forth bin_gopher
    bin_grep bin_hmacmd5 bin_httpget bin_ifconfig bin_irc
    bin_kconfig bin_kill bin_lc bin_ls bin_lsdev bin_lsfd bin_lsof
    bin_mac2unix bin_man bin_md4 bin_md5 bin_mem bin_memdump bin_mkdir bin_more bin_mv
    bin_netconfig bin_netstat bin_nfsmount bin_nl bin_nscutil bin_ntpdate bin_od
    bin_pak bin_pakme bin_ping bin_ps bin_rm bin_route
    bin_sed bin_seq bin_sh bin_shutdown bin_spdiag bin_stat
    bin_telnet bin_term bin_uc bin_uname bin_unarc bin_unix2mac bin_unpak
    bin_useradd bin_userdel bin_usermod bin_vi bin_wc bin_who bin_xargs bin_xmastree
    bin_adm bin_help bin_which
    drv_dan2eth drv_dhgr drv_grappler drv_grapplerp drv_hgr drv_lancegs
    drv_mkboard drv_mouse drv_pic drv_pppssc drv_sptape
    drv_ssc drv_ssc_i drv_uthernet drv_uthernet2 drv_uther2ai
    drv_udeth drv_udeth_d
    lib_libblkdev lib_libblkdev_o lib_libcrypt lib_libetalk
    lib_libgui lib_libgui_o lib_libtui lib_libtui_o
    sbin_bbsd sbin_cifsd sbin_getty sbin_gui sbin_httpd sbin_init
    sbin_insdrv sbin_login sbin_nfsd sbin_telnetd sbin_vedd
    sys_pm_vedrive sys_vedrive_conf)

add_custom_command(
    OUTPUT  ${FULL_IMAGE}
    COMMAND ${CMAKE_COMMAND}
            -DCADIUS=${CADIUS} -DJAVA=${JAVA} -DAC_JAR=${AC_JAR}
            -DIMAGE_FILE=${FULL_IMAGE} -DIMAGE_TYPE=800
            -DVOLUME_NAME=FULL800
            -DPRODOS800_TEMPLATE=${PRODOS800_TEMPLATE}
            -DSTAGE_DIR=${STAGE_DIR} -DASSETS_DIR=${ASSETS_DIR}
            -DSRC_DIR=${CMAKE_SOURCE_DIR}
            -P ${CMAKE_SOURCE_DIR}/cmake/CreateImage.cmake
    DEPENDS ${FULL_TARGETS} prodos_asset blank800k_template
    COMMENT "Creating full 800K image"
)
add_custom_target(full ALL DEPENDS ${FULL_IMAGE})

# ─── Assembly list files (mirrors Remy's native .list files) ──────────────────
#
# Generated at configure time in build/lists/. Format matches the .list files on
# Remy's A2OSX.BUILD disk image exactly: bare names for bin/sbin/lib/drv (no
# path prefix, no .s extension); full /usr/src/... paths for asminet (which
# spans bin/, sbin/ and sys/).
#
# These are Remy's A2osX 1.00 build lists — the files he actively rebuilds with
# his native assembler. Our cmake build assembles a superset (additional drivers,
# daemons, and libraries also present in the source tree) but these lists define
# the validated 1.00 core.
#
# Source: extracted from _Media/A2OSX.BUILD.po (Jan/Feb 2026 build session).

set(LISTS_DIR ${CMAKE_BINARY_DIR}/lists)
file(MAKE_DIRECTORY ${LISTS_DIR})

# asmbin1: core utilities — shell, file ops, text tools (48 entries)
# Remy's script: asm $1 /usr/src/bin/${F}.s
file(WRITE ${LISTS_DIR}/asmbin1.list
"arc
attr
cat
chaux
chgrp
chmod
chown
chtyp
cmp
cp
cut
du
edit
format
grep
kill
lc
ls
lsdev
lsfd
lsof
mac2unix
mem
mkdir
more
mv
nl
nscutil
od
pak
ps
rm
sed
seq
sh
shutdown
spdiag
stat
term
uc
uname
unarc
unix2mac
unpak
vi
wc
xargs
xmastree
")

# asmbin2: assembler suite, compiler, compression tools (11 entries)
# Remy's script: asm $1 /usr/src/bin/${F}.s
file(WRITE ${LISTS_DIR}/asmbin2.list
"arcme
asm
asm.6502
asm.65816
asm.65C02
asm.65R02
asm.SW16
asm.Z80
cc
memdump
pakme
")

# asminet: network/internet utilities — uses full paths because entries span
# sys/, bin/, and sbin/. Remy's script: asm $1 ${F}.s
file(WRITE ${LISTS_DIR}/asminet.list
"/usr/src/sys/km.inet
/usr/src/bin/arp
/usr/src/bin/ifconfig
/usr/src/bin/route
/usr/src/bin/telnet
/usr/src/sbin/telnetd
/usr/src/sbin/httpd
")

# asmsbin: system daemons and boot-time services (4 entries)
# Remy's script: asm $1 /usr/src/sbin/${F}.s
file(WRITE ${LISTS_DIR}/asmsbin.list
"initd
getty
login
insdrv
")

# asmlib: shared libraries (4 entries)
# Remy's script: asm $1 /usr/src/lib/${F}.s
file(WRITE ${LISTS_DIR}/asmlib.list
"libblkdev
libcrypt
libgui
libtui
")

# asmdrv: hardware drivers (7 entries — the actively maintained set)
# Remy's script: asm $1 /usr/src/drv/${F}.s
# Note: additional drivers exist in source (dan2eth, grappler, lancegs, etc.)
# but have not been re-migrated since their initial 2023 builds.
file(WRITE ${LISTS_DIR}/asmdrv.list
"dhgr.drv
hgr.drv
mouse.drv
ssc.drv
ssc.i.drv
uthernet.drv
uthernet2.drv
")

message(STATUS "Assembly lists: ${LISTS_DIR}/asmbin1.list (and asmbin2, asminet, asmsbin, asmlib, asmdrv)")

# ─── clean_tmp ────────────────────────────────────────────────────────────────

add_custom_target(clean_tmp
    COMMAND ${CMAKE_COMMAND} -E rm -f /tmp/a2osx.lst
    COMMAND ${CMAKE_COMMAND} -E rm -f /tmp/a2osx.sym /tmp/a2osx.sym.txt
    COMMAND ${CMAKE_COMMAND} -E rm -rf /tmp/a2osx-build
    COMMENT "Cleaning /tmp assembly artifacts"
)

# cmake/CreateImage.cmake
#
# Creates a bootable A2osX ProDOS disk image for Apple //e (65C02).
# Invoked via:  cmake -P cmake/CreateImage.cmake  with -D variables set.
#
# Required inputs:
#   IMAGE_FILE       output .po path
#   IMAGE_TYPE       140  (140K, 5.25" floppy) or  800  (800K, 3.5"/HD)
#   VOLUME_NAME      ProDOS volume name, e.g. A2OSX
#   STAGE_DIR        directory containing assembled binaries (bin/, sbin/, etc.)
#   ASSETS_DIR       directory containing pre-built assets (PRODOS)
#   SRC_DIR          A2osX source root (for ETC/, ROOT/ text files)
#   CADIUS           path to cadius executable
#   JAVA             path to java executable
#   ACX_JAR          path to acx.jar (AppleCommander CLI)
#   PRODOS_TEMPLATE  path to blank140k.po (used as 140K template)

cmake_minimum_required(VERSION 3.20)

# ─── Helpers ─────────────────────────────────────────────────────────────────

# Run a command and abort on failure
macro(run)
    execute_process(
        COMMAND ${ARGN}
        RESULT_VARIABLE _rc
    )
    if(NOT _rc EQUAL 0)
        message(FATAL_ERROR "Command failed (${_rc}): ${ARGN}")
    endif()
endmacro()

# cadius ADDFILE with ProDOS type annotation.
# cadius identifies type from a '#TTAAAA' suffix on the filename:
#   bin/sh → temp symlink named  sh#062000  → ProDOS file 'sh', type BIN $06 aux $2000
function(cadius_add PRODOS_FOLDER LOCAL_FILE TYPE_HEX AUX_HEX)
    get_filename_component(base "${LOCAL_FILE}" NAME)
    set(typed "${TYPED_DIR}/${base}#${TYPE_HEX}${AUX_HEX}")
    file(CREATE_LINK "${LOCAL_FILE}" "${typed}" SYMBOLIC)
    run(${CADIUS} ADDFILE "${IMAGE_FILE}" "${PRODOS_FOLDER}" "${typed}")
    file(REMOVE "${typed}")
endfunction()

# Create a ProDOS subdirectory (only once per path)
function(cadius_mkdir PRODOS_PATH)
    if(NOT "${PRODOS_PATH}" IN_LIST _CREATED_DIRS)
        run(${CADIUS} CREATEFOLDER "${IMAGE_FILE}" "${PRODOS_PATH}")
        list(APPEND _CREATED_DIRS "${PRODOS_PATH}")
        set(_CREATED_DIRS "${_CREATED_DIRS}" PARENT_SCOPE)
    endif()
endfunction()

# ─── Temp directory for type-annotated symlinks ───────────────────────────────

set(TYPED_DIR "${IMAGE_FILE}.typed")
file(REMOVE_RECURSE "${TYPED_DIR}")
file(MAKE_DIRECTORY "${TYPED_DIR}")
set(_CREATED_DIRS "")
set(VOL "/${VOLUME_NAME}")

# ─── Create blank ProDOS image ────────────────────────────────────────────────
#
# 140K: copy blank140k.po (has ProDOS 2.4.3 + boot blocks already).
#       Delete BASIC.SYSTEM (not needed), rename volume.
#
# 800K: copy blank800k_prodosfx.po (ProDOS FX template — REQUIRED for A2osX
#       GFINFOEX MLI call), then rename volume. Do NOT use acx create without
#       patching boot blocks — produces standard ProDOS boot blocks, not ProDOS FX.

message(STATUS "Creating ProDOS ${IMAGE_TYPE}K image: ${IMAGE_FILE}")

if(IMAGE_TYPE EQUAL 140)

    # Start from blank140k.po — already has PRODOS + proper boot blocks
    file(COPY_FILE "${PRODOS_TEMPLATE}" "${IMAGE_FILE}")

    # Rename to our volume name
    run(${CADIUS} RENAMEVOLUME "${IMAGE_FILE}" "${VOLUME_NAME}")

    # Remove BASIC.SYSTEM (not needed for A2osX)
    execute_process(
        COMMAND ${CADIUS} DELETEFILE "${IMAGE_FILE}" "${VOL}/BASIC.SYSTEM"
        RESULT_VARIABLE _rc)
    # Non-fatal: BASIC.SYSTEM might already be absent in some templates

else()  # 800K — MUST use ProDOS FX template

    if(NOT PRODOS800_TEMPLATE)
        message(FATAL_ERROR "PRODOS800_TEMPLATE not set — cannot create 800K image")
    endif()

    # Copy ProDOS FX template (preserves ProDOS FX boot blocks and PRODOS file)
    file(COPY_FILE "${PRODOS800_TEMPLATE}" "${IMAGE_FILE}")

    # Rename to our volume name
    run(${CADIUS} RENAMEVOLUME "${IMAGE_FILE}" "${VOLUME_NAME}")

    # cadius RENAMEVOLUME patches name bytes in-place but may leave leftover bytes
    # from the template's longer volume name (e.g. "PRODOS2.4.3" → "MINI800.4.3").
    # ProDOS FX reads NAME_LENGTH correctly but some implementations compare more
    # bytes. Zero out the name field past NAME_LENGTH to be safe.
    string(LENGTH "${VOLUME_NAME}" _vname_len)
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E env
            PYTHONDONTWRITEBYTECODE=1
            python3 -c
            "import sys; \
             img=bytearray(open('${IMAGE_FILE}','rb').read()); \
             off=1024+4; nl=img[off]&0x0F; \
             [img.__setitem__(off+1+i,0) for i in range(nl,15)]; \
             open('${IMAGE_FILE}','wb').write(img)"
        RESULT_VARIABLE _rc
    )

    # Replace template's pre-built PRODOS with assembled ProDOS FX
    if(EXISTS "${ASSETS_DIR}/PRODOS")
        execute_process(
            COMMAND ${CADIUS} DELETEFILE "${IMAGE_FILE}" "${VOL}/PRODOS"
            RESULT_VARIABLE _rc)
        # Non-fatal: PRODOS might be absent in some templates
        cadius_add("${VOL}" "${ASSETS_DIR}/PRODOS" FF 2000)
        message(STATUS "Replaced PRODOS with assembled ProDOS FX")
    else()
        message(WARNING "ASSETS_DIR/PRODOS not found — keeping template PRODOS")
    endif()

endif()

# ─── ProDOS directory structure ───────────────────────────────────────────────

foreach(dir bin sbin drv lib sys sys/km etc root)
    cadius_mkdir("${VOL}/${dir}")
endforeach()

# ─── A2osX system loader ──────────────────────────────────────────────────────

cadius_add("${VOL}" "${STAGE_DIR}/A2OSX.SYSTEM" FF 2000)

# ─── Boot logo (ProDOS PIC $CB) ───────────────────────────────────────────────

if(EXISTS "${STAGE_DIR}/A2osX.logo")
    cadius_add("${VOL}" "${STAGE_DIR}/A2osX.logo" CB 0000)
else()
    message(WARNING "A2osX.logo not found in stage -- boot logo will not display")
endif()

# ─── Kernel & modules ────────────────────────────────────────────────────────

cadius_add("${VOL}/sys"    "${STAGE_DIR}/sys/kernel"    FF 2000)
cadius_add("${VOL}/sys/km" "${STAGE_DIR}/sys/km.inet"   FF 2000)
cadius_add("${VOL}/sys/km" "${STAGE_DIR}/sys/km.pascal" FF 2000)
if(EXISTS "${STAGE_DIR}/sys/pm.vedrive")
    cadius_add("${VOL}/sys" "${STAGE_DIR}/sys/pm.vedrive" 06 2000)
endif()

# ─── ETC (text config files, type TXT $04) ────────────────────────────────────

foreach(etcfile INIT ISSUE MOTD HOSTNAME HOSTS)
    set(etc_src "${SRC_DIR}/ETC/${etcfile}.txt")
    if(EXISTS "${etc_src}")
        string(TOLOWER "${etcfile}" lc_etc)
        set(stripped "${TYPED_DIR}/${lc_etc}_stripped")
        set(typed    "${TYPED_DIR}/${lc_etc}#040000")
        # Strip Apple II editor header (NEW / PREFIX / AUTO lines) and
        # normalize line endings to CR-only before adding to disk image.
        execute_process(
            COMMAND python3 -c
                "import re; \
                 src = open('${etc_src}', 'rb').read(); \
                 src = src.replace(b'\\r\\n', b'\\n').replace(b'\\r', b'\\n'); \
                 src = re.sub(b'^( {0,4}NEW| {0,4}PREFIX[^\\n]*| {0,4}AUTO [0-9]+,[0-9]+)\\n', b'', src, flags=re.MULTILINE); \
                 src = re.sub(b'^\\x08*MAN\\n', b'', src, flags=re.MULTILINE); \
                 src = re.sub(b'^TEXT [^\\n]+\\n', b'', src, flags=re.MULTILINE); \
                 src = src.replace(b'\\n', b'\\r'); \
                 open('${stripped}', 'wb').write(src)"
            RESULT_VARIABLE _rc
        )
        if(NOT _rc EQUAL 0)
            message(FATAL_ERROR "Failed to strip ETC/${etcfile}.txt")
        endif()
        file(CREATE_LINK "${stripped}" "${typed}" SYMBOLIC)
        run(${CADIUS} ADDFILE "${IMAGE_FILE}" "${VOL}/etc" "${typed}")
        file(REMOVE "${typed}" "${stripped}")
    endif()
endforeach()

# ─── File list macro: add BIN files from STAGE_DIR ───────────────────────────

macro(add_bin RELPATH)
    set(_f "${STAGE_DIR}/${RELPATH}")
    if(EXISTS "${_f}")
        get_filename_component(_dir "${RELPATH}" DIRECTORY)
        cadius_add("${VOL}/${_dir}" "${_f}" 06 2000)
    else()
        message(WARNING "Skipping missing built file: ${RELPATH}")
    endif()
endmacro()

# Add a ProDOS TXT ($04) file from stage to the image
macro(add_txt RELPATH)
    set(_f "${STAGE_DIR}/${RELPATH}")
    if(EXISTS "${_f}")
        get_filename_component(_dir "${RELPATH}" DIRECTORY)
        cadius_add("${VOL}/${_dir}" "${_f}" 04 0000)
    else()
        message(WARNING "Skipping missing text file: ${RELPATH}")
    endif()
endmacro()

# ─── BIN ─────────────────────────────────────────────────────────────────────

add_bin(bin/cat)
add_bin(bin/chtyp)
add_bin(bin/cp)
add_bin(bin/cut)
add_bin(bin/dnsinfo)
add_bin(bin/edit)
add_bin(bin/grep)
add_bin(bin/httpget)
add_bin(bin/ifconfig)
add_bin(bin/kill)
add_bin(bin/ls)
add_bin(bin/lsdev)
add_bin(bin/lsof)
add_bin(bin/md5)
add_bin(bin/mem)
add_bin(bin/mkdir)
add_bin(bin/more)
add_bin(bin/mv)
add_bin(bin/netstat)
add_bin(bin/nscutil)
add_bin(bin/ping)
add_bin(bin/ps)
add_bin(bin/rm)
add_bin(bin/sh)
add_bin(bin/shutdown)
add_bin(bin/telnet)

if(IMAGE_TYPE EQUAL 800)
    add_bin(bin/aarp)
    add_bin(bin/acc)
    add_bin(bin/acos)
    add_bin(bin/arc)
    add_bin(bin/arcme)
    add_bin(bin/arp)
    add_bin(bin/asm)
    add_bin(bin/attr)
    add_bin(bin/cc)
    add_bin(bin/chmod)
    add_bin(bin/chown)
    add_bin(bin/cmp)
    add_bin(bin/csh)
    add_bin(bin/du)
    add_bin(bin/forth)
    add_bin(bin/hmacmd5)
    add_bin(bin/irc)
    add_bin(bin/kconfig)
    add_bin(bin/lc)
    add_bin(bin/man)
    add_bin(bin/md4)
    add_bin(bin/memdump)
    add_bin(bin/netconfig)
    add_bin(bin/nl)
    add_bin(bin/ntpdate)
    add_bin(bin/od)
    add_bin(bin/pak)
    add_bin(bin/pakme)
    add_bin(bin/route)
    add_bin(bin/sed)
    add_bin(bin/seq)
    add_bin(bin/stat)
    add_bin(bin/uc)
    add_bin(bin/uname)
    add_bin(bin/unarc)
    add_bin(bin/unpak)
    add_bin(bin/useradd)
    add_bin(bin/userdel)
    add_bin(bin/usermod)
    add_bin(bin/vi)
    add_bin(bin/wc)
    add_bin(bin/font2fon)
    add_bin(bin/lsfd)
    add_bin(bin/mac2unix)
    add_bin(bin/unix2mac)
    add_bin(bin/who)
    add_bin(bin/xargs)
endif()

# ─── DRV ─────────────────────────────────────────────────────────────────────

add_bin(drv/lancegs.drv)
add_bin(drv/ssc.drv)
add_bin(drv/ssc.i.drv)
add_bin(drv/uthernet.drv)
add_bin(drv/uthernet2.drv)

if(IMAGE_TYPE EQUAL 800)
    add_bin(drv/dan2eth.drv)
    add_bin(drv/dhgr.drv)
    add_bin(drv/hgr.drv)
    add_bin(drv/mouse.drv)
    add_bin(drv/pppssc.drv)
    add_bin(drv/uther2.ai.drv)
endif()

# ─── LIB ─────────────────────────────────────────────────────────────────────

add_bin(lib/libblkdev)

if(IMAGE_TYPE EQUAL 800)
    add_bin(lib/libcrypt)
    add_bin(lib/libetalk)
    add_bin(lib/libgui)
    add_bin(lib/libtui)
    # lib/libtcpip produced by km_inet — add if present
    add_bin(lib/libtcpip)
endif()

# ─── SBIN ────────────────────────────────────────────────────────────────────

add_bin(sbin/getty)
add_bin(sbin/initd)
add_bin(sbin/insdrv)
add_bin(sbin/login)
add_bin(sbin/telnetd)
# sbin/networkd produced by km_inet — add if present
if(EXISTS "${STAGE_DIR}/sbin/networkd")
    cadius_add("${VOL}/sbin" "${STAGE_DIR}/sbin/networkd" 06 2000)
endif()

if(IMAGE_TYPE EQUAL 800)
    add_bin(sbin/bbsd)
    add_bin(sbin/cifsd)
    add_bin(sbin/gui)
    add_bin(sbin/httpd)
    add_bin(sbin/vedd)
endif()

# ─── BIN text scripts (ProDOS TXT $04) ───────────────────────────────────────

if(IMAGE_TYPE EQUAL 800)
    add_txt(bin/adm)
    add_txt(bin/help)
    add_txt(bin/which)
endif()

# ─── SYS text config files (ProDOS TXT $04) ──────────────────────────────────

if(IMAGE_TYPE EQUAL 800)
    add_txt(sys/vedrive.conf)
endif()

# ─── Cleanup ─────────────────────────────────────────────────────────────────

file(REMOVE_RECURSE "${TYPED_DIR}")

message(STATUS "Image ready: ${IMAGE_FILE}")
execute_process(COMMAND ${CADIUS} CATALOG "${IMAGE_FILE}")

# cmake/CreateBlank800k.cmake
#
# Generates blank800k_prodosfx.po — the 800K ProDOS FX template image.
# Invoked via:  cmake -P cmake/CreateBlank800k.cmake  with -D variables set.
#
# Required inputs:
#   OUTPUT_IMAGE      path to write the generated .po file
#   BOOT0_SOURCE      path to SHARED/X.BB.FX.S.txt  (SCMASM asm, ProDOS FX block 0)
#   SOS_BOOT_SOURCE   path to SHARED/X.BB.SOS.S.txt (SCMASM asm, SOS BOOT 1.1 block 1)
#   PYTHON            path to python3 interpreter
#   XASMPP            path to xasm++ executable
#   ACX_JAR           path to AppleCommander acx.jar
#   JAVA              path to java executable
#   VOLUME_NAME       ProDOS volume name (default: BLANKFX800)
#
# No binary blobs required:
#   - acx.jar creates the blank 800K ProDOS volume structure
#   - xasm++ assembles SHARED/X.BB.FX.S.txt  -> block 0 (ProDOS FX bootstrap, canonical source)
#   - xasm++ assembles SHARED/X.BB.SOS.S.txt -> block 1 (SOS BOOT 1.1, IIgs compat)
#

cmake_minimum_required(VERSION 3.20)

# -- defaults ------------------------------------------------------------------
if(NOT VOLUME_NAME)
    set(VOLUME_NAME "BLANKFX800")
endif()

# -- validate inputs -----------------------------------------------------------
foreach(_var OUTPUT_IMAGE BOOT0_SOURCE SOS_BOOT_SOURCE PYTHON XASMPP ACX_JAR JAVA)
    if(NOT ${_var})
        message(FATAL_ERROR "CreateBlank800k.cmake: ${_var} is required")
    endif()
endforeach()

foreach(_src BOOT0_SOURCE SOS_BOOT_SOURCE)
    if(NOT EXISTS "${${_src}}")
        message(FATAL_ERROR "Source not found: ${${_src}}")
    endif()
endforeach()

# -- working directory ---------------------------------------------------------
get_filename_component(OUTPUT_DIR "${OUTPUT_IMAGE}" DIRECTORY)
file(MAKE_DIRECTORY "${OUTPUT_DIR}")

# -- Step 1: Create blank 800K ProDOS volume using acx.jar --------------------
#
# acx create --prodos --prodos-order -s 800K creates a standard ProDOS-formatted
# 800K image. Its boot blocks will be replaced in steps 2-4 with ProDOS FX boot
# blocks assembled from source.

message(STATUS "CreateBlank800k: creating blank 800K ProDOS image via acx.jar ...")

execute_process(
    COMMAND "${JAVA}" -jar "${ACX_JAR}"
            create
            -d "${OUTPUT_IMAGE}"
            -n "${VOLUME_NAME}"
            -s 800K
            --prodos
            --prodos-order
    RESULT_VARIABLE _ac_result
    ERROR_VARIABLE  _ac_err
)
if(NOT _ac_result EQUAL 0)
    message(FATAL_ERROR "acx.jar failed (${_ac_result}):\n${_ac_err}")
endif()

# -- Step 2: Assemble ProDOS FX block 0 (bootstrap loader) --------------------

set(BOOT0_BIN "${OUTPUT_DIR}/prodosfx_boot0.bin")
message(STATUS "CreateBlank800k: assembling block 0 (ProDOS FX bootstrap) ...")

execute_process(
    COMMAND "${XASMPP}" --cpu 65c02 --syntax scmasm -o "${BOOT0_BIN}" "${BOOT0_SOURCE}"
    RESULT_VARIABLE _asm0_result
    ERROR_VARIABLE  _asm0_err
)
if(NOT _asm0_result EQUAL 0)
    message(FATAL_ERROR "xasm++ failed on ${BOOT0_SOURCE} (${_asm0_result}):\n${_asm0_err}")
endif()

# -- Step 3: Assemble SOS BOOT 1.1 block 1 (IIgs SOS compatibility) -----------

set(SOS_BOOT_BIN "${OUTPUT_DIR}/prodosfx_sos_boot.bin")
message(STATUS "CreateBlank800k: assembling block 1 (SOS BOOT 1.1) ...")

execute_process(
    COMMAND "${XASMPP}" --cpu 65c02 --syntax scmasm -o "${SOS_BOOT_BIN}" "${SOS_BOOT_SOURCE}"
    RESULT_VARIABLE _asm1_result
    ERROR_VARIABLE  _asm1_err
)
if(NOT _asm1_result EQUAL 0)
    message(FATAL_ERROR "xasm++ failed on ${SOS_BOOT_SOURCE} (${_asm1_result}):\n${_asm1_err}")
endif()

# -- Step 4: Patch both boot blocks into the image ----------------------------
#
# Block 0 (bytes    0- 511): ProDOS FX bootstrap loader
# Block 1 (bytes  512-1023): SOS BOOT 1.1 (IIgs SOS compatibility)
# Each block is zero-padded to 512 bytes.

message(STATUS "CreateBlank800k: patching ProDOS FX boot blocks into image ...")

set(_patch_script [=[
import sys
img_path   = sys.argv[1]
boot0_path = sys.argv[2]
boot1_path = sys.argv[3]

img   = bytearray(open(img_path,   'rb').read())
boot0 = open(boot0_path, 'rb').read()
boot1 = open(boot1_path, 'rb').read()

for block_num, data in ((0, boot0), (1, boot1)):
    if len(data) > 512:
        sys.exit(f"Block {block_num} binary too large: {len(data)} bytes (max 512)")
    offset = block_num * 512
    img[offset:offset+len(data)] = data
    for i in range(offset+len(data), offset+512):
        img[i] = 0

open(img_path, 'wb').write(img)
print(f"Patched boot0 ({len(boot0)}B) and boot1 ({len(boot1)}B)")
]=])

file(WRITE "${OUTPUT_DIR}/patch_boot_blocks.py" "${_patch_script}")

execute_process(
    COMMAND "${PYTHON}" "${OUTPUT_DIR}/patch_boot_blocks.py"
                        "${OUTPUT_IMAGE}" "${BOOT0_BIN}" "${SOS_BOOT_BIN}"
    RESULT_VARIABLE _patch_result
    ERROR_VARIABLE  _patch_err
    OUTPUT_VARIABLE _patch_out
)
if(NOT _patch_result EQUAL 0)
    message(FATAL_ERROR "Boot block patch failed (${_patch_result}):\n${_patch_err}")
endif()
message(STATUS "CreateBlank800k: ${_patch_out}")

message(STATUS "CreateBlank800k: ready -> ${OUTPUT_IMAGE}")
# Note: PRODOS is installed/replaced by CreateImage.cmake (DELETEFILE + ADDFILE with type)

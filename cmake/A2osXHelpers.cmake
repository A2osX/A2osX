# cmake/A2osXHelpers.cmake
#
# Helpers for building A2osX with xasm++ targeting Apple //e (65C02 / ProDOS).
#
# Provides:
#   a2osx_setup_staging()  - creates the staging tree xasm++ runs from
#   a2osx_assemble(...)    - defines one assembly build target

# ─── a2osx_setup_staging ─────────────────────────────────────────────────────
#
# xasm++ is invoked with:
#   -I ${STAGE_DIR}         so it finds inc/macros.i regardless of source location
#   WORKING_DIRECTORY STAGE_DIR  so .TF outputs go to the right place
#
# INC/ is copied as real files (not symlinked) — mirrors what the original
# Makefile did with 'cp -RLf inc/', which dereferences symlinks on copy.
#
# Source sub-files (.INB usr/src/shared/x.printf.s etc.) are resolved via
# per-file symlinks in stage/usr/src/<dir>/ named lowercase without .txt.

function(a2osx_setup_staging)
    set(STAGE ${STAGE_DIR})

    # Root-level source files (A2osX.S.txt, A2osX.S.QC.txt, etc.)
    # Linked at both stage root (for the entry-point) and usr/src/ (for .INB).
    file(MAKE_DIRECTORY ${STAGE})
    file(MAKE_DIRECTORY ${STAGE}/usr/src)
    file(GLOB root_src_files "${CMAKE_SOURCE_DIR}/A2osX.*.txt")
    foreach(src_file ${root_src_files})
        get_filename_component(fname ${src_file} NAME)
        string(TOLOWER "${fname}" lc_name)
        string(REGEX REPLACE "\\.txt$" "" lc_name "${lc_name}")
        # stage root (e.g. stage/a2osx.s — entry point for xasm++)
        _a2osx_link_file(${src_file} ${STAGE}/${lc_name})
        # stage/usr/src/ (e.g. stage/usr/src/a2osx.s.qc — for .INB references)
        _a2osx_link_file(${src_file} ${STAGE}/usr/src/${lc_name})
    endforeach()

    # inc/ — copy as real files (dereferences INC/'s internal symlinks).
    # xasm++ cannot reliably follow multi-hop symlink chains; real files are safe.
    file(MAKE_DIRECTORY ${STAGE}/inc)

    # Step 1: copy lowercase .i files that have no corresponding .txt source.
    # Always copy (no NOT EXISTS guard) so stale caches are refreshed when the
    # source changes.  rom.ii.i, rom.iie.i, rom.iigs.i are needed by
    # A2osX.S.txt and ProDOS.FX; they must stay in sync with their .txt sources.
    set(_raw_i_includes
        rom.ii.i    ROM.II.txt
        rom.iie.i   ROM.IIE.txt
        rom.iigs.i  ROM.IIGS.txt
    )
    while(_raw_i_includes)
        list(POP_FRONT _raw_i_includes _i_dest_name _i_src_name)
        set(_i_src "${CMAKE_SOURCE_DIR}/INC/${_i_src_name}")
        set(_i_dst "${STAGE}/inc/${_i_dest_name}")
        if(EXISTS "${_i_src}")
            file(COPY_FILE "${_i_src}" "${_i_dst}")
        endif()
    endwhile()

    # Step 2: copy .txt source includes (overwrite .i copies where names conflict,
    # so the up-to-date .txt version always wins).
    file(GLOB inc_files "${CMAKE_SOURCE_DIR}/INC/*.txt")
    foreach(src_file ${inc_files})
        get_filename_component(fname ${src_file} NAME)
        string(TOLOWER "${fname}" lc_name)
        string(REGEX REPLACE "\\.txt$" "" lc_name "${lc_name}")
        set(dest "${STAGE}/inc/${lc_name}")
        file(COPY_FILE "${src_file}" "${dest}")
    endforeach()

    # usr/src/<subdir>/ per-file symlinks for each source directory
    foreach(SRCDIR BIN SBIN LIB DRV SYS SHARED FSE ProDOS.203 ProDOS.FX)
        string(TOLOWER "${SRCDIR}" lc_subdir)
        _a2osx_link_source_dir(${SRCDIR} usr/src/${lc_subdir})
    endforeach()

    # Extra canonical-name symlinks for SHARED files whose SAVE path differs
    # from the lowercased source filename (discovered by comparing SAVE directives).
    # X.TRKRR.S.txt saves as x.trkr.s (not x.trkrr.s)
    _a2osx_link_file(
        ${CMAKE_SOURCE_DIR}/SHARED/X.TRKRR.S.txt
        ${STAGE}/usr/src/shared/x.trkr.s)
    # X.TWIST.G..txt (note trailing dot) saves as x.twist.g (no trailing dot)
    _a2osx_link_file(
        ${CMAKE_SOURCE_DIR}/SHARED/X.TWIST.G..txt
        ${STAGE}/usr/src/shared/x.twist.g)
endfunction()

# ─── _a2osx_link_source_dir (internal) ───────────────────────────────────────
#
# For every *.txt file in SOURCE_DIR/<UPCASE_DIR>/, creates a symlink at
# stage/<STAGE_SUBDIR>/<lowercase-name-without-.txt>.

function(_a2osx_link_source_dir UPCASE_DIR STAGE_SUBDIR)
    set(src_root ${CMAKE_SOURCE_DIR}/${UPCASE_DIR})
    set(stage_sub ${STAGE_DIR}/${STAGE_SUBDIR})

    if(NOT EXISTS ${src_root})
        return()
    endif()

    file(MAKE_DIRECTORY ${stage_sub})

    file(GLOB src_files "${src_root}/*.txt")
    foreach(src_file ${src_files})
        get_filename_component(fname ${src_file} NAME)
        string(TOLOWER "${fname}" lc_name)
        string(REGEX REPLACE "\\.txt$" "" lc_name "${lc_name}")
        _a2osx_link_file(${src_file} ${stage_sub}/${lc_name})
    endforeach()
endfunction()

# ─── _a2osx_link_file (internal) ─────────────────────────────────────────────

function(_a2osx_link_file SRC DEST)
    if(NOT EXISTS ${DEST})
        file(CREATE_LINK ${SRC} ${DEST} SYMBOLIC)
    endif()
endfunction()

# ─── a2osx_assemble ──────────────────────────────────────────────────────────
#
# Defines a CMake custom target that assembles one A2osX source file.
#
# Usage:
#   a2osx_assemble(<target> <source> <output_path> <prodos_type> <prodos_aux>)
#
# Arguments:
#   target       CMake target name, e.g. bin_sh
#   source       Path to main .S.txt relative to CMAKE_SOURCE_DIR, e.g. BIN/SH.S.txt
#   output_path  ProDOS path the .TF directive writes to, e.g. bin/sh
#   prodos_type  ProDOS file type hex byte, e.g. 06 (BIN) or FF (SYS)
#   prodos_aux   ProDOS aux type hex word, e.g. 2000 or 0000
#
# The .TF directive in each source already controls where xasm++ writes the
# output binary (relative to STAGE_DIR). output_path must match that directive.
#
# ProDOS types used in A2osX:
#   FF / 2000  SYS  — system files (A2OSX.SYSTEM, kernel, kernel modules)
#   06 / 2000  BIN  — user binaries, drivers, libraries
#   04 / 0000  TXT  — text/config files (added separately, not via this function)

function(a2osx_assemble TARGET SOURCE OUTPUT_PATH PRODOS_TYPE PRODOS_AUX)

    # Derive the stage-relative path xasm++ will be invoked with.
    # Root-level files (no directory component) use the symlink at stage root.
    # All other files live under stage/usr/src/<lowercase_dir>/.
    get_filename_component(src_dir  "${SOURCE}" DIRECTORY)
    get_filename_component(src_name "${SOURCE}" NAME)

    string(TOLOWER "${src_name}" lc_name)
    string(REGEX REPLACE "\\.txt$" "" lc_name "${lc_name}")

    if(src_dir STREQUAL "")
        set(stage_src "${lc_name}")
    else()
        string(TOLOWER "${src_dir}" lc_dir)
        set(stage_src "usr/src/${lc_dir}/${lc_name}")
    endif()

    set(output_file ${STAGE_DIR}/${OUTPUT_PATH})
    get_filename_component(output_dir ${output_file} DIRECTORY)

    add_custom_command(
        OUTPUT  ${output_file}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${output_dir}
        COMMAND ${XASMPP} ${XASMPP_FLAGS} -I ${STAGE_DIR} -- ${stage_src}
        WORKING_DIRECTORY ${STAGE_DIR}
        DEPENDS ${CMAKE_SOURCE_DIR}/${SOURCE}
        COMMENT "Assembling ${OUTPUT_PATH}"
        VERBATIM
    )

    add_custom_target(${TARGET} DEPENDS ${output_file})

    # Record ProDOS type metadata for the image creation script
    set_property(GLOBAL APPEND PROPERTY
        A2OSX_FILE_MANIFEST "${OUTPUT_PATH}:${PRODOS_TYPE}:${PRODOS_AUX}")

endfunction()

# ─── a2osx_textfile ──────────────────────────────────────────────────────────
#
# Copies a ProDOS text/script file (.txt) into the staging tree, normalizing
# line endings to CR-only (Apple II convention) and stripping the ProDOS BASIC
# entry header (NEW / PREFIX / AUTO lines) if present.
#
# Usage:
#   a2osx_textfile(<target> <source> <output_path> <prodos_aux>)
#
# Arguments:
#   target       CMake target name, e.g. bin_adm
#   source       Path to source .txt relative to CMAKE_SOURCE_DIR, e.g. BIN/ADM.txt
#   output_path  Stage-relative output path, e.g. bin/adm
#   prodos_aux   ProDOS aux type hex word (usually 0000 for TXT files)
#
# ProDOS type is always 04 (TXT) for files created by this function.

function(a2osx_textfile TARGET SOURCE OUTPUT_PATH PRODOS_AUX)

    set(output_file ${STAGE_DIR}/${OUTPUT_PATH})
    get_filename_component(output_dir ${output_file} DIRECTORY)

    add_custom_command(
        OUTPUT  ${output_file}
        COMMAND ${CMAKE_COMMAND} -E make_directory ${output_dir}
        COMMAND ${CMAKE_COMMAND} -E env PYTHONDONTWRITEBYTECODE=1
            python3 -c
            "import re; \
             src = open('${CMAKE_SOURCE_DIR}/${SOURCE}', 'rb').read(); \
             src = src.replace(b'\\r\\n', b'\\n').replace(b'\\r', b'\\n'); \
             src = re.sub(b'^( {0,4}NEW| {0,4}PREFIX[^\\n]*| {0,4}AUTO [0-9]+,[0-9]+)\\n', b'', src, flags=re.MULTILINE); \
             src = re.sub(b'^\\x08*MAN\\n', b'', src, flags=re.MULTILINE); \
             src = re.sub(b'^TEXT [^\\n]+\\n', b'', src, flags=re.MULTILINE); \
             src = src.replace(b'\\n', b'\\r'); \
             open('${output_file}', 'wb').write(src)"
        DEPENDS ${CMAKE_SOURCE_DIR}/${SOURCE}
        COMMENT "Copying text file ${OUTPUT_PATH}"
        VERBATIM
    )

    add_custom_target(${TARGET} DEPENDS ${output_file})

    # Record ProDOS type metadata (TXT = $04)
    set_property(GLOBAL APPEND PROPERTY
        A2OSX_FILE_MANIFEST "${OUTPUT_PATH}:04:${PRODOS_AUX}")

endfunction()

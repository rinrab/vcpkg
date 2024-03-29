vcpkg_download_distfile(ARCHIVE
    URLS "https://www.apache.org/dist/serf/serf-1.3.10.zip"
    FILENAME "serf-1.3.10.zip"
    SHA512 82e1c7342b0fa102c0e853989da0f6b590584e5a1d7737f891edd1d49b2a3ec271fd71f2642813455f73230c57230aebdc3a83808335dd53c5ce9fdab8506e2f
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES
        serf-msbuild.patch
)

vcpkg_build_msbuild(
    PROJECT_PATH ${SOURCE_PATH}/serf.sln
    TARGET serf
    OPTIONS /p:CURRENT_INSTALLED_DIR=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

SET(RELEASE_OUT_DIR ${SOURCE_PATH}/out/Release-${VCPKG_TARGET_ARCHITECTURE})
SET(DEBUG_OUT_DIR ${SOURCE_PATH}/out/Debug-${VCPKG_TARGET_ARCHITECTURE})

# Header files
file(GLOB_RECURSE INCLUDES ${SOURCE_PATH}/*.h)
file(COPY ${INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Lib files
file(GLOB_RECURSE LIBS_RELEASE ${RELEASE_OUT_DIR}/*.lib)
file(GLOB_RECURSE LIBS_DEBUG ${DEBUG_OUT_DIR}/*.lib)
file(COPY ${LIBS_RELEASE} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${LIBS_DEBUG} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)

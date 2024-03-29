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

# Header files
file(GLOB_RECURSE INCLUDES ${SOURCE_PATH}/*.h)
file(COPY ${INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

# Lib files
file(GLOB_RECURSE LIBS_RELEASE ${SOURCE_PATH}/out/Release/*.lib)
file(GLOB_RECURSE LIBS_DEBUG ${SOURCE_PATH}/out/Debug/*.lib)
file(COPY ${LIBS_RELEASE} DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${LIBS_DEBUG} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)

# Bin files
file(GLOB_RECURSE BINS_RELEASE ${SOURCE_PATH}/out/Release/*.pdb)
file(GLOB_RECURSE BINS_DEBUG ${SOURCE_PATH}/out/Debug/*.pdb)
file(COPY ${BINS_RELEASE} DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
file(COPY ${BINS_DEBUG} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)

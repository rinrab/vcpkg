vcpkg_download_distfile(ARCHIVE
    URLS "https://dlcdn.apache.org/subversion/subversion-1.14.3.zip"
    FILENAME "subversion-1.14.3.zip"
    SHA512 36ff26f18bd90c28d04dd71603d563be511eb6acf35e1be383455acf822b17778aa217afe0a93e4b8eca4123d7002f43f49f8c26b1a448f98474bc171e81d45d
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE "${ARCHIVE}"
    PATCHES
        "fix-serfdir.patch"
)

vcpkg_find_acquire_program(PYTHON3)

vcpkg_execute_build_process(
    COMMAND ${PYTHON3} gen-make.py
        -t vcproj --vsnet-version=2022
        --with-apr=${CURRENT_INSTALLED_DIR}
        --with-apr-util=${CURRENT_INSTALLED_DIR}
        --with-openssl=${CURRENT_INSTALLED_DIR}
        --with-serf=${CURRENT_INSTALLED_DIR}
        --with-sqlite=${CURRENT_INSTALLED_DIR}
        --with-zlib=${CURRENT_INSTALLED_DIR}
    WORKING_DIRECTORY "${SOURCE_PATH}"
    LOGNAME "gen-make"
)

vcpkg_install_msbuild(
    SOURCE_PATH "${SOURCE_PATH}"
    PROJECT_SUBPATH "subversion_vcnet.sln"
    TARGET "__ALL__"
    PLATFORM ${VCPKG_TARGET_ARCHITECTURE}
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")

# Header files
file(GLOB_RECURSE SVN_INCLUDES ${SOURCE_PATH}/subversion/include/*.h)
file(COPY ${SVN_INCLUDES} DESTINATION ${CURRENT_PACKAGES_DIR}/include)

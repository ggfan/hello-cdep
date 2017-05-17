#!/bin/bash

#generate headers...
PKG_DIR=./pkg
MANIFEST_NAME=cdep-manifest.yml
REPO_OWNER=ggfan
REPO_NAME=hello-cdep
VERSION_STR=1.0.0
PLATFORM_VER=23

HEADER_FILE_NAME=${REPO_NAME}-headers.zip
RAW_ARCHIVE_NAME="libgmath.a,libgperf.a"

printf "coordinate:\r\n"  > ${PKG_DIR}/${MANIFEST_NAME}
printf "  groupId: %s.%s\r\n" "com.github" "${REPO_OWNER}" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "  artifactId: %s\r\n" "${REPO_NAME}" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "  version: %s\r\n" "${VERSION_STR}" >> ${PKG_DIR}/${MANIFEST_NAME}

printf "license:\r\n" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "  %s\r\n" "url: http://www.apache.org/licenses/LICENSE-2.0" \
  >> ${PKG_DIR}/${MANIFEST_NAME}

printf "%s\r\n" "interfaces:" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "  %s\r\n" "headers:" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "    file: %s\r\n" "${HEADER_FILE_NAME}" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "    %s\r\n" "include: include" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "    sha256: " >> ${PKG_DIR}/${MANIFEST_NAME}
shasum -a 256 ${PKG_DIR}/${HEADER_FILE_NAME} | awk '{print $1}' >> ${PKG_DIR}/${MANIFEST_NAME}
printf "    size: " >> ${PKG_DIR}/${MANIFEST_NAME}
ls -l ${PKG_DIR}/${HEADER_FILE_NAME} | awk '{print $5}' >> ${PKG_DIR}/${MANIFEST_NAME}

#generate archives...
#stls=(gnustl_static c++_static)
abis=(armeabi armeabi-v7a arm64-v8a x86 x86_64)
printf "%s\r\n" "android:" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "  %s\r\n" "archives:" >> ${PKG_DIR}/${MANIFEST_NAME}
for abi in ${abis[*]}; do
#   creates a staging directory called ../lib/lib
        #zip  -r ${PKG_DIR}/shaderc-${abi}-${stl}.zip
        archive_zip_name=${REPO_NAME}-${abi}.zip
        printf "    - file: %s\r\n" "${archive_zip_name}" >> ${PKG_DIR}/${MANIFEST_NAME}
        printf "      sha256: " >> ${PKG_DIR}/${MANIFEST_NAME}
        shasum -a 256 ${PKG_DIR}/${archive_zip_name} | awk '{print $1}' >> ${PKG_DIR}/${MANIFEST_NAME}
        printf "      size: " >> ${PKG_DIR}/${MANIFEST_NAME}
        ls -l ${PKG_DIR}/${archive_zip_name} | awk '{print $5}' >> ${PKG_DIR}/${MANIFEST_NAME}

        printf "      abi: %s\r\n" "${abi}" >> ${PKG_DIR}/${MANIFEST_NAME}
        printf "      platform: %s\r\n" "${PLATFORM_VER}" >> ${PKG_DIR}/${MANIFEST_NAME}
        printf "      libs: [%s]\r\n" "${RAW_ARCHIVE_NAME}" >> ${PKG_DIR}/${MANIFEST_NAME}
done


# Adding one example to it...
printf "%s\r\n" "example: |" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "%s\r\n" "  #include <gmath.h>" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "%s\r\n" "  #include <gperf.>" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "%s\r\n" "  #include <cinttypes>">> ${PKG_DIR}/${MANIFEST_NAME}

  
printf "%s\r\n" "  void example() {" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "%s\r\n" "    GetTicks();" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "%s\r\n" "    gpower(4);" >> ${PKG_DIR}/${MANIFEST_NAME}
printf "%s\r\n" "  }" >> ${PKG_DIR}/${MANIFEST_NAME}
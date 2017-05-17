#!/bin/bash
# publish c only libs

TOOL_DIR=/Users/gfan/proj/shaderc-cdep/release/bin/darwin/amd64/
OWNER_NAME=ggfan
PKG_DIR=./pkg
REPO_NAME=hello-cdep
REL_TAG=1.0.0

#remember to export the GITHUB_TOKEN
#export GITHUB_TOKEN=

${TOOL_DIR}/github-release upload -R --user ${OWNER_NAME} --repo ${REPO_NAME} --tag ${REL_TAG} \
  --file ${PKG_DIR}/cdep-manifest.yml --name cdep-manifest.yml
${TOOL_DIR}/github-release upload -R --user ${OWNER_NAME} --repo ${REPO_NAME} --tag ${REL_TAG} \
  --file ${PKG_DIR}/${REPO_NAME}-headers.zip --name ${REPO_NAME}-headers.zip

#stls=(gnustl_static c++_static)
abis=(armeabi armeabi-v7a arm64-v8a x86 x86_64)

for abi in ${abis[*]}; do
        f=${REPO_NAME}-${abi}.zip
        echo uploading ${f}
        ${TOOL_DIR}/github-release upload -R --user ${OWNER_NAME} --repo ${REPO_NAME} --tag ${REL_TAG} \
                                  --file ${PKG_DIR}/${f}  --name ${f}
 #   done
done


#!/bin/bash

if [ ! ["${OSTYPE}"=="linux"*] ]; then
	exit $?
fi

#Output:
# Zip files starts with lib/${ANDROID-ABI}/lib-name.a [could be mulitple]
#                       include/header-files.h
# target-name: repo-name-headers/${abi}.zip
# input:  include & lib directories inside  ${BIN_DIR}

BIN_DIR=merged-libs
PKG_DIR=pkg
REPO_NAME=hello-cdep

abis=(armeabi armeabi-v7a arm64-v8a x86 x86_64)

mkdir  -p ${PKG_DIR}
for abi in ${abis[*]}; do
        rm -fr ./lib
        mkdir  -p lib
        cp -fr  ${BIN_DIR}/lib/${abi}  lib/
        zip  -r ${PKG_DIR}/${REPO_NAME}-${abi}.zip  lib
done
rm -fr ./lib

#working on the headers
mkdir  -p include
cp -fr ${BIN_DIR}/include ./
zip -r ${PKG_DIR}/${REPO_NAME}-headers.zip  include
rm -fr include

#for total clean-up:
#rm -fr ${PKG_DIR}


#!/bin/bash

set -e

wget -nv https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip
unzip -q android-ndk-r10e-linux-x86_64.zip

export ANDROID_NDK=$(realpath android-ndk-r10e)

mkdir buildout

export CI_TOOLCHAIN_OUT=$(realpath buildout)

build_single_arch() {
   export ARCH=$1
   export TRIPLET=$2
   export TARGET_SDK=$3
   export CI_TOOLCHAIN_PATH=/tmp/toolchain-$ARCH
   if [[ -e gcc/build-gcc ]]; then
      rm -rf gcc/build-gcc
   fi

   ./scripts/prepare_4.9_prefix.sh
   ./scripts/build-gcc.sh

   pushd $CI_TOOLCHAIN_PATH
      tar cJf $CI_TOOLCHAIN_OUT/gcc-$ARCH-$TARGET_SDK.tar.xz .
   popd
   rm -rf $CI_TOOLCHAIN_PATH
}

pushd .

./scripts/getsources.sh
./scripts/hostdeps.sh

popd

build_single_arch arm    arm-linux-androideabi 21
#build_single_arch arm    arm-linux-androideabi 9
build_single_arch x86    i686-linux-android    21
build_single_arch arm64  aarch64-linux-android 21
build_single_arch x86_64 x86_64-linux-android  21

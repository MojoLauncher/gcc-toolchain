#!/bin/bash

if [ -z "$ARCH" ]; then
   echo "ARCH is not set"
   exit 1
fi

if [ -z "$TRIPLET" ]; then
   echo "TRIPLET is not set"
   exit 1
fi

if [ -z "$TARGET_SDK" ]; then
   export TARGET_SDK=9
fi

if [[ "$ARCH" == "arm64" || "$ARCH" == "x86_64" ]]; then
  if [[ "$TARGET_SDK" -lt "21" ]]; then
    export TARGET_SDK=21
  fi
fi

export TC_PATH=/tmp/toolchain-$ARCH
export TC_SYSROOT=$TC_PATH/sysroot

set -e

mkdir $TC_PATH
mkdir $TC_SYSROOT

# use binutils and gcc sysroot/startfiles from 4.9
cp -a $ANDROID_NDK/toolchains/$TRIPLET-4.9/prebuilt/linux-x86_64/* $TC_PATH
cp -a $ANDROID_NDK/platforms/android-$TARGET_SDK/arch-$ARCH/* $TC_SYSROOT

# libstdc++_v3 expects a syscall.h header in the include root, and this symlink works well enough
ln -s $TC_SYSROOT/usr/include/sys/syscall.h $TC_SYSROOT/usr/include/syscall.h

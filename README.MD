# gcc-toolchain

Standalone GCC 13 toolchain builder for Android. Based on https://github.com/FWGS/ndk-gcc13

## Prerequisites

build-essential and Android NDK r10e

## How to use

Set ANDROID_NDK to Android NDK r10e location, ARCH to short arch name (arm, arm64, x86, x86_64), TRIPLET to the target triplet (arm-linux-androideabi, aarch64-linux-android)

```sh
./scripts/getsources.sh
./scripts/hostdeps.sh

./scripts/prepare_4.9_prefix.sh
./scripts/build-gcc13.sh
```

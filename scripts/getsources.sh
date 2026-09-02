#!/bin/bash
set -e
if [ ! -d gcc ]; then
  git clone https://github.com/gcc-mirror/gcc gcc -b releases/gcc-16.2.0 --depth 1
  pushd gcc
  patch -p1 < ../scripts/gcc13-android-aarch64.patch
  popd
fi
wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.24.tar.bz2
tar xf isl-0.24.tar.bz2
wget https://www.mpfr.org/mpfr-4.2.2/mpfr-4.2.2.tar.xz
tar xf mpfr-4.2.2.tar.xz
wget https://www.multiprecision.org/downloads/mpc-1.4.1.tar.xz
tar xf mpc-1.4.1.tar.xz
pushd mpc-1.4.1
# mpc.h missing stdio.h include...
#patch -p1 < ../scripts/mpc.patch
popd
wget https://ftp.gnu.org/gnu/gmp/gmp-6.3.0.tar.xz
tar xf gmp-6.3.0.tar.xz
pushd gmp-6.3.0
#patch -p1 < ../scripts/gmp-gcc-15.patch
#autoreconf -vif
popd

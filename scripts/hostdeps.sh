#!/bin/bash
set -e

cd gmp-6.2.1/
./configure --prefix=/tmp/hostdeps/ --disable-shared --enable-static
make -j16
make install
cd ..
cd mpfr-4.2.1
./configure --prefix=/tmp/hostdeps/ --with-gmp=/tmp/hostdeps/ --disable-shared --enable-static
make -j16
make install
cd ..
cd mpc-1.3.0
./configure --prefix=/tmp/hostdeps/ --with-gmp=/tmp/hostdeps/ --disable-shared --enable-static
make -j16
make install
cd ..
cd isl-0.24
./configure --prefix=/tmp/hostdeps/ --with-gmp-prefix=/tmp/hostdeps/ --disable-shared --enable-static
make -j16
make install
cd ..

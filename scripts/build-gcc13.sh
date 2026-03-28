# use static libs for portability, dynamic linking requires using LD_LIBRARY_PATH or rpath to make it load libs correctly

set -e

mkdir gcc-13/build-gcc
cd gcc-13/build-gcc

export TC_PATH=/tmp/toolchain-$ARCH
export TC_SYSROOT=$TC_PATH/sysroot

export BG_HOSTDEPS=/tmp/hostdeps
export ARCH_OPTS=""
export ARCH_OPTS_2=""
if [[ "$ARCH" == "arm" ]]; then
   export ARCH_OPTS="--with-float=soft --with-fpu=vfp --with-arch=armv5te"
   export ARCH_OPTS_2 = "--with-arch=armv5te"
fi
../configure --prefix=$TC_PATH --target=$TRIPLET --host=x86_64-linux-gnu --build=x86_64-linux-gnu --with-gnu-as --with-gnu-ld --enable-languages=c,c++ --with-host-libstdcxx="-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm" --disable-libssp --enable-threads --disable-nls --disable-libmudflap --disable-sjlj-exceptions --disable-shared --disable-tls --disable-libitm $ARCH_OPTS --enable-target-optspace --enable-initfini-array --disable-nls  --with-sysroot=$TC_SYSROOT --with-binutils-version=2.25 --with-bugurl=http://source.android.com/source/report-bugs.html --enable-languages=c,c++ --enable-default-pie --disable-bootstrap --enable-plugins --enable-libgomp --enable-gnu-indirect-function --enable-libsanitizer --enable-gold --enable-threads --enable-graphite=yes  --enable-eh-frame-hdr-for-static $ARCH_OPTS_2 --enable-gold=default --with-gmp=$BG_HOSTDEPS --with-mpfr=$BG_HOSTDEPS --with-mpc=$BG_HOSTDEPS --with-isl=$BG_HOSTDEPS
make -j16
make install
# gcc codegen using sincos functions.
# They are not availiable in android, but availiable in libm_hard.a,
# so insert it in libgcc to link-in when libm_hard.a not used
# TODO fix this
#ar q /tmp/prefix/lib/gcc/arm-linux-androideabi/13.2.1/libgcc.a scripts/sincos/k_rem_pio2.o scripts/sincos/s_sincos.o scripts/sincos/s_sincosf.o
# /tmp/prefix now have gcc-13.2.1 and it may be integrated to ndk

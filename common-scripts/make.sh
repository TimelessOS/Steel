#!/bin/bash
set -e

export CC="musl-gcc -static"
export CFLAGS="-O2 -fPIC"
export LDFLAGS="-L$PWD/lib"
export CPPFLAGS="-I$PWD/include"

export PKG_CONFIG_PATH=$PWD/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_LIBDIR=$PWD/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=$PWD/

export OUTDIR="$(pwd)/out"

make STATIC=true CC="$CC" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" CPPFLAGS="$CPPFLAGS"
PREFIX=/ make DESTDIR="$OUTDIR" install -j1

# Clean up useless libtool garbage
mkdir -p "$OUTDIR/lib"
find "$OUTDIR/lib" -name '*.la' -delete

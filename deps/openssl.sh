#!/bin/bash
set -e

export CC="musl-gcc -static"
export CFLAGS="-O2 -fPIC"
export LDFLAGS="-L$PWD/lib"
export CPPFLAGS="-I$PWD/include"
export PKG_CONFIG_PATH=$PWD/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_LIBDIR=$PWD/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=$PWD/

./Configure --prefix=/ -fPIC threads no-shared --static -static --openssldir=/etc/ssl linux-x86_64 no-shared --libdir=/lib 
make
make DESTDIR=out install
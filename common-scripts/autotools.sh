#!/bin/bash
set -e

export CC="musl-gcc -static"
export CFLAGS="-O2 -fPIC"
export LDFLAGS="-L$PWD/lib"
export CPPFLAGS="-I$PWD/include"
export PKG_CONFIG_PATH=$PWD/lib/pkgconfig:$PKG_CONFIG_PATH
export PKG_CONFIG_LIBDIR=$PWD/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=$PWD/

# Generate ./configure
if [ ! -x configure ]; then
    export NOCONFIGURE=1;

    if [ -x bootstrap ]; then ./bootstrap;
    elif [ -x bootstrap.sh ]; then ./bootstrap.sh;
    elif [ -x autogen ]; then ./autogen;
    elif [ -x autogen.sh ]; then ./autogen.sh;
    elif [ -x configure.ac ]; then autoreconf -ivf ./;
    fi

    # Should only be needed by git, but is rather annoying.
    make configure | true
fi

export OUTDIR="$(pwd)/out"

./configure --verbose --prefix=/ --libdir=/lib --enable-static --with-pic --disable-runtime LIBS="-lssl -lcrypto" "$@"

make STATIC=true STRIP=true TARGET=x86_64-linux-musl
make DESTDIR=$OUTDIR -j1 TARGET=x86_64-linux-musl install

find $OUTDIR/lib -name '*.la' -delete
#!/bin/bash
set -e

export CC=musl-gcc
export CFLAGS="-O2 -fPIC"
export LDFLAGS="-L$PWD/lib"
export CPPFLAGS="-I$PWD/include"
export PKG_CONFIG_PATH=$PWD/lib/pkgconfig:$PKG_CONFIG_PATH

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

./configure --prefix=/ --libdir=/lib --disable-shared --enable-static "$@"

make STATIC=true STRIP=true
make DESTDIR=$OUTDIR -j1 install

find $OUTDIR/lib -name '*.la' -delete
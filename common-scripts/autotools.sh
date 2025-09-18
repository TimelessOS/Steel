#!/bin/bash
set -e

export CC="musl-gcc -static"
export CFLAGS="-O2 -fPIC"
export LDFLAGS="-L$PWD/lib"
export CPPFLAGS="-I$PWD/include"

export PKG_CONFIG_PATH=$PWD/lib/pkgconfig
export PKG_CONFIG_LIBDIR=$PWD/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=$PWD/
export PATH=$PWD/bin:$PATH

# MUSL vs Glibc...? or just strangely defined?
# Required by deps/gpgme
export CFLAGS="-Doff64_t=off_t $CFLAGS"
export CFLAGS="-Dino64_t=ino_t $CFLAGS"

unset LD_LIBRARY_PATH

# Generate ./configure
if [ ! -f configure ]; then
    export NOCONFIGURE=1;

    if [ -x bootstrap ]; then ./bootstrap;
    elif [ -x bootstrap.sh ]; then ./bootstrap.sh;
    elif [ -x autogen ]; then ./autogen;
    elif [ -x autogen.sh ]; then ./autogen.sh;
    elif [ -x configure.ac ]; then autoreconf -ivf ./;
    fi

    # Should only be needed by git, but is rather annoying.
    make configure | true > /dev/null
fi

export OUTDIR="$(pwd)/out"

./configure --verbose --prefix=/ --libdir=/lib --enable-static --with-pic "$@"

make STATIC=true
make DESTDIR=$OUTDIR -j1 install

# Clean up useless libtool garbage
mkdir -p $OUTDIR/lib
find $OUTDIR/lib -name '*.la' -delete
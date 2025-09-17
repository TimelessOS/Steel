#!/bin/bash
set -e

export CC=musl-gcc
export CFLAGS="-O2"
export LDFLAGS="-static"

export NOCONFIGURE=1;

if [ -x bootstrap ]; then bootstrap;
elif [ -x bootstrap.sh ]; then bootstrap.sh;
elif [ -x autogen ]; then autogen;
elif [ -x autogen.sh ]; then autogen.sh;
elif [ -x configure.ac ]; then autoreconf -ivf ./;
fi

# Should only be needed by git, but is rather annoying.
make configure | true

./configure --prefix=/ "$@"

make

make DESTDIR=out -j1 install
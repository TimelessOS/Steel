#!/bin/bash
set -e

export NOCONFIGURE=1;

if [ -x bootstrap ]; then bootstrap;
elif [ -x bootstrap.sh ]; then bootstrap.sh;
elif [ -x autogen ]; then autogen;
elif [ -x autogen.sh ]; then autogen.sh;
elif [ -x configure.ac ]; then autoreconf -ivf ./;
fi

./configure --prefix=/ -static $1

make

make DESTDIR=out -j1 install
#!/bin/bash

mkdir -p out

./autogen.sh

CPPFLAGS="-I$PWD/include" \
LDFLAGS="-L$PWD/lib" \
CC=musl-gcc ./configure \
    --prefix=/ \
    --enable-unicode \
    --enable-static \
    --enable-affinity

make

make DESTDIR=out install 

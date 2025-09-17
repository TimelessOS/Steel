#!/bin/bash
set -e

CC=musl-gcc ./configure \
    --prefix=/ \
    --with-shared \
    --without-debug \
    --without-ada \
    --without-cxx-binding \
    --with-termlib \
    --enable-widec

make -j$(nproc)

make install DESTDIR=$PWD/out

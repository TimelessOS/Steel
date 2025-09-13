#!/bin/bash

mkdir -p out/bin

export CPPFLAGS="-I$PWD/include"
export LDFLAGS="-L$PWD/lib"
export CC=musl-gcc

make STATIC=true STRIP=true 

make DESTDIR=out PREFIX=/ install 

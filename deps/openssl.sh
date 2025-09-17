#!/bin/bash
set -e

./Configure --prefix=/ --openssldir=/etc/ssl linux-x86_64 no-shared --libdir=/lib
make
make DESTDIR=out install
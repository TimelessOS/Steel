#!/bin/bash
set -e

./Configure --prefix=/ --openssldir=/etc/ssl linux-x86_64 no-shared
make
make DESTDIR=out install
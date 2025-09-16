#!/bin/bash
set -e

ARCH=$(uname -m)

cargo build --release --target=$ARCH-unknown-linux-musl --all-features

mkdir out
cp target/$ARCH-unknown-linux-musl/release/$1 out
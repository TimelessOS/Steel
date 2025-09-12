#!/bin/bash
set -e

ARCH=$(uname -m)

cargo test --release --target=$ARCH-unknown-linux-musl --all-features
cargo build --release --target=$ARCH-unknown-linux-musl --all-features

mkdir out
cp target/$ARCH-unknown-linux-musl/release/flint out
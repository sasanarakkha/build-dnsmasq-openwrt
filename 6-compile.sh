#!/bin/sh

set -eu

cd openwrt

make -j $(($(nproc)+1)) target/linux/compile
make -j $(($(nproc)+1)) package/network/services/dnsmasq/compile #V=s

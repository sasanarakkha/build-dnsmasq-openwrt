#!/bin/sh

set -eu

OPENWRT_REPO_URL="https://github.com/openwrt/openwrt.git"

test -d .openwrt || git clone "$OPENWRT_REPO_URL" .openwrt
( cd .openwrt && git pull )

rm -rf openwrt
git clone .openwrt openwrt
cd openwrt

git checkout "$OPENWRT_REVISION"

# Try twice because we often have network errors causing this to fail
scripts/feeds update -a || scripts/feeds update -a
scripts/feeds install -a

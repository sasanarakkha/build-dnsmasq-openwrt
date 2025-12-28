#!/bin/sh

set -eu
cd "$(dirname "$0")"

OPENWRT_REVISIONS="v24.10.5 v25.12.0-rc1"
OPENWRT_TARGETS="lantiq-xrx200 ramips-mt7621 x86-64"

export OPENWRT_REVISION
export OPENWRT_TARGET

./1-prerequisites.sh # needs sudo

for OPENWRT_REVISION in $OPENWRT_REVISIONS; do
  for OPENWRT_TARGET in $OPENWRT_TARGETS; do
    ./2-clone.sh
    ./3-config.sh
    ./4-download.sh
    ./5-toolchain.sh
    ./6-compile.sh
    ./7-release.sh
  done
done

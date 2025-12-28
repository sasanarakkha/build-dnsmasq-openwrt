#!/bin/sh

set -eu

mkdir -p release

ARCH="$(ls -1 openwrt/bin/packages)"

for PACKAGE_PATH in "openwrt/bin/packages/$ARCH/base/dnsmasq"*; do
  PACKAGE_FILE="$(basename -- "$PACKAGE_PATH")"
  PACKAGE_EXT="${PACKAGE_FILE##*.}"
  if [ "$PACKAGE_EXT" = apk ]; then
    PACKAGE_NAME="$(echo "$PACKAGE_FILE" | sed -e 's/-[0-9].*\.apk$//')"
    PACKAGE_VERSION="$(echo "$PACKAGE_FILE" | sed -e 's/^.*-\([0-9].*\)\.apk$/\1/')"
  else
    PACKAGE_NAME="$(echo "$PACKAGE_FILE" | cut -d _ -f 1)"
    PACKAGE_VERSION="$(echo "$PACKAGE_FILE" | sed -e 's/^[^_]*_//' -e 's/_[^_]*_[^_]*\.ipk$//')"
  fi
  RELEASE_FILE="$PACKAGE_NAME-$PACKAGE_VERSION-openwrt-$OPENWRT_REVISION-$ARCH.$PACKAGE_EXT"
  cp "$PACKAGE_PATH" "release/$RELEASE_FILE"
done

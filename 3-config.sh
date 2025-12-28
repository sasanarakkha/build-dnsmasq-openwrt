#!/bin/sh

set -eu

cd openwrt

for PATCH_PATH in ../patches/$OPENWRT_REVISION/*; do
  patch -p1 <"$PATCH_PATH"
done

TARGET="$(echo "$OPENWRT_TARGET" | cut -d - -f 1)"
SUBTARGET="$(echo "$OPENWRT_TARGET" | cut -d - -f 2)"

cat >.config <<EOF
CONFIG_TARGET_${TARGET}=y
CONFIG_TARGET_${TARGET}_${SUBTARGET}=y
CONFIG_TARGET_${TARGET}_${SUBTARGET}_Default=y
CONFIG_TARGET_PROFILE="Default"
CONFIG_TARGET_ROOTFS_INITRAMFS=n
CONFIG_TARGET_ROOTFS_SQUASHFS=n
CONFIG_PACKAGE_dropbear=n
CONFIG_PACKAGE_luci=n
CONFIG_DEFAULT_dnsmasq=y
CONFIG_PACKAGE_dnsmasq=y
CONFIG_PACKAGE_dnsmasq-dhcpv6=y
CONFIG_PACKAGE_dnsmasq-full=y
CONFIG_PACKAGE_dnsmasq_full_dhcp=y
CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
CONFIG_PACKAGE_dnsmasq_full_dnssec=y
CONFIG_PACKAGE_dnsmasq_full_auth=y
CONFIG_PACKAGE_dnsmasq_full_nftset=y
CONFIG_PACKAGE_dnsmasq_full_conntrack=y
CONFIG_PACKAGE_dnsmasq_full_noid=y
CONFIG_PACKAGE_dnsmasq_full_tftp=y
EOF

make defconfig

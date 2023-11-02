# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-nouveau"
PKG_VERSION="1.0.17"
PKG_SHA256="21e9233b2c6304b976c526729ba48660c16976a757a319fa95cc8a8605316105"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="https://nouveau.freedesktop.org"
PKG_URL="https://www.x.org/archive/individual/driver/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdrm xorg-server util-macros xorg-server libvdpau"
PKG_LONGDESC="Xorg driver for Nvidia using the nouveau kernel driver."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-xorg-module-dir=${XORG_PATH_MODULES}"

post_makeinstall_target() {
  mkdir -p ${INSTALL}/etc/X11
    cp ${PKG_DIR}/config/*.conf ${INSTALL}/etc/X11
}

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.argustv"
PKG_VERSION="22.1.0-Piers"
PKG_SHA256="835b10a5c4e4bd205bdae99a3683cbac711def9594eb5ff6e9874d7c8db1fd26"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.argustv"
PKG_URL="https://github.com/kodi-pvr/pvr.argustv/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform jsoncpp"
PKG_SECTION=""
PKG_SHORTDESC="pvr.argustv"
PKG_LONGDESC="pvr.argustv"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS+=" -Wno-narrowing"
}

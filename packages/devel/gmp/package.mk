# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gmp"
PKG_VERSION="6.3.0"
PKG_SHA256="a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898"
PKG_LICENSE="LGPLv3+"
PKG_SITE="http://gmplib.org/"
PKG_URL="https://gmplib.org/download/gmp/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host m4:host"
PKG_DEPENDS_TARGET="autotools:host gcc:host"
PKG_LONGDESC="A library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating point numbers."
PKG_BUILD_FLAGS="+pic:host"

PKG_CONFIGURE_OPTS_HOST="--enable-cxx --enable-static --disable-shared"

pre_configure_host() {
  export CPPFLAGS="${CPPFLAGS} -fexceptions"
}

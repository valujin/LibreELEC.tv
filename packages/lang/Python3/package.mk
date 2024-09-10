# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Python3"
# When changing PKG_VERSION remember to sync PKG_PYTHON_VERSION!
PKG_VERSION="3.12.5"
PKG_SHA256="fa8a2e12c5e620b09f53e65bcd87550d2e5a1e2e04bf8ba991dcc55113876397"
PKG_LICENSE="OSS"
PKG_SITE="https://www.python.org/"
PKG_URL="https://www.python.org/ftp/python/${PKG_VERSION}/${PKG_NAME::-1}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="zlib:host bzip2:host libffi:host util-linux:host xz:host autoconf-archive:host"
PKG_DEPENDS_TARGET="autotools:host gcc:host Python3:host sqlite expat zlib bzip2 xz openssl libffi readline ncurses util-linux"
PKG_LONGDESC="Python3 is an interpreted object-oriented programming language."
PKG_TOOLCHAIN="autotools"

PKG_PYTHON_VERSION="python3.12"

PKG_CONFIGURE_OPTS_HOST="ac_cv_prog_HAS_HG=/bin/false
                         ac_cv_prog_SVNVERSION=/bin/false
                         py_cv_module_unicodedata=yes
                         py_cv_module__codecs_cn=n/a
                         py_cv_module__codecs_hk=n/a
                         py_cv_module__codecs_iso2022=n/a
                         py_cv_module__codecs_jp=n/a
                         py_cv_module__codecs_kr=n/a
                         py_cv_module__codecs_tw=n/a
                         py_cv_module_nis=n/a
                         py_cv_module_ossaudiodev=n/a
                         py_cv_module__dbm=n/a
                         py_cv_module__gdbm=n/a
                         --disable-pyc-build
                         --disable-sqlite3
                         --enable-openssl
                         --disable-readline
                         --disable-bzip2
                         --enable-zlib
                         --enable-xz
                         --disable-tk
                         --disable-curses
                         --disable-pydoc
                         --disable-test-modules
                         --disable-lib2to3
                         --disable-idle3
                         --without-cxx-main
                         --with-expat=builtin
                         --with-libmpdec=none
                         --with-doc-strings
                         --with-system-ffi
                         --without-pymalloc
                         --with-ensurepip=no
"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_prog_HAS_HG=/bin/false
                           ac_cv_prog_SVNVERSION=/bin/false
                           ac_cv_file__dev_ptmx=no
                           ac_cv_file__dev_ptc=no
                           ac_cv_have_long_long_format=yes
                           ac_cv_working_tzset=yes
                           ac_cv_func_lchflags_works=no
                           ac_cv_func_chflags_works=no
                           ac_cv_func_printf_zd=yes
                           ac_cv_buggy_getaddrinfo=no
                           ac_cv_header_bluetooth_bluetooth_h=no
                           ac_cv_header_bluetooth_h=no
                           py_cv_module_unicodedata=yes
                           py_cv_module__codecs_cn=n/a
                           py_cv_module__codecs_hk=n/a
                           py_cv_module__codecs_iso2022=n/a
                           py_cv_module__codecs_jp=n/a
                           py_cv_module__codecs_kr=n/a
                           py_cv_module__codecs_tw=n/a
                           py_cv_module_nis=n/a
                           py_cv_module_ossaudiodev=n/a
                           py_cv_module__dbm=n/a
                           --disable-pyc-build
                           --enable-sqlite3
                           --enable-openssl
                           --enable-readline
                           --enable-bzip2
                           --enable-zlib
                           --enable-xz
                           --disable-tk
                           --enable-curses
                           --disable-pydoc
                           --disable-test-modules
                           --disable-lib2to3
                           --disable-idle3
                           --without-cxx-main
                           --with-expat=system
                           --with-libmpdec=none
                           --with-doc-strings
                           --with-system-ffi
                           --without-pymalloc
                           --without-ensurepip
                           --enable-ipv6
                           --with-build-python=${TOOLCHAIN}/bin/python
"

pre_configure_host() {
  # control patch Python3-0300-generate-legacy-pyc-bytecode
  # this needs to be set when building host based py file
  # do not set this for py compiles being done for target use
  export DONT_BUILD_LEGACY_PYC=1
}

post_make_host() {
  # python distutils per default adds -L${LIBDIR} when linking binary extensions
  sed -e "s|^ 'LIBDIR':.*| 'LIBDIR': '/usr/lib',|g" -i $(find ${PKG_BUILD}/.${HOST_NAME} -not -path '*/__pycache__/*' -name '_sysconfigdata__*.py')
}

post_makeinstall_host() {
  ln -sf ${PKG_PYTHON_VERSION} ${TOOLCHAIN}/bin/python

  rm -fr ${PKG_BUILD}/.${HOST_NAME}/build/temp.*
}

post_make_target() {
  # fix sysconfig paths for cross compiling
  PKG_SYSCONFIG_FILE=$(find ${PKG_BUILD}/.${TARGET_NAME} -not -path '*/__pycache__/*' -name '_sysconfigdata__*.py')
  sed -e "s,\([\'|\ ]\)/usr/include,\1${SYSROOT_PREFIX}/usr/include,g" -i ${PKG_SYSCONFIG_FILE}
  sed -e "s,\([\'|\ ]\)/usr/lib,\1${SYSROOT_PREFIX}/usr/lib,g" -i ${PKG_SYSCONFIG_FILE}
}

post_makeinstall_target() {
  ln -sf ${PKG_PYTHON_VERSION} ${INSTALL}/usr/bin/python

  rm -fr ${PKG_BUILD}/.${TARGET_NAME}/build/temp.*

  PKG_INSTALL_PATH_LIB=${INSTALL}/usr/lib/${PKG_PYTHON_VERSION}

  for dir in config compiler sysconfigdata lib-dynload/sysconfigdata lib2to3/tests test; do
    rm -rf ${PKG_INSTALL_PATH_LIB}/${dir}
  done

  safe_remove ${INSTALL}/usr/bin/python*-config

  find ${INSTALL} -name '*.o' -delete

  python_compile ${PKG_INSTALL_PATH_LIB}

  # strip
  chmod u+w ${INSTALL}/usr/lib/libpython*.so.*
  debug_strip ${INSTALL}/usr
}

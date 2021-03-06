# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/elektra/elektra-0.8.7.ebuild,v 1.1 2015/06/09 16:45:41 xmw Exp $

EAPI=5

inherit cmake-multilib eutils

DESCRIPTION="universal and secure framework to store config parameters in a hierarchical key-value pair mechanism"
HOMEPAGE="http://freedesktop.org/wiki/Software/Elektra"
SRC_URI="ftp://ftp.markus-raab.org/${PN}/releases/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus doc examples iconv ini keytometa simpleini static-libs syslog tcl test +uname xml yajl"

RDEPEND=">=dev-libs/libxml2-2.9.1-r4[${MULTILIB_USEDEP}]
	dbus? ( >=sys-apps/dbus-1.6.18-r1[${MULTILIB_USEDEP}] )
	iconv? ( >=virtual/libiconv-0-r1[${MULTILIB_USEDEP}] )
	uname? ( sys-apps/coreutils )
	yajl? (
		<dev-libs/yajl-2[${MULTILIB_USEDEP}]
		>=dev-libs/yajl-1.0.11-r1[${MULTILIB_USEDEP}]
	)"
DEPEND="${RDEPEND}
	sys-devel/libtool
	doc? ( app-doc/doxygen )"

DOCS="README.md doc/AUTHORS doc/CHANGES doc/NEWS doc/todo/TODO"
# tries to write to user's home directory (and doesn't respect HOME)
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${P}-conditional-glob-tests.patch"

	einfo remove bundled libs
	# TODO: Remove bundled inih from src/plugins/ini (add to portage):
	# https://code.google.com/p/inih/
	rm -rf src/external || die

	local tests="augeas fstab hosts ini yajl"
	if ! use test ; then
		einfo remove test data
		for test in ${tests}; do
			sed -e '/TARGET_TEST_DATA_FOLDER/ s/^#*/#/' \
				-i src/plugins/${test}/CMakeLists.txt || die
		done
	fi

	#move doc files to correct location
	sed -e "s/elektra-api/${PF}/" \
		-i cmake/ElektraCache.cmake || die

	cmake-utils_src_prepare
}

multilib_src_configure() {
	local my_plugins="ccode;dump;error;fstab;glob;hexcode;hidden;hosts;network;ni;null;path;resolver;struct;success;template;timeofday;tracer;type;validation"

	use dbus      && my_plugins+=";dbus"
	use iconv     && my_plugins+=";iconv"
	use ini       && my_plugins+=";ini"		#bundles inih
	use keytometa && my_plugins+=";keytometa"
	use simpleini && my_plugins+=";simpleini"
	use syslog    && my_plugins+=";syslog"
	use tcl       && my_plugins+=";tcl"
	use uname     && my_plugins+=";uname"
	use xml       && my_plugins+=";xmltool"
	use yajl      && my_plugins+=";yajl"

	mycmakeargs=(
		"-DPLUGINS=${my_plugins}"
		"-DLATEX_COMPILER=OFF"
		"-DTARGET_CMAKE_FOLDER=share/cmake/Modules"
		$(multilib_is_native_abi && cmake-utils_use doc BUILD_DOCUMENTATION \
			|| echo -DBUILD_DOCUMENTATION=OFF)
		$(multilib_is_native_abi && cmake-utils_use examples BUILD_EXAMPLES \
			|| echo -DBUILD_EXAMPLES=OFF)
		$(cmake-utils_use static-libs BUILD_STATIC)
		$(cmake-utils_use test BUILD_TESTING)
		$(cmake-utils_use test ENABLE_TESTING)
	)

	cmake-utils_src_configure
}

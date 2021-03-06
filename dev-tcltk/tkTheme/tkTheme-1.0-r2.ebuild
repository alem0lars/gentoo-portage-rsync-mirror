# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkTheme/tkTheme-1.0-r2.ebuild,v 1.10 2012/03/18 18:34:57 armin76 Exp $

EAPI=4

inherit autotools-utils  eutils toolchain-funcs

DESCRIPTION="Tcl/Tk Theming library"
HOMEPAGE="http://www.xmission.com/~georgeps/Tk_Theme/other/"
SRC_URI="http://www.xmission.com/~georgeps/Tk_Theme/other/${PN}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE="debug examples static-libs threads"

DEPEND="
	dev-lang/tk
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

PATCHES=(
	"${FILESDIR}"/${PV}-Makefile.in.diff
	"${FILESDIR}"/${PV}-configure.diff
	"${FILESDIR}"/${PV}-cflags.patch
	)

src_configure() {
	tc-export CC
	local myeconfargs=(
		--with-tcl="${EPREFIX}/usr/$(get_libdir)"
		--with-tk="${EPREFIX}/usr/$(get_libdir)"
		--with-x
		$(use_with debug symbols)
		$(use_enable threads)
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	insinto /usr/share/${PN}
	use examples && doins -r demo
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/gummiboot/gummiboot-9999.ebuild,v 1.2 2015/04/13 07:21:47 mgorny Exp $

EAPI=5

inherit autotools eutils linux-info git-r3

DESCRIPTION="Minimalistic UEFI bootloader"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot/"
EGIT_REPO_URI="git://anongit.freedesktop.org/${PN}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sys-apps/util-linux"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=sys-boot/gnu-efi-3.0.2"

pkg_pretend() {
	# CONFIG_EFI_STUB  is required to boot a kernel with gummiboot
	local CONFIG_CHECK="~EFI_STUB"
	check_extra_config
}

src_prepare() {
	epatch_user
	eautoreconf
}

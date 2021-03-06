# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-qt/qtxmlpatterns/qtxmlpatterns-4.8.6-r1.ebuild,v 1.8 2015/07/05 21:15:12 klausman Exp $

EAPI=5

inherit qt4-build-multilib

DESCRIPTION="The XmlPatterns module for the Qt toolkit"

if [[ ${QT4_BUILD_TYPE} == live ]]; then
	KEYWORDS="alpha arm hppa ppc ppc64"
else
	KEYWORDS="alpha amd64 arm ~arm64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
fi

IUSE=""

DEPEND="
	~dev-qt/qtcore-${PV}[aqua=,debug=,${MULTILIB_USEDEP}]
"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
	src/xmlpatterns
	tools/xmlpatterns
	tools/xmlpatternsvalidator"

QCONFIG_ADD="xmlpatterns"
QCONFIG_DEFINE="QT_XMLPATTERNS"

multilib_src_configure() {
	local myconf=(
		-xmlpatterns
	)
	qt4_multilib_src_configure
}

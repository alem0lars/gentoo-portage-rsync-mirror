# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gitgutter/gitgutter-20140525.ebuild,v 1.1 2014/05/25 21:41:07 radhermit Exp $

EAPI=5
inherit vim-plugin

DESCRIPTION="vim plugin: shows a git diff summary in the sign column and stages/reverts individual hunks"
HOMEPAGE="https://github.com/airblade/vim-gitgutter/"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
VIM_PLUGIN_HELPFILES="${PN}.txt"

src_prepare() {
	rm README* screenshot.png || die
}

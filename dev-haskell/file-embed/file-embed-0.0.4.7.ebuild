# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/file-embed/file-embed-0.0.4.7.ebuild,v 1.2 2014/07/25 09:16:28 slyfox Exp $

EAPI=5

# ebuild generated by hackport 0.3.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Use Template Haskell to embed file contents directly"
HOMEPAGE="https://github.com/snoyberg/file-embed"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		test? ( dev-haskell/hunit
		)
		>=dev-haskell/cabal-1.8"

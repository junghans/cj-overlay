# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="ccache links for icc"
HOMEPAGE="http://code.google.com/p/cj-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
	dev-util/ccache
	dev-lang/icc
	"
DEPEND=""

src_install() {
	dosym "/usr/bin/ccache" "/usr/$(get_libdir)/ccache/bin/icc"
	dosym "/usr/bin/ccache" "/usr/$(get_libdir)/ccache/bin/icpc"
}

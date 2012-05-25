# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib

DESCRIPTION="ccache links for clang"
HOMEPAGE="http://code.google.com/p/cj-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-util/ccache
	sys-devel/clang
	"
DEPEND=""

src_install() {
	dosym "/usr/bin/ccache" "/usr/$(get_libdir)/ccache/bin/clang"
	dosym "/usr/bin/ccache" "/usr/$(get_libdir)/ccache/bin/clang++"
}

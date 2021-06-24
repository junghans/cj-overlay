# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Some useful ccache wrappers"
HOMEPAGE="https://github.com/junghans/cj-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/ccache"

S="${T}"

src_install () {
	newbin "${FILESDIR}/ccached-${PV}" ccached
	newbin "${FILESDIR}/camake-${PV}" camake
}

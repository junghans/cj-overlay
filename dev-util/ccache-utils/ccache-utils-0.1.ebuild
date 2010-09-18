# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

DESCRIPTION="Some useful ccache wrappers"
HOMEPAGE="http://cj-overlay.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="dev-util/ccache"

src_install () {
	newbin "${FILESDIR}/ccached-${PV}" ccached
	newbin "${FILESDIR}/camake-${PV}" camake
}

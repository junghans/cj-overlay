# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Manages the /usr/bin/awk symlink"
HOMEPAGE="http://cj-overlay.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${T}"

src_install() {
	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/awk.eselect-${PV}" awk.eselect || die
}

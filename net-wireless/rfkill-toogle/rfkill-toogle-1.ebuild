# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="script to toggle rfkill status"
HOMEPAGE="http://code.google.com/p/cj-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-wireless/rfkill"
RDEPEND="${DEPEND}
	app-shells/bash"

S="${T}"

src_install() {
	cat > rfkill-toggle << EOF
#! /bin/bash
[ "\$(</sys/class/rfkill/rfkill0/state)" = "1" ] && $(type -p rfkill) block 0 || $(type -p rfkill) unblock 0
EOF
	dosbin rfkill-toggle
}

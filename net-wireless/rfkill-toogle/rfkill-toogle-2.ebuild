# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="script to toggle rfkill status"
HOMEPAGE="https://github.com/junghans"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="|| ( net-misc/networkmanager net-wireless/rfkill )"
RDEPEND="${DEPEND}
	app-shells/bash"

S="${T}"

src_install() {
	cat > rfkill-toggle << "EOF"
#! /bin/bash
if [[ "$(</sys/class/rfkill/rfkill0/state)" = 1 ]]; then
	[[ -n $(type -p nmcli) ]] && $(type -p nmcli) radio wifi off || $(type -p rfkill) block 0
else
	[[ -n $(type -p nmcli) ]] && $(type -p nmcli) radio wifi on || $(type -p rfkill) unblock 0
fi
EOF
	dobin rfkill-toggle
}

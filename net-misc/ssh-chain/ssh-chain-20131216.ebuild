# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/rdumpfs/rdumpfs-20131002.ebuild,v 1.1 2013/11/25 00:41:57 ottxor Exp $

EAPI=5

inherit vcs-snapshot

COMMIT="6803c37d2a3a37b7787b9093202c7545cc6d127a"
DESCRIPTION="ssh via a chain of intermediary hosts"
HOMEPAGE="https://github.com/ryancdotorg/ssh-chain"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

src_install() {
	dobin "${PN}"
	dodoc README
}

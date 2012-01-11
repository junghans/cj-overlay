# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="tailf from sys-apps/util-linux"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/util-linux/"

MY_PV="${PV/_/-}"
MY_P="util-linux-${MY_PV}"
S="${WORKDIR}/${MY_P}/text-utils"

SRC_URI="mirror://kernel/linux/utils/util-linux/v${PV:0:4}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="!prefix? ( !sys-apps/util-linux )
	prefix? ( !<sys-apps/util-linux-2.18 )"

src_compile() {
	einfo $(tc-getCC) ${CFLAGS} ${LDFLAGS} -I../include -o ${PN} ${PN}.c
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -I../include -o ${PN} ${PN}.c || die
}

src_install () {
	dobin "${PN}"
}

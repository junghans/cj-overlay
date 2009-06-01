# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsps/cvsps-2.1.ebuild,v 1.19 2008/06/10 18:17:10 armin76 Exp $

PATCH_LEVEL="5"

inherit eutils

MY_P="${P/_/}"
DESCRIPTION="Generates patchset information from a CVS repository"
HOMEPAGE="http://www.cobite.com/cvsps/"
SRC_URI="http://www.cobite.com/cvsps/${MY_P}.tar.gz
         mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}-${PATCH_LEVEL}.diff.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="sys-libs/zlib"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}/${P/-/_}-${PATCH_LEVEL}.diff"
	epatch "${S}/debian/patches/"*.dpatch
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dobin cvsps || die
	doman cvsps.1
	dodoc README CHANGELOG
}

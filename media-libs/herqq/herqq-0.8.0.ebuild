# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit qt4-r2

DESCRIPTION="A software library for building UPnP devices"
HOMEPAGE="http://www.herqq.org"
SRC_URI="mirror://sourceforge/hupnp/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_configure() {
	eqmake4 herqq.pro PREFIX="${EPREFIX}/usr"
}

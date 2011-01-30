# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio-ftps/kio-ftps-0.2.ebuild,v 1.2 2011/01/28 15:39:20 scarabeus Exp $

EAPI=3

EGIT_REPO_URI="git://anongit.kde.org/kio-upnp-ms"
EGIT_BRANCH="master"

inherit git kde4-base

DESCRIPTION="A upnp KIO slave for KDE"
HOMEPAGE="https://projects.kde.org/projects/playground/base/kio-upnp-ms"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=media-libs/herqq-0.8.0"

S="${WORKDIR}/${PN}"

src_unpack() {
	git_src_unpack
}

src_prepare() {
	cp "${FILESDIR}"/FindHUpnp.cmake "${T}"
	mycmakeargs=( -DCMAKE_MODULE_PATH=${T} -DHUPNP_INCLUDE_DIR=/usr/include )
}

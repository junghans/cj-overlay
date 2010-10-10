# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit prefix

DESCRIPTION="Script to follow build.log of running ebuilds"
HOMEPAGE="http://cj-overlay.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-apps/sed
	sys-apps/util-linux
	sys-apps/coreutils
	app-shells/bash"

src_prepare() {
	cp "${FILESDIR}/showbuild-${PV}" "${T}"/showbuild
	eprefixify "${T}"/showbuild
}

src_install () {
	dobin "${T}"/showbuild
}

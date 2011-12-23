# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit prefix

DESCRIPTION="Script to follow build.log of running ebuilds"
HOMEPAGE="http://cj-overlay.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="
	prefix? ( sys-apps/coreutils )
	!prefix? ( sys-apps/util-linux )
	app-shells/bash"

S="${T}"

src_prepare() {
	cp "${FILESDIR}/showbuild-${PV}" "${T}"/showbuild || die
	eprefixify "${T}"/showbuild
	if use prefix; then
		sed -i 's/tailf/tail -f/' "${T}"/showbuild || die
	fi
}

src_install () {
	dobin "${T}"/showbuild
}

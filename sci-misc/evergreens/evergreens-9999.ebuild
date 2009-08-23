# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit mercurial

DESCRIPTION="Christoph's useful scripts"
HOMEPAGE="http://epia/hg/evergreens/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
		sys-apps/gawk"

EHG_REPO_URI="${HOMEPAGE}"

S="${WORKDIR}/${PN}"

src_install () {
	local exe
	for exe in fcat findgrep fvim guard in2m4 loggrep qtar vimless; do
		dobin ${exe}
	done
	dosym fcat /usr/bin/fless
}

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

SCRIPTS_TO_INSTALL="fcat findgrep fvim guard in2m4 loggrep qtar vimless"

src_install () {
	pwd
	local exe
	for exe in ${SCRIPTS_TO_INSTALL}; do
		dobin ${exe}
	done
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit mercurial

DESCRIPTION="Christoph's useful scripts"
HOMEPAGE="http://code.google.com/p/cj-overlay/source/list?repo=evergreens"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples tk"

DEPEND=""
RDEPEND="dev-lang/perl
		sys-apps/gawk
		sys-apps/sed
		app-shells/bash
		app-text/wdiff
		app-text/a2ps
		app-editors/vim
		tk? ( dev-util/tkdiff )"

EHG_REPO_URI="https://evergreens.cj-overlay.googlecode.com/hg/"

S="${WORKDIR}/hg"

src_install () {
	dobin fcat findgrep fvim guard hgrep loggrep sshalias vimless vimmanless cwdiff
	dosym fcat /usr/bin/fless
	dosym fcat /usr/bin/fview
	dodoc README
	exeinto /usr/share/${PN}/examples
	doexe skeleton.*
}

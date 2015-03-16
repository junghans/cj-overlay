# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-r3

DESCRIPTION="Some useful scripts for gnuplot"
HOMEPAGE="https://github.com/junghans/gnuplotutils"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="sys-apps/help2man"
RDEPEND="dev-lang/perl
		sys-apps/sed
		sci-visualization/gnuplot
		virtual/latex-base
		app-text/ghostscript-gpl
		sys-apps/coreutils"

EGIT_REPO_URI="https://github.com/junghans/gnuplotutils.git git://github.com/junghans/gnuplotutils.git"

src_install() {
	emake DESTDIR="${ED}" install
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools mercurial

DESCRIPTION="Some useful scripts for gnuplot"
HOMEPAGE="http://gnuplotutils.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="examples"

DEPEND=""
RDEPEND="dev-lang/perl
		sys-apps/gawk
		sys-apps/sed
		sci-visualization/gnuplot
		virtual/latex-base
		app-text/txt2tags
		virtual/ghostscript
		sys-process/procps
		sys-apps/coreutils"

EHG_REPO_URI="https://gnuplotutils.googlecode.com/hg/"

S="${WORKDIR}/hg"

src_prepare() {
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	econf || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc TODO
	if use examples; then
		exeinto /usr/share/doc/${PF}/examples
		doexe examples/demo.sh
	fi
}

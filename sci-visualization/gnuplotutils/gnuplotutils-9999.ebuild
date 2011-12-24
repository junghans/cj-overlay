# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils mercurial

DESCRIPTION="Some useful scripts for gnuplot"
HOMEPAGE="http://gnuplotutils.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-macos"
IUSE="examples"

DEPEND=""
RDEPEND="dev-lang/perl
		sys-apps/sed
		sci-visualization/gnuplot
		virtual/latex-base
		app-text/txt2tags
		app-text/ghostscript-gpl
		sys-apps/coreutils"

EHG_REPO_URI="https://gnuplotutils.googlecode.com/hg/"

S="${WORKDIR}/${EHG_REPO_URI##*/}"

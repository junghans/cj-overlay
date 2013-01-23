# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit mercurial

DESCRIPTION="Christoph's useful scripts"
HOMEPAGE="http://code.google.com/p/cj-overlay/source/list?repo=evergreens"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-macos"
IUSE="examples tk vim"

DEPEND=""
RDEPEND="
	dev-lang/perl
	sys-apps/sed
	app-shells/bash
	sys-apps/grep
	dev-util/cwdiff
	sys-apps/coreutils
	vim? ( app-editors/vim )
	tk? ( dev-util/tkdiff )"

EHG_REPO_URI="https://code.google.com/p/cj-overlay.evergreens/"

S="${WORKDIR}/${EHG_REPO_URI##*/}"

src_install () {
	dobin fcat findgrep guard hgrep loggrep sshalias
	use vim && dobin wvim fvim vimless vimmanless
	dosym fcat /usr/bin/fless
	dosym fcat /usr/bin/fview
	dodoc README
	exeinto /usr/share/${PN}/examples
	use examples && doexe skeleton.*
}

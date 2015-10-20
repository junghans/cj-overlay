# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit git-r3

DESCRIPTION="Christoph's useful scripts"
HOMEPAGE="https://github.com/junghans/evergreens"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples tk vim"

DEPEND=""
RDEPEND="
	dev-lang/perl
	sys-apps/sed
	app-shells/bash
	sys-apps/grep
	dev-util/cwdiff
	sys-apps/coreutils
	kernel_linux? ( sys-fs/inotify-tools )
	vim? ( app-editors/vim )
	tk? ( dev-util/tkdiff )"

EGIT_REPO_URI="https://github.com/junghans/evergreens.git git://github.com/junghans/evergreens.git"

src_install () {
	dobin fcat findgrep guard hgrep loggrep sshalias
	use vim && dobin wvim fvim vimless vimmanless
	dosym fcat /usr/bin/fless
	dosym fcat /usr/bin/fview
	dodoc README.md
	insinto /usr/share/${PN}
	doins Makefile.incl
	exeinto /usr/share/${PN}/examples
	use examples && doexe skeleton.*
}

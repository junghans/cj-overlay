# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rssh/rssh-2.3.4.ebuild,v 1.5 2013/01/05 21:35:40 pinkbyte Exp $

EAPI=5
inherit autotools-utils multilib

DESCRIPTION="Restricted shell for SSHd"
HOMEPAGE="http://rssh.sourceforge.net/"
MY_P="${P/%_p*}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV/_p/-}.debian.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="static"

RDEPEND="virtual/ssh"

EPATCH_SUFFIX="diff"
EPATCH_FORCE="yes"
PATCHES=( "${WORKDIR}"/debian/patches/fixes "${FILESDIR}/${P}"-autotools.patch )
AUTOTOOLS_AUTORECONF=1 #due to debian patches
S="${WORKDIR}/${MY_P}"
DOCS=( AUTHORS ChangeLog CHROOT INSTALL README TODO )

src_configure() {
	local myeconfargs=(
		--libexecdir="/usr/$(get_libdir)/misc"
		--with-scp=/usr/bin/scp
		--with-sftp-server="/usr/$(get_libdir)/misc/sftp-server"
		$(use_enable static)
	)
	autotools-utils_src_configure
}

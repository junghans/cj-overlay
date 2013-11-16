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
IUSE="static subversion"

RDEPEND="virtual/ssh"

S="${WORKDIR}/${MY_P}"
DOCS=( AUTHORS ChangeLog CHROOT INSTALL README TODO )

src_prepare() {
	epatch "${WORKDIR}"/debian/patches/fixes/*.diff "${FILESDIR}/${P}"-autotools.patch
	use subversion && epatch "${WORKDIR}"/debian/patches/features/subversion.diff
	AUTOTOOLS_AUTORECONF=1 autotools-utils_src_prepare #due to debian patches
}

src_configure() {
	local myeconfargs=(
		--libexecdir="/usr/$(get_libdir)/misc"
		--with-scp=/usr/bin/scp
		--with-sftp-server="/usr/$(get_libdir)/misc/sftp-server"
		$(use_enable static)
	)
	autotools-utils_src_configure
}

pkg_postinst() {
	if use subversion && [[ -f "${EROOT}"/etc/rssh.conf ]]; then
		grep -qE 'user=.*:[01]{5}:' "${EROOT}"/etc/rssh.conf && \
			ewarn "Your /etc/rssh.conf needs update, subversion support introduced an extra access bit!"
	fi
}

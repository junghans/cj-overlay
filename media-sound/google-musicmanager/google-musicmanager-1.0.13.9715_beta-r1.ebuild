# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

MY_PV="${PV/_beta}"
[[ ${PV} = *beta* ]] && MY_PN="${PN}-beta"
MY_URL="http://dl.google.com/linux/musicmanager/deb/pool/main/${P:0:1}/${MY_PN:=${PN}}"
MY_PKG="${MY_PN:=${PN}}_${MY_PV}-r0_i386.deb"

DESCRIPTION="Google Music Manager is a application for adding music to your Google Music library."
HOMEPAGE="http://music.google.com"
SRC_URI="x86? ( ${MY_URL}/${MY_PKG} )
	amd64? ( ${MY_URL}/${MY_PKG/i386/amd64} )"

LICENSE="google-talkplugin Apache-2.0 MIT LGPL-2.1 gSOAP BSD FDL-1.2 MPL-1.1 openssl ZLIB as-is"
SLOT="0"
KEYWORDS="-* ~x86"
IUSE="log"

RESTRICT="strip mirror"

RDEPEND="
	dev-libs/expat
	dev-libs/glib:2
	media-libs/flac
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libogg
	media-libs/libvorbis
	net-dns/libidn
	sys-libs/glibc
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/qt-core
	x11-libs/qt-gui
	log? ( dev-libs/log4cxx )
	"

DEPEND="app-arch/xz-utils
	app-admin/chrpath"

INSTALL_BASE="opt/google/musicmanager"

QA_TEXTRELS="${INSTALL_BASE}/libmpgdec.so.0"

S="${WORKDIR}/${INSTALL_BASE}"

pkg_nofetch() {
	einfo "This version is no longer available from Google."
	einfo "Note that Gentoo cannot mirror the distfiles due to license reasons, so we have to follow the bump."
	einfo "Please file a version bump bug on http://bugs.gentoo.org (search existing bugs for ${PN} first!)."
}

src_unpack() {
	unpack ${A} ./data.tar.lzma
}

src_install() {
	insinto "/${INSTALL_BASE}"
	doins config.xml product_logo*

	exeinto "/${INSTALL_BASE}"
	chrpath -d MusicManager || die
	doexe MusicManager google-musicmanager minidump_upload
	#unbundle this
	doexe libaacdec.so libaudioenc.so.0 libmpgdec.so.0 libid3tag.so

	dosym /"${INSTALL_BASE}"/google-musicmanager /opt/bin/

	make_desktop_entry "${PN}" "Google Music Manager" \
		"/${INSTALL_BASE}/product_logo_32.xpm" "AudioVideo;Audio;Player;Music"
}

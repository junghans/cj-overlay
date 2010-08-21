# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit nsplugins

DESCRIPTION="Google Talk Plugin"
SRC_URI="x86? ( http://dl.google.com/linux/direct/google-talkplugin_current_i386.deb )
	amd64? ( http://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb )"
HOMEPAGE="http://www.google.com/chat/video"
IUSE=""
SLOT="0"

KEYWORDS="-* ~amd64 ~x86"
LICENSE=""
RESTRICT="strip mirror"

#from debian control file and ldd
RDEPEND="|| ( media-sound/pulseaudio media-libs/alsa-lib )
	>=sys-libs/glibc-2.4
	media-libs/fontconfig
	media-libs/freetype:2
	virtual/opengl
	media-libs/glew
	dev-libs/glib:2
	x11-libs/gtk+:2
	media-libs/libpng:1.2
	dev-libs/openssl
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXt"

QA_TEXTRELS_x86="opt/google/talkplugin/libnpgtpo3dautoplugin.so
	opt/google/talkplugin/libnpgoogletalk.so"

QA_TEXTRELS_amd64="opt/google/talkplugin/libnpgtpo3dautoplugin.so
	opt/google/talkplugin/libnpgoogletalk64.so"

src_unpack() {
	unpack ${A} ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
}

src_install() {
	dodoc ./usr/share/doc/google-talkplugin/changelog.Debian

	cd "opt/google/talkplugin"
	exeinto "/opt/google/talkplugin"
	doexe GoogleTalkPlugin libnpgtpo3dautoplugin.so
	inst_plugin /opt/google/talkplugin/libnpgtpo3dautoplugin.so

	use x86 && doexe libnpgoogletalk.so
	use x86 && inst_plugin /opt/google/talkplugin/libnpgoogletalk.so
	
	use amd64 && doexe libnpgoogletalk64.so
	use amd64 && inst_plugin /opt/google/talkplugin/libnpgoogletalk64.so

	exeinto "/opt/google/talkplugin/lib"
	cd lib
	doexe *.so
}

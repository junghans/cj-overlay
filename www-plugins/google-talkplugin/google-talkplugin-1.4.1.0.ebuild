# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit multilib nsplugins

if [ "${PV}" != "9999" ]; then
	MY_URL="http://dl.google.com/linux/talkplugin/deb/pool/main/${P:0:1}/${PN}"
	DEB_PATCH="1"
	MY_32B_PKG="${PN}_${PV}-${DEB_PATCH}_i386.deb"
	MY_64B_PKG="${PN}_${PV}-${DEB_PATCH}_amd64.deb"
else
	MY_URL="http://dl.google.com/linux/direct"
	MY_32B_PKG="${PN}_current_i386.deb"
	MY_64B_PKG="${PN}_current_amd64.deb"
fi

DESCRIPTION="Video chat browser plug-in for Google Talk"
SRC_URI="x86? ( ${MY_URL}/${MY_32B_PKG} )
	amd64? (
		multilib? (
			32bit? ( ${MY_URL}/${MY_32B_PKG} )
			64bit? ( ${MY_URL}/${MY_64B_PKG} )
		)
		!multilib? ( ${MY_URL}/${MY_64B_PKG} )
	)"

HOMEPAGE="http://www.google.com/chat/video"
IUSE="nspluginwrapper +system-libCg 32bit 64bit"
SLOT="0"

KEYWORDS="-* ~amd64 ~x86"
LICENSE="UNKNOWN"
RESTRICT="strip mirror"

#from debian control file and ldd
NATIVE_DEPS="|| ( media-sound/pulseaudio media-libs/alsa-lib )
	>=sys-libs/glibc-2.4
	media-libs/fontconfig
	media-libs/freetype:2
	virtual/opengl
	media-libs/glew
	dev-libs/glib:2
	x11-libs/gtk+:2
	media-libs/libpng:1.2
	media-libs/libpng:0
	dev-libs/openssl
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXt
	x11-libs/libxcb
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXxf86vm
	x11-libs/libXdamage
	x11-libs/libxcb
	x11-libs/libdrm
	x11-libs/libSM
	x11-libs/libICE
	x11-libs/pango
	x11-libs/libXi
	dev-libs/atk
	x11-libs/cairo
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXcomposite
	x11-libs/libXrender
	dev-libs/expat
	sys-apps/util-linux
	x11-libs/pixman
	x11-libs/xcb-util
	system-libCg? ( media-gfx/nvidia-cg-toolkit )
	sys-apps/lsb-release
	sys-libs/zlib"

DEPEND="amd64? ( nspluginwrapper? ( www-plugins/nspluginwrapper ) )"

EMUL_DEPS=">=app-emulation/emul-linux-x86-baselibs-20100220
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs"

RDEPEND="x86? ( ${NATIVE_DEPS} )
	amd64? (
		multilib? (
			64bit? ( ${NATIVE_DEPS} )
			32bit? ( ${EMUL_DEPS} )
		)
		!multilib? ( ${NATIVE_DEPS} )
	)"

INSTALL_BASE="opt/google/talkplugin"

[ "${ARCH}" = "amd64" ] && SO_SUFFIX="64" || SO_SUFFIX=""

QA_TEXTRELS="${INSTALL_BASE}/libnpgtpo3dautoplugin.so
	${INSTALL_BASE}/libnpgoogletalk${SO_SUFFIX}.so"

QA_TEXTRELS_amd64="${INSTALL_BASE}32/libnpgtpo3dautoplugin.so
	${INSTALL_BASE}32/libnpgoogletalk.so"

rm_nswrapper_plugin() {
	#remove all wrapped plugins 
	local i plugin
	if use amd64 && has_version 'www-plugins/nspluginwrapper'; then
		for i in libnpgtpo3dautoplugin.so libnpgoogletalk.so; do
			plugin=$(nspluginwrapper -l | grep -e "^/.*$i")
			if [[ -f ${plugin} ]]; then
				einfo "Removing 32-bit plugin wrapper: ${plugin}"
				nspluginwrapper -r "${FLASH_WRAPPER}"
			fi
		done
	fi
}

pkg_setup() {
	if use x86; then
		export MY_INSTALL_TYPE="native"
	elif use amd64; then
		if use multilib; then
			if use 32bit && use 64bit; then
				export MY_INSTALL_TYPE="both"
			elif use 64bit; then
				export MY_INSTALL_TYPE="native"
			elif use 32bit; then
				export MY_INSTALL_TYPE="cross"
			else
				eerror "You must select at least one library USE flag (32bit or 64bit)"
				die "No library version selected [-32bit -64bit]"
			fi
		else
			export MY_INSTALL_TYPE="native"
		fi
	fi
}

src_unpack() {
	if [ "${MY_INSTALL_TYPE}" = "native" ]; then
		unpack ${A} ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
	else # cross or both
		mkdir 32bit
		cd 32bit
		unpack ${MY_32B_PKG} ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
		cd ..
	fi

	if [ "${MY_INSTALL_TYPE}" = "both" ]; then
		unpack ${MY_64B_PKG} ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
	fi
}

src_install() {
	if [ "${MY_INSTALL_TYPE}" != "cross" ]; then #native or both
		dodoc ./usr/share/doc/google-talkplugin/changelog.Debian

		cd "./${INSTALL_BASE}"
		exeinto "/${INSTALL_BASE}"
		doexe GoogleTalkPlugin libnpgtpo3dautoplugin.so	libnpgoogletalk"${SO_SUFFIX}".so
		inst_plugin /"${INSTALL_BASE}"/libnpgtpo3dautoplugin.so
		inst_plugin /"${INSTALL_BASE}"/libnpgoogletalk"${SO_SUFFIX}".so

		#install bundled libCg
		if ! use system-libCg; then
			cd lib
			exeinto /"${INSTALL_BASE}/lib"
			doexe *.so
		fi
	fi

	if [ "${MY_INSTALL_TYPE}" != "native" ]; then #cross or both
		cd 32bit

		cd "./${INSTALL_BASE}"
		exeinto "/${INSTALL_BASE}32"
		doexe GoogleTalkPlugin libnpgtpo3dautoplugin.so	libnpgoogletalk.so

		#install bundled libCg
		if ! use system-libCg; then
			cd lib
			exeinto /"${INSTALL_BASE}"32/lib
			doexe *.so
		fi
	fi
}

pkg_prerm() {
	rm_nswrapper_plugin
}

pkg_postinst() {
	local i
	if use amd64; then
		if [ "${MY_INSTALL_TYPE}" = "cross" ]; then
			if has_version 'www-plugins/nspluginwrapper'; then
				#install 32bit plugins for 64bit browsers
				oldabi="${ABI}"
				ABI="x86"
				einfo "nspluginwrapper detected: Installing plugin wrapper"
				for i in libnpgtpo3dautoplugin.so libnpgoogletalk.so; do
					[ -f "${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/$i" ] || \
						die "plugin $i not found"
					nspluginwrapper -i "${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/$i"
				done
				ABI="${oldabi}"
			else
				einfo "To use the 32-bit plugins in a native 64-bit firefox,"
				einfo "you must install www-plugins/nspluginwrapper and run"
					for i in libnpgtpo3dautoplugin.so libnpgoogletalk.so; do
					einfo "nspluginwrapper -i '${ROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/$i'"
				done
			fi
		else #both or native
			rm_nswrapper_plugin
		fi
	fi
}

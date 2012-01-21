# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/google-chrome/google-chrome-16.0.912.75_p116452.ebuild,v 1.1 2012/01/06 02:28:45 floppym Exp $

EAPI="4"

inherit multilib

DESCRIPTION="pdf plugin from google-chrome to be used with chromium"
HOMEPAGE="http://www.google.com/chrome"

case ${PV} in
	*_alpha*)
		ISLOT="unstable"
		MY_PV=${PV/_alpha/-r}
		;;
	*_beta*)
		SLOT="beta"
		MY_PV=${PV/_beta/-r}
		;;
	*_p*)
		SLOT="stable"
		MY_PV=${PV/_p/-r}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac

MY_PN="${PN%-libpdf}-${SLOT}"
MY_P="${MY_PN}_${MY_PV}"

SRC_BASE="http://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_"
SRC_URI="amd64? ( ${SRC_BASE}amd64.deb ) x86? ( ${SRC_BASE}i386.deb )"

LICENSE="google-chrome"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="mirror strip"
SLOT="0"

RDEPEND=""

QA_PREBUILT="*"
S=${WORKDIR}

chrome_unpack() {
	local x
	for x in "${@}"; do
		if [[ ${x} == *.deb ]]; then
			# Avoid automagic usage of deb2targz.
			echo ">>> Unpacking ${x} to ${PWD}"
			ar x "${DISTDIR}/${x}" || die
		else
			unpack "${x}"
		fi
	done
}

src_unpack() {
	chrome_unpack ${A} ./data.tar.lzma
}

src_install() {
	insinto "/usr/$(get_libdir)/chromium-browser/"
	doins opt/google/chrome/libpdf.so
}

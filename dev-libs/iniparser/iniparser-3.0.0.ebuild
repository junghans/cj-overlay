# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/iniparser/iniparser-3.0b-r2.ebuild,v 1.4 2010/09/26 16:58:44 leio Exp $

EAPI="4"

inherit eutils multilib

DESCRIPTION="A free stand-alone ini file parsing library."
HOMEPAGE="http://ndevilla.free.fr/iniparser/"

#name this version 3.0.0 instead of 3.0 as 3.0.0 > 3.0b > 3.0 
SRC_URI="http://ndevilla.free.fr/iniparser/${P%.0}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples static-libs"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

# the tests are rather examples than tests, no point in running them
RESTRICT="test"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-3.0b-cpp.patch" \
		"${FILESDIR}/${PN}-3.0b-makefile.patch"

	sed -i \
		-e "s|/usr/lib|${EPREFIX}/usr/$(get_libdir)|g" \
		Makefile || die "sed failed"
}

src_compile() {
	local targets="libiniparser.so"
	use static-libs && targets="${targets} libiniparser.a"

	emake ${targets}
}

src_install() {
	dolib libiniparser.so.0
	dosym libiniparser.so.0 /usr/$(get_libdir)/libiniparser.so

	use static-libs && dolib libiniparser.a

	insinto /usr/include
	doins src/*.h

	dodoc AUTHORS README

	if use doc; then
		emake -C doc
		dohtml html/*
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins test/*.{c,ini,py}
	fi
}

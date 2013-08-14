# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="portage kernel set, prevents kernels from been depcleaned"
HOMEPAGE="http://gentoo-pr.org/node/18"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/portage-2.2"

S="${T}"

src_install() {
	dodir /usr/share/portage/config/sets
	cat > "${ED}"/usr/share/portage/config/sets/kernels.conf <<EOF
[kernels]
class = portage.sets.dbapi.OwnerSet
world-candidate = False
files = /usr/src
EOF
}

pkg_postinst() {
	if ! grep -q "^@kernel$" "${EROOT}"/var/lib/portage/world_sets; then
		echo "@kernels" >> "${EROOT}"/var/lib/portage/world_sets || die
	fi
}

pkg_postrm() {
	if grep -q "^@kernels$" "${EROOT}"/var/lib/portage/world_sets; then
		sed -i '/^@kernels$/d' "${EROOT}"/var/lib/portage/world_sets || die
	fi
}

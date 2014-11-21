# Copyright 1999-2014 Gentoo Foundation
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
	cat > "${T}"/kernels.conf <<EOF
[kernels]
class = portage.sets.dbapi.OwnerSet
world-candidate = True
files = /usr/src
EOF
	insinto /usr/share/portage/config/sets
	doins "${T}"/kernels.conf
}

pkg_postinst() {
	if ! grep -q "^@kernel$" "${EROOT}"/var/lib/portage/world_sets; then
	  elog "Please run 'emerge --noreplace @kernels' to actually"
	  elog "prevent kernels from being depcleaned"
	fi
}

pkg_postrm() {
	emerge --deselect @kernels || die
}

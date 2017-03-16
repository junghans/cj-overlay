# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="init.d script to stop vms on shutdown"
HOMEPAGE="https://bugs.gentoo.org/show_bug.cgi?id=403337"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="app-emulation/virtualbox"

S="${T}"

src_install() {
cat > virtualbox <<"EOF"
#!/sbin/runscript
# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

stop() {
	local user uuid name
	for user in $(/usr/sbin/groupmems -g vboxusers -l); do
  		for uuid in $(su - $user -c '/usr/bin/VBoxManage -q list runningvms' | sed -n 's/^.*{\([^}]*\)}$/\1/p'); do
			name=$(su - $user -c "/usr/bin/VBoxManage showvminfo $uuid" | awk '/^Name:/{print $2}')
			ebegin "Save state of vm '$name' of user $user"
			su - $user -c "/usr/bin/VBoxManage controlvm $uuid savestate" &>/dev/null
	          	eend $?
		done
	done
}
EOF
	doinitd virtualbox
}

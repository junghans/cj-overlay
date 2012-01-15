# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/rpm.eclass,v 1.22 2011/12/27 17:55:12 fauli Exp $

# @ECLASS: deb.eclass
# @MAINTAINER:
# base-system@gentoo.org
# @AUTHOR:
# Author: Christoph Junghans <ottxor@gentoo.org>
# @BLURB: convenience class for extracting deb packages

case ${EAPI:-0} in
	3|4) ;;
	*) die "EAPI ${EAPI} unsupported (yet)."
esac

inherit eutils

# Unpacking .deb archives is usually be done with ar.
# On AIX this doesn't work out.
[[ ${CHOST} == *-aix* ]] && DEPEND=">=app-arch/deb2targz-1-r2"

# @FUNCTION: deb_src_unpack
# @USAGE: <debs>
# @DESCRIPTION:
# Unpack the contents of the specified debs like the unpack() function and
# data.tar.* therein. Non-deb files will given to unpack directly.
deb_src_unpack() {
	[[ $# -eq 0 ]] && set -- ${A}
	local x
	for x in "$@" ; do
		if [[ ${x} != *.deb ]]; then
			unpack "${x}"
			continue
		fi

		echo ">>> Unpacking ${x} to ${PWD}"

		if [[ ${x} == "./"* ]] ; then
			srcdir=""
		elif [[ ${x} == ${DISTDIR%/}/* ]] ; then
			die "Arguments to deb_src_unpack() cannot begin with \${DISTDIR}."
		elif [[ ${x} == "/"* ]] ; then
			die "Arguments to deb_src_unpack() cannot be absolute"
		else
			srcdir="${DISTDIR}/"
		fi
		[[ ! -s ${srcdir}${x} ]] && die "${x} does not exist"

		#prefer `ar` over `deb2targz`
		if type -P deb2targz > /dev/null; then
			local y=${x##*/}
			local symlink=0
			if [ ! "${srcdir}${x}" -ef "${y}" ] ; then
				# deb2targz always extracts into the same directory as
				# the source file, so create a symlink in the current
				# working directory if necessary.
				ln -sf "${srcdir}${x}" "${y}" || \
					die "Failed to create symlink for deb2targz"
				symlink=1
			fi
			deb2targz "$y" || die "Failed to unpack $x using deb2targz"
			if [ ${symlink} = 1 ] ; then
				# Clean up the symlink so the ebuild
				# doesn't inadvertently install it.
				rm -f "${y}"
			fi
			unpack ./"${y%.deb}".tar.*
		else
			ar x "${srcdir}${x}" || die "Failed to unpack $x using ar"
			unpack ./data.tar.*
		fi
	done
}

EXPORT_FUNCTIONS src_unpack

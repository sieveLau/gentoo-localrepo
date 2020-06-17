# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#EGIT_REPO_URI="https://github.com/MaskRay/${PN}"

#if [[ ${PV} = 9999* ]]; then
#	GIT_ECLASS="git-r3"
#fi

#inherit ${GIT_ECLASS}

DESCRIPTION="C/C++/ObjC language server"
HOMEPAGE="https://github.com/MaskRay/ccls"

if [[ ${PV} == *9999 ]] ; then
	SRC_URI=""
else
	SRC_URI="https://github.com/MaskRay/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

DEPEND="
	dev-libs/rapidjson
	sys-devel/clang:=
	sys-devel/llvm:=
"
RDEPEND="${DEPEND}"

src_unpack(){
	cp -r /usr/src/ccls .
}
S=${WORKDIR}/${PN}
src_configure() {
	cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DUSE_SYSTEM_RAPIDJSON=ON
}

src_compile(){
	cmake --build Release
}

src_install(){
	into /
	dobin Release/ccls
}

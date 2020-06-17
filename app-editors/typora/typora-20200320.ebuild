# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="markdown editor"
HOMEPAGE="https://typora.io"
SRC_URI="https://typora.io/linux/Typora-linux-x64.tar.gz -> typora-${PV}-linux-x64.tar.gz"

LICENSE="EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	x11-libs/libXScrnSaver
	${DEPEND}"
BDEPEND=""

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
	fi
	S=${WORKDIR}/bin/Typora-linux-x64/
	echo -e "[Desktop Entry]\n\
Version=1.0\n\
Name=Typora\n\
Comment=Markdown editor\n\
Exec=/usr/bin/typora\n\
StartupNotify=true\n\
Type=Application
" > ${S}/Typora.desktop
}



src_install() {
	insinto /opt/
	doins -r ${S}
	dosym /opt/Typora-linux-x64/Typora /usr/bin/typora
	fperms 0755 /opt/Typora-linux-x64/Typora
	fperms 4755 /opt/Typora-linux-x64/chrome-sandbox
	insinto /usr/share/applications/
	doins ${S}/Typora.desktop
}

pkg_postinst() {
	update-desktop-database
}

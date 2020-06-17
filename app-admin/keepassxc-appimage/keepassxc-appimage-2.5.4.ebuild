# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="KeePass Cross-Platform Community Edition"
HOMEPAGE="https://keepassxc.org/"
SRC_URI="https://github.com/keepassxreboot/keepassxc/releases/download/${PV}/KeePassXC-${PV}-x86_64.AppImage"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=sys-fs/fuse-2.9.9-r1:0
	<sys-fs/fuse-3
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	mkdir -p ${S}
	cp ${DISTDIR}/* ${S}
	echo -e "[Desktop Entry]\n\
Version=1.0\n\
Name=KeepassXC\n\
Comment=KeePass Cross-Platform Community Edition\n\
Exec=/opt/keepassxc-appimage-${PV}/KeePassXC-${PV}-x86_64.AppImage\n\
StartupNotify=true\n\
Type=Application
" > ${S}/KeepassXC.desktop
}



src_install() {
	insinto /opt/
	doins -r ${S}
	dosym /opt/${P}/KeePassXC-${PV}-x86_64.AppImage /usr/local/bin/keepassxc
	fperms 0755 /opt/${P}/KeePassXC-${PV}-x86_64.AppImage
	insinto /usr/share/applications/
	doins ${S}/KeepassXC.desktop
}

pkg_postinst() {
	update-desktop-database
}

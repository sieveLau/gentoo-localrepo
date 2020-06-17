# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PV="v${PV}"

DESCRIPTION="A platform for building proxies to bypass network restrictions."
HOMEPAGE="https://github.com/v2ray/v2ray-core"
SRC_URI="amd64? ( https://github.com/v2ray/v2ray-core/releases/download/$MY_PV/v2ray-linux-64.zip -> v2ray-$PV-linux-64.zip ) "

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	if [ "${A}" != "" ]; then
			unpack ${A}
	fi
	S=${WORKDIR}
}

src_prepare(){
	default
	mv config.json config.json.example
	touch v2ray-screen.sh
	echo "#\!/bin/sh" > v2ray-screen.sh
	echo "screen -d -m v2ray" > v2ray-screen.sh
}

src_install(){
	local DEST="/opt/${PN}"
	insinto "${DEST}"
	doins -r *
	fperms +x "${DEST}/v2ray"
	fperms +x "${DEST}/v2ctl"
	fperms +x "${DEST}/v2ray-screen.sh"
	dosym "${DEST}/v2ray-screen.sh" "/usr/bin/v2ray"
}

#!/usr/bin/bash
# https://github.com/zq1997/deepin-wine
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

filepath="${HOME}/Downloads/setup.sh"
download "https://deepin-wine.i-m.dev/setup.sh" "${filepath}"
call bash "${filepath}"
call sudo apt install com.qq.weixin.deepin
Exec='env DEEPIN_WINE_SCALE=2 "/opt/apps/com.qq.weixin.deepin/files/run.sh" -f %f'
Name="WeChat"
StartupWMClass="WeChat.exe"
Icon="/opt/apps/com.qq.weixin.deepin/entries/icons/hicolor/48x48/apps/com.qq.weixin.deepin.png"
make-desktop-entry "wechat"

#!/usr/bin/zsh
set -o errexit
set -o nounset

source "${PKG_HOME}/utility.zsh"

version="${version:-"0.20.6"}"
filename="Clash.for.Windows-${version}-x64-linux.tar.gz"
filepath="${HOME}/Downloads/${filename}"
download "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${version}/${filename}" "${filepath}"

ext "${filepath}" "${HOME}/.local/opt"
rm --force --recursive "${HOME}/.local/opt/clash-for-windows"
mv "${HOME}/.local/opt/Clash for Windows-${version}-x64-linux" "${HOME}/.local/opt/clash-for-windows"

# install desktop entry
download "https://github.com/Dreamacro/clash/raw/master/docs/logo.png" "${HOME}/.local/opt/clash-for-windows/logo.png"
name="Clash for Windows"
exec="${HOME}/.local/opt/clash-for-windows/cfw"
icon="${HOME}/.local/opt/clash-for-windows/logo.png"
desktop-entry-install "clash-for-windows"

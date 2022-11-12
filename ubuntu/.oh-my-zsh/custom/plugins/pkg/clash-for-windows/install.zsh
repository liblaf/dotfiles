#!/usr/bin/zsh
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.zsh"

version="${version:-"0.20.7"}"
filename="Clash.for.Windows-${version}-x64-linux.tar.gz"
filepath="${HOME}/Downloads/${filename}"
download "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${version}/${filename}" "${filepath}"

ext "${filepath}" "${HOME}/.local/opt"
replace "${HOME}/.local/opt/Clash for Windows-${version}-x64-linux" "${HOME}/.local/opt/clash-for-windows"

# install desktop entry
download "https://github.com/Dreamacro/clash/raw/master/docs/logo.png" "${HOME}/.local/opt/clash-for-windows/logo.png"
Name="Clash for Windows"
Exec="${HOME}/.local/opt/clash-for-windows/cfw"
Icon="${HOME}/.local/opt/clash-for-windows/logo.png"
make-desktop-entry "clash-for-windows"

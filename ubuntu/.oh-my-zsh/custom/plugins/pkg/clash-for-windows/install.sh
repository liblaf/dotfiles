#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

version="${version:-"0.20.3"}"
filename="Clash.for.Windows-${version}-x64-linux.tar.gz"
filepath="${HOME}/Downloads/${filename}"
download "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${version}/${filename}" "${filepath}"

extract "${filepath}" "${HOME}/.local/pkgs/"
rm --force --recursive "${HOME}/.local/pkgs/clash-for-windows"
mv "${HOME}/.local/pkgs/Clash for Windows-${version}-x64-linux" "${HOME}/.local/pkgs/clash-for-windows"

# install desktop entry
download "https://github.com/Dreamacro/clash/raw/master/docs/logo.png" "${HOME}/.local/pkgs/clash-for-windows/logo.png"
DESKTOP_FILE_INSTALL_DIR="${HOME}/.local/share/applications"
cat >"${DESKTOP_FILE_INSTALL_DIR}/clash-for-windows.desktop" <<-EOF
[Desktop Entry]
Type=Application
Name=Clash for Windows
Exec=${HOME}/.local/pkgs/clash-for-windows/cfw
Icon=${HOME}/.local/pkgs/clash-for-windows/logo.png
Terminal=false
EOF
desktop-file-install --dir="${DESKTOP_FILE_INSTALL_DIR}" "${DESKTOP_FILE_INSTALL_DIR}/clash-for-windows.desktop"

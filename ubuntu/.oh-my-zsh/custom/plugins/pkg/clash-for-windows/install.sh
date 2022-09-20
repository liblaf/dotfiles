#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

version="${version:-"0.20.3"}"
filename="Clash.for.Windows-${version}-x64-linux.tar.gz"
mkdir --parents "${HOME}/Downloads/"
filepath="${HOME}/Downloads/${filename}"
download "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${version}/${filename}" "${filepath}"
extract "${filepath}" "${HOME}/.local/pkgs/"
mv "${HOME}/.local/pkgs/Clash for Windows-${version}-x64-linux" "${HOME}/.local/pkgs/clash-for-windows"

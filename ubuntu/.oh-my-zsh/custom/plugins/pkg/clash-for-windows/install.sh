#!/usr/bin/env bash
set -o errexit
set -o nounset

source "$(dirname "$(dirname "${0}")")/utils.sh"

filename="Clash.for.Windows-0.19.26-x64-linux.tar.gz"
mkdir --parents "${HOME}/Downloads/"
filepath="${HOME}/Downloads/${filename}"
download "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.19.26/${filename}" "${filepath}"
extract "${filepath}" "${HOME}/.local/pkgs/"
mv "${HOME}/.local/pkgs/Clash for Windows-0.19.26-x64-linux" "${HOME}/.local/pkgs/clash-for-windows"

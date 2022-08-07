#!/usr/bin/env bash
set -o errexit
set -o nounset

filename="Clash.for.Windows-0.19.26-x64-linux.tar.gz"
mkdir --parents "${HOME}/Downloads/"
filepath="${HOME}/Downloads/${filename}"
wget --output-document="-" "https://github.com/Fndroid/clash_for_windows_pkg/releases/download/0.19.26/${filename}" |
  tee "${filepath}" >"/dev/null"
mkdir --parents "${HOME}/.local/pkgs/"
pv "${filepath}" |
  tar --extract --gzip --directory="${HOME}/.local/pkgs/"
mv "${HOME}/.local/pkgs/Clash for Windows-0.19.26-x64-linux" "${HOME}/.local/pkgs/clash-for-windows"

#!/usr/bin/env bash
set -o errexit
set -o nounset

rm --force --recursive "${HOME}/.local/pkgs/clash-for-windows/"

DESKTOP_FILE_INSTALL_DIR="${HOME}/.local/share/applications"
rm --force "${DESKTOP_FILE_INSTALL_DIR}/clash-for-windows.desktop"

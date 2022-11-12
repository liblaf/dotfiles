#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

remove "${HOME}/.local/opt/clash-for-windows"
remove "${DESKTOP_FILE_INSTALL_DIR}/clash-for-windows.desktop"

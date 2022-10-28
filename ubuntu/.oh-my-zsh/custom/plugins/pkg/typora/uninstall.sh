#!/usr/bin/bash
set -o errexit
set -o nounset

source "${PKG_HOME}/utility.sh"
rm --force --recursive "${HOME}/.local/opt/typora"
rm --force "${DESKTOP_FILE_INSTALL_DIR}/typora.desktop"

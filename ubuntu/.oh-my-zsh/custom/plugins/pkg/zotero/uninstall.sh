#!/usr/bin/bash
set -o errexit
set -o nounset

rm --force --recursive "${HOME}/.local/opt/zotero"
rm --force "${DESKTOP_FILE_INSTALL_DIR}/zotero.desktop"

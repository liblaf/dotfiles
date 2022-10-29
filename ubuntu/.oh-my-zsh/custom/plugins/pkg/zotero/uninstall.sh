#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force --recursive "${HOME}/.local/opt/zotero"
rm --force "${DESKTOP_FILE_INSTALL_DIR}/zotero.desktop"

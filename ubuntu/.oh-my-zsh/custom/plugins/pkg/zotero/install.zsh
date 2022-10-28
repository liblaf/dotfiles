#!/usr/bin/zsh
# https://www.zotero.org/download/
set -o errexit
set -o nounset

source "${PKG_HOME}/utility.zsh"

filename="Zotero-linux-x86_64.tar.bz2"
filepath="${HOME}/Downloads/${filename}"
url="https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64"
download "${url}" "${filepath}"
ext "${filepath}" "${HOME}/.local/opt"
replace "${HOME}/.local/opt/Zotero_linux-x86_64" "${HOME}/.local/opt/zotero"
"${HOME}/.local/opt/zotero/set_launcher_icon"
ln --force --symbolic "${HOME}/.local/opt/zotero/zotero.desktop" "${DESKTOP_FILE_INSTALL_DIR}/zotero.desktop"

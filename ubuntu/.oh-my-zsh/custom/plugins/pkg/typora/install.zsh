#!/usr/bin/zsh
# https://typora.io/#linux
set -o errexit
set -o nounset
set -o pipefail
set -o pipefail

source "${PKG_HOME}/utility.zsh"

filename="Typora-linux-x64.tar.gz"
filepath="${HOME}/Downloads/${filename}"
url="https://download.typora.io/linux/Typora-linux-x64.tar.gz"
download "${url}" "${filepath}"
ext "${filepath}" "${HOME}/.local/opt"
replace "${HOME}/.local/opt/bin/Typora-linux-x64" "${HOME}/.local/opt/typora"
remove "${HOME}/.local/opt/bin"

mkdir --parents "${HOME}/.local/bin"
link "${HOME}/.local/opt/typora/Typora" "${HOME}/.local/bin/typora"

Name="Typora"
Comment="a minimal Markdown reading & writing app. Change Log: (https://typora.io/windows/dev_release.html)"
GenericName="Markdown Editor"
Exec="${HOME}/.local/opt/typora/Typora %U"
Icon="${HOME}/.local/opt/typora/resources/assets/icon/icon_512x512.png"
StartupNotify="true"
Categories="Office;WordProcessor;"
MimeType="text/markdown;text/x-markdown;"
make-desktop-entry "typora"

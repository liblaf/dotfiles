#!/usr/bin/zsh
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.zsh"

FONTS_DIR="${HOME}/.local/share/fonts"
mkdir --parents "${FONTS_DIR}"

# https://github.com/romkatv/powerlevel10k#fonts
for style in "Regular" "Bold" "Italic" "Bold Italic"; do
  filename="MesloLGS NF ${style}.ttf"
  filepath="${FONTS_DIR}/MesloLGS NF/${filename}"
  url="https://github.com/romkatv/powerlevel10k-media/raw/master/${filename}"
  download "${url}" "${filepath}"
done

filename="08_NotoSansCJKsc.zip"
filepath="${HOME}/Downloads/${filename}"
url="https://mirrors.tuna.tsinghua.edu.cn/github-release/googlefonts/noto-cjk/LatestRelease/${filename}"
download "${url}" "${filepath}"
ext "${filepath}" "${FONTS_DIR}"

version="5.2"
filename="Fira_Code_v${version}.zip"
filepath="${HOME}/Downloads/${filename}"
url="https://github.com/tonsky/FiraCode/releases/download/${version}/${filename}"
download "${url}" "${filepath}"
ext "${filepath}" "${FONTS_DIR}"

call fc-cache --force

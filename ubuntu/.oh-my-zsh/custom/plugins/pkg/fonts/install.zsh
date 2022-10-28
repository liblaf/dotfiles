#!/usr/bin/zsh
set -o errexit
set -o nounset

source "${PKG_HOME}/utility.zsh"

# https://github.com/romkatv/powerlevel10k#fonts
for style in "Regular" "Bold" "Italic" "Bold Italic"; do
  filename="MesloLGS NF ${style}.ttf"
  filepath="${HOME}/.local/share/fonts/MesloLGS NF/${filename}"
  url="https://github.com/romkatv/powerlevel10k-media/raw/master/${filename}"
  download "${url}" "${filepath}"
done

filename="08_NotoSansCJKsc.zip"
filepath="${HOME}/Downloads/${filename}"
url="https://mirrors.tuna.tsinghua.edu.cn/github-release/googlefonts/noto-cjk/LatestRelease/${filename}"
download "${url}" "${filepath}"
ext "${filepath}" "${HOME}/.local/share/fonts"

fc-cache --force --verbose

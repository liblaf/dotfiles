#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

filename="code.deb"
filepath="${HOME}/Downloads/${filename}"
download "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" "${filepath}"
sudo apt install "${filepath}"

extensions=(
  aaron-bond.better-comments
  donjayamanne.python-extension-pack
  eamodio.gitlens
  esbenp.prettier-vscode
  foxundermoon.shell-format
  James-Yu.latex-workshop
  llvm-vs-code-extensions.vscode-clangd
  ms-vscode.cpptools-extension-pack
  nico-castell.linux-desktop-file
  streetsidesoftware.code-spell-checker
  tamasfe.even-better-toml
  WakaTime.vscode-wakatime
  wwm.better-align
)

for extension in "${extensions[@]}"; do
  code --install-extension "${extension}"
done

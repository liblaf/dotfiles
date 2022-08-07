#!/usr/bin/env bash
# https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent
set -o errexit
set -o nounset

filename="Miniconda3-latest-Linux-x86_64.sh"
filepath="${HOME}/Downloads/${filename}"

mkdir --parents "${HOME}/Downloads/"
wget --output-document="-" "https://repo.anaconda.com/miniconda/${filename}" |
  tee "${filepath}" >'/dev/null'

mkdir --parents "${HOME}/.local/pkgs/"
bash "${filepath}" -b -p "${HOME}/.local/pkgs/conda"

"${HOME}/.local/pkgs/conda/bin/conda" init zsh

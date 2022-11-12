#!/usr/bin/bash
# https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

filename="Miniconda3-latest-Linux-x86_64.sh"
filepath="${HOME}/Downloads/${filename}"
download "https://repo.anaconda.com/miniconda/${filename}" "${filepath}"

mkdir --parents "${HOME}/.local/opt"
call bash "${filepath}" -b -p "${HOME}/.local/opt/conda"
call "${HOME}/.local/opt/conda/bin/conda" init zsh

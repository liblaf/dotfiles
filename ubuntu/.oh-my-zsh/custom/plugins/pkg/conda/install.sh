#!/usr/bin/env bash
# https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#install-macos-silent
set -o errexit
set -o nounset

source "$(dirname "$(dirname "$(realpath "${0}")")")/utils.sh"

filename="Miniconda3-latest-Linux-x86_64.sh"
filepath="${HOME}/Downloads/${filename}"
download "https://repo.anaconda.com/miniconda/${filename}" "${filepath}"

mkdir --parents "${HOME}/.local/pkgs/"
bash "${filepath}" -b -p "${HOME}/.local/pkgs/conda"
"${HOME}/.local/pkgs/conda/bin/conda" init zsh

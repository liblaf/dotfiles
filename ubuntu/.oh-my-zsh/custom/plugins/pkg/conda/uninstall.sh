#!/usr/bin/bash
# https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#uninstalling-anaconda-or-miniconda
set -o errexit
set -o nounset

conda init --reverse zsh

rm --force --recursive "${CONDA_PREFIX}"
rm --force "${HOME}/.condarc"
rm --force --recursive "${HOME}/.conda"
rm --force --recursive "${HOME}/.continuum"

unset CONDA_PREFIX

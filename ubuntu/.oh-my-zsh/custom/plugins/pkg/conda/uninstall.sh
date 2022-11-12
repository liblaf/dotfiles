#!/usr/bin/bash
# https://conda.io/projects/conda/en/latest/user-guide/install/macos.html#uninstalling-anaconda-or-miniconda
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

call conda init --reverse zsh

remove "${CONDA_PREFIX}"
remove "${HOME}/.condarc"
remove "${HOME}/.conda"
remove "${HOME}/.continuum"

call unset CONDA_PREFIX

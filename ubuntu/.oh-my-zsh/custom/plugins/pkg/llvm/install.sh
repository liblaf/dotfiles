#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

if [[ -n ${1:-""} ]]; then
  call brew install "llvm@${1}"
else
  call brew install llvm
fi

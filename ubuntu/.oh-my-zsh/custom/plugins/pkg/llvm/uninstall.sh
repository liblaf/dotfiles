#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

if [[ -n ${1:-""} ]]; then
  call brew uninstall "llvm@${1}"
else
  call brew uninstall llvm
fi

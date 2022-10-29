#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ -n "${1:-""}" ]]; then
  brew uninstall "llvm@${1}"
else
  brew uninstall llvm
fi

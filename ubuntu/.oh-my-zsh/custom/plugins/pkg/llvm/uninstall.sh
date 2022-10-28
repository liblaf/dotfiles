#!/usr/bin/bash
set -o errexit
set -o nounset

if [[ -n "${1:-""}" ]]; then
  brew uninstall "llvm@${1}"
else
  brew uninstall llvm
fi

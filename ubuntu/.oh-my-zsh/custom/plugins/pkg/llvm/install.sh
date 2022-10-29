#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ -n "${1:-""}" ]]; then
  brew install "llvm@${1}"
else
  brew install llvm
fi

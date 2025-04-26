#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function load-pkg() {
  PKG_DIR="$HOME/.cache/dotfiles/pkg"
  repo=$1
  file=$2
  yq eval ".${repo}[]" "$PKG_DIR/$file"
}

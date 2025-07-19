#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

export WORKING_TREE="${WORKING_TREE:-"$(git rev-parse --show-toplevel)"}"
export CHEZMOI_SOURCE_DIR="$WORKING_TREE/home"
export MODULES_DIR="$WORKING_TREE/modules"
export MODULES_STOW="${MODULES_DIR}.stow"

SCRIPTS_DIR=$(dirname -- "${BASH_SOURCE[0]}")
source "$SCRIPTS_DIR/00-load-profile.sh"
source "$SCRIPTS_DIR/01-prepare-modules.sh"

function build() {
  readarray -t MODULES < <(load-profile "$1")
  echo "${MODULES[@]}"
  prepare-modules "${MODULES[@]}"
  mkdir --parents "$CHEZMOI_SOURCE_DIR.link"
  stow --dir="$MODULES_STOW" --target="$CHEZMOI_SOURCE_DIR.link" "${MODULES[@]}"
  rsync --archive --copy-links --delete "$CHEZMOI_SOURCE_DIR.link/" "$CHEZMOI_SOURCE_DIR/"
  cp --archive "$WORKING_TREE/.chezmoi.toml.tmpl" "$CHEZMOI_SOURCE_DIR/.chezmoi.toml.tmpl"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  build "$@"
fi

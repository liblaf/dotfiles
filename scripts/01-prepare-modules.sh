#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob

function _cp_special_dir() {
  local source=$1
  local target=$2
  local source_dir=$3
  local target_dir=$4
  if [[ -d "$source/$source_dir" ]]; then
    mkdir --parents "$target/$target_dir"
    cp --archive --recursive --no-target-directory \
      "$source/$source_dir/" "$target/$target_dir/"
  fi
}

function _cp_special_files() {
  local source=$1
  local target=$2
  local source_name=$3
  local target_name=$4
  for file in "$source/$source_name".*; do
    local basename
    basename=$(basename -- "$file")
    local suffix=${basename#"$source_name"}
    mkdir --parents "$target/$target_name"
    cp --archive --recursive --no-target-directory \
      "$file" "$target/$target_name/$module$suffix"
  done
}

function prepare-modules() {
  local modules=("$@")
  for module in "${modules[@]}"; do
    echo ">>> Preparing module: $module"
    local source="$MODULES_DIR/$module"
    local target="$MODULES_STOW/$module"
    rm --force --recursive "$target"
    mkdir --parents "$target"
    local sources=("$source"/*)
    if ((${#sources[@]} > 0)); then
      cp --archive --recursive --target-directory="$target" "$source"/*
    fi
    _cp_special_dir "$source" "$target" ".root" "dot_cache/exact_dotfiles/exact_root"
    _cp_special_dir "$source" "$target" ".scripts" ".chezmoiscripts"
    _cp_special_dir "$source" "$target" ".templates" ".chezmoitemplates"
    _cp_special_files "$source" "$target" ".data" ".chezmoidata"
    _cp_special_files "$source" "$target" ".external" ".chezmoiexternals"
    _cp_special_files "$source" "$target" ".packages" ".packages"
  done
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  prepare-modules "$@"
fi

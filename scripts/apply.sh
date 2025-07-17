#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
shopt -s nullglob

WORKING_TREE="$(chezmoi dump-config | yq '.workingTree')"
SOURCE_DIR="$WORKING_TREE/home"
TMP_DIR="/tmp/dotfiles"

MODULES=()

function load-modules() {
  local profile="$1"
  echo "Loading Profile: $profile"
  for inherit in $(yq eval '.inherits[]' "$profile"); do
    load-modules "$(dirname -- "$profile")/$inherit"
  done
  for module in $(yq eval '.modules[]' "$profile"); do
    echo "Loading Module: modules/$module"
    MODULES+=("modules/$module")
  done
}

function merge-modules() {
  rsync --info="PROGRESS2" --archive --delete --force \
    --exclude=".packages.yaml" \
    --exclude=".packages.yaml.tmpl" \
    -- "${MODULES[@]/%/"/"}" "$SOURCE_DIR/"
}

function gen-data() {
  local expression
  expression=$(
    for file in home/.scripts/data/*.sh; do
      bash "$file"
    done |
      paste --delimiters="#" --serial |
      sed 's/#/ | /g'
  )
  mkdir --parents --verbose "$SOURCE_DIR/.chezmoidata/"
  echo ">>> Generated Data >>>"
  yq eval --expression "$expression" --null-input --output-format yaml # report data to terminal
  echo "<<< Generated Data <<<"
  yq eval --expression "$expression" --null-input --output-format yaml > "$SOURCE_DIR/.chezmoidata/generated.yaml"
}

function merge-packages() {
  mkdir --parents --verbose "$SOURCE_DIR/.chezmoidata/"
  echo > "$SOURCE_DIR/.chezmoidata/packages.yaml"
  for module in "${MODULES[@]}"; do
    local packages_file
    if [[ -f "$module/.packages.yaml" ]]; then
      packages_file="$module/.packages.yaml"
    elif [[ -f "$module/.packages.yaml.tmpl" ]]; then
      packages_file="$TMP_DIR/$(basename -- "$module")-packages.yaml"
      chezmoi execute-template --source "$SOURCE_DIR/" "$module/.packages.yaml.tmpl" --file > "$packages_file"
    fi
    if [[ -f $packages_file ]]; then
      yq eval --expression ". *+ load(\"$packages_file\")" --inplace "$SOURCE_DIR/.chezmoidata/packages.yaml"
    fi
  done
}

function main() {
  load-modules "$1"
  merge-modules
  cp "$WORKING_TREE/.chezmoi.toml.tmpl" "$SOURCE_DIR/.chezmoi.toml"

  mkdir --parents --verbose "$TMP_DIR"
  trap 'rm --force --recursive -- "$TMP_DIR"' EXIT

  gen-data
  merge-packages
}

main "$@"

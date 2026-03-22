#!/bin/bash
# @arg files+
set -o errexit
set -o nounset
set -o pipefail

function has() {
  type "$@" &> /dev/null
}

function main() {
  local -ar files=("${argc_files[@]:?}")
  if has toml-sort; then
    toml-sort --in-place --all -- "${files[@]}"
    sed --expression='s/# :schema /#:schema /g' --in-place -- "${files[@]}"
  fi
  if has tombi; then
    tombi format -- "${files[@]}"
    tombi lint -- "${files[@]}"
  fi
}

eval "$(argc --argc-eval "$0" "$@")"

#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

UPSTREAM_CDN='https://files.pythonhosted.org/packages'
UPSTREAM_INDEX='https://pypi.org/simple'

function load-mirror() {
  local config_file="$HOME/.config/uv/uv.toml"
  MIRROR_INDEX="$(yq '.index[] | select(.default).url' "$config_file")"
  MIRROR_CDN="${MIRROR_INDEX/%'/simple'/'/packages'}"
}

function uv() {
  local git_root
  git_root="$(git rev-parse --show-toplevel 2> /dev/null || pwd)"
  local lock_file="$git_root/uv.lock"
  load-mirror &> /dev/null || true
  if [[ -n ${MIRROR_INDEX-} && -n ${MIRROR_CDN-} && -f $lock_file ]]; then
    sd "$UPSTREAM_INDEX" "$MIRROR_INDEX" "$lock_file"
    sd "$UPSTREAM_CDN" "$MIRROR_CDN" "$lock_file"
  fi
  command uv "$@"
  if [[ -n ${MIRROR_INDEX-} && -n ${MIRROR_CDN-} && -f $lock_file ]]; then
    sd 'https://(\S+)/packages\b' "$UPSTREAM_CDN" "$lock_file"
    sd 'https://(\S+)/simple\b' "$UPSTREAM_INDEX" "$lock_file"
  fi
}

uv "$@"

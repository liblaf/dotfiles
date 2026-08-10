#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

LOCKFILES=()
MIRROR_CDN=''
MIRROR_INDEX=''
UPSTREAM_CDN='https://files.pythonhosted.org/packages'
UPSTREAM_INDEX='https://pypi.org/simple'

function cleanup() {
  local -r status="$1"
  for lockfile in "${LOCKFILES[@]}"; do
    mirror-to-upstream "$lockfile"
  done
  exit "$status"
}

function load-mirror() {
  local config_file="$HOME/.config/uv/uv.toml"
  MIRROR_INDEX="$(yq '.index[] | select(.default).url' "$config_file")"
  MIRROR_CDN="${MIRROR_INDEX/%'/simple'/'/packages'}"
}

function mirror-to-upstream() {
  local -r lockfile="$1"
  if [[ -n ${MIRROR_INDEX:-} && -n ${MIRROR_CDN:-} && -f $lockfile ]]; then
    local -r mtime="$(stat --format='%Y' "$lockfile")"
    sd 'https://(\S+)/packages\b' "$UPSTREAM_CDN" "$lockfile"
    sd 'https://(\S+)/simple\b' "$UPSTREAM_INDEX" "$lockfile"
    touch --no-create --date="@$mtime" -m "$lockfile"
  fi
}

function upstream-to-mirror() {
  local -r lockfile="$1"
  if [[ -n ${MIRROR_INDEX:-} && -n ${MIRROR_CDN:-} && -f $lockfile ]]; then
    local -r mtime="$(stat --format='%Y' "$lockfile")"
    sd "$UPSTREAM_INDEX" "$MIRROR_INDEX" "$lockfile"
    sd "$UPSTREAM_CDN" "$MIRROR_CDN" "$lockfile"
    touch --no-create --date="@$mtime" -m "$lockfile"
  fi
}

function wrapper() {
  local -r git_root="$(git rev-parse --show-toplevel 2> /dev/null || pwd)"
  local -r uv_lock="$git_root/uv.lock"
  local -r pixi_lock="$git_root/pixi.lock"
  if [[ -f $uv_lock ]]; then LOCKFILES+=("$uv_lock"); fi
  if [[ -f $pixi_lock ]]; then LOCKFILES+=("$pixi_lock"); fi
  if (("${#LOCKFILES[@]}" > 0)); then load-mirror; fi
  trap 'cleanup $?' EXIT
  for lockfile in "${LOCKFILES[@]}"; do
    upstream-to-mirror "$lockfile"
  done
  command "$@"
}

wrapper "$@"

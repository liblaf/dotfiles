#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function run() {
  if command -v gum > /dev/null 2>&1; then
    prefix="$(gum style --background=14 --padding="0 1" RUN)"
    message="$(gum style --foreground=14 "${*}")"
    gum join --horizontal "${prefix}" " " "${message}"
  fi
  "${@}"
}

if [[ -n ${1:-""} ]]; then
  cmd="${1}"
  shift
else
  cmd="help"
fi

case "${cmd}" in
  help) ;;
  sync)
    if [[ -n ${2:-""} ]]; then
      path="${2}"
      shift
    else
      path="/"
    fi
    run rclone bisync "${local}/${path}" "${remote}/${path}" --verbose "${@}"
    ;;
  push)
    if [[ -n ${2:-""} ]]; then
      path="${2}"
      shift
    else
      path="/"
    fi
    run rclone sync "${local}/${path}" "${remote}/${path}" --verbose "${@}"
    ;;
  pull)
    if [[ -n ${2:-""} ]]; then
      path="${2}"
      shift
    else
      path="/"
    fi
    run rclone sync "${remote}/${path}" "${local}/${path}" --verbose "${@}"
    ;;
esac

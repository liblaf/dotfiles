#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function info() {
  if command -v rich > /dev/null 2>&1; then
    rich --print --style "bold bright_blue" "${*}"
  else
    echo -e -n "\x1b[1;94m"
    echo -n "${*}"
    echo -e "\x1b[0m"
  fi
}

function call() {
  info "+ ${*}"
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
    call rclone bisync "${local}/${path}" "${remote}/${path}" --verbose "${@}"
    ;;
  push)
    if [[ -n ${2:-""} ]]; then
      path="${2}"
      shift
    else
      path="/"
    fi
    call rclone sync "${local}/${path}" "${remote}/${path}" --verbose "${@}"
    ;;
  pull)
    if [[ -n ${2:-""} ]]; then
      path="${2}"
      shift
    else
      path="/"
    fi
    call rclone sync "${remote}/${path}" "${local}/${path}" --verbose "${@}"
    ;;
esac

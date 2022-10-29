#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function _exec() {
  echo -e -n "\033[1;94m"
  echo -n "${@}"
  echo -e "\033[0m"
  "${@}"
}

function prepare() {
  if [[ ! -f "docs/index.md" ]]; then
    _exec cp "README.md" "docs/index.md"
  fi
}

cmd="${1}"
shift 1
case "${cmd}" in
*)
  "${cmd}" "${@}"
  ;;
esac

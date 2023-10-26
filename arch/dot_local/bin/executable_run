#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

run-pretty "$@" >&2

if "$@"; then
  exit 0
else
  status_=$?
  if [[ -t 2 ]]; then
    echo "$(tput bold)$(tput setaf 9)Exit with status $status_$(tput sgr0)" >&2
  else
    echo "Exit with status $status_" >&2
  fi
  exit $status_
fi

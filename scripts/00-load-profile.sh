#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function load-profile() {
  local profile=$1
  for inherit in $(yq eval '.inherits[]' "$profile"); do
    load-profile "$inherit"
  done
  yq eval '.modules[]' "$profile"
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  load-profile "$@"
fi

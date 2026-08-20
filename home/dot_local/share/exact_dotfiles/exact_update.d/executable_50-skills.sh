#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ${argc_yes-} == 1 ]]; then
  skills update --global --yes
else
  skills update --global
fi

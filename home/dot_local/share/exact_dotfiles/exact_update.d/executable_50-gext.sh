#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ${argc_yes-} == 1 ]]; then
  gext update --yes --user
else
  gext update --user
fi

#!/usr/bin/bash
# set -o errexit
set -o nounset
set -o pipefail

curl -fsSL "https://alist.nn.ci/v3.sh" | sudo bash -s install

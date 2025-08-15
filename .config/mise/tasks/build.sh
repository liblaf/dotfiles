#!/bin/bash
#MISE depends=["clean"]
set -o errexit
set -o nounset
set -o pipefail

bash 'scripts/build.sh' "$@"

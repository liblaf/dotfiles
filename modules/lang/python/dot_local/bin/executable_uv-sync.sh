#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

python "$(dirname -- "${BASH_SOURCE[0]}")/uv-sync.py" "$@"

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

python "$(dirname -- "${BASH_SOURCE[0]}")/uv-sync.py" "$@"

if [[ -n ${VIRTUAL_ENV:-} && -f "$VIRTUAL_ENV/pyvenv.cfg" ]]; then
  yq eval '.include-system-site-packages = true' "$VIRTUAL_ENV/pyvenv.cfg" \
    --inplace --input-format props --output-format props
fi

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

DATA_FILE="$CHEZMOI_SOURCE_DIR/.chezmoidata/generated/intel.json"
echo "{}" > "$DATA_FILE"

if grep --ignore-case intel /proc/cpuinfo > /dev/null; then
  echo "Hardware > Intel CPU: true" >&2
  yq --inplace ".hardware.intel.exists = true" "$DATA_FILE"
else
  echo "Hardware > Intel CPU: false" >&2
  yq --inplace ".hardware.intel.exists = false" "$DATA_FILE"
fi

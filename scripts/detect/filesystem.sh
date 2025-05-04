#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

DATA_FILE="$CHEZMOI_SOURCE_DIR/.chezmoidata/generated/filesystem.json"
echo "{}" > "$DATA_FILE"

fstype="$(findmnt --noheadings --output FSTYPE /)"
source="$(findmnt --noheadings --output SOURCE /)"
echo "Filesystem > FSTYPE: $fstype" >&2
yq --inplace ".filesystem.fstype = \"$fstype\"" "$DATA_FILE"
echo "Filesystem > SOURCE: $source" >&2
yq --inplace ".filesystem.source = \"$source\"" "$DATA_FILE"

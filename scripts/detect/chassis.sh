#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

DATA_FILE="$CHEZMOI_SOURCE_DIR/.chezmoidata/generated/ddns.json"
echo "{}" > "$DATA_FILE"

chassis="$(hostnamectl chassis)"
virt="$(systemd-detect-virt)"

echo "Chassis: $chassis" >&2
echo "Virtualized: $virt" >&2
yq --inplace ".chassis = \"$chassis\"" "$DATA_FILE"
yq --inplace ".virt = \"$virt\"" "$DATA_FILE"

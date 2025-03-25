#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

bash "$CHEZMOI_WORKING_TREE/scripts/setup/00-install.sh"
bash "$CHEZMOI_WORKING_TREE/scripts/setup/10-bitwarden.sh"

DATA_FILE="$CHEZMOI_SOURCE_DIR/.chezmoidata/generated.json"
mkdir --parents --verbose "$(dirname -- "$DATA_FILE")"
echo "{}" > "$DATA_FILE"
export DATA_FILE
bash "$CHEZMOI_WORKING_TREE/scripts/detect/intel.sh"
bash "$CHEZMOI_WORKING_TREE/scripts/detect/nvidia.sh"
python "$CHEZMOI_WORKING_TREE/scripts/detect/service.py"

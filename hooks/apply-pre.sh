#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

mkdir --parents --verbose "$CHEZMOI_SOURCE_DIR/.chezmoidata/generated"

bash "$CHEZMOI_WORKING_TREE/scripts/setup/00-install.sh"
bash "$CHEZMOI_WORKING_TREE/scripts/setup/10-bitwarden.sh"

bash "$CHEZMOI_WORKING_TREE/scripts/detect/ddns.sh" &
bash "$CHEZMOI_WORKING_TREE/scripts/detect/filesystem.sh" &
bash "$CHEZMOI_WORKING_TREE/scripts/detect/intel.sh" &
bash "$CHEZMOI_WORKING_TREE/scripts/detect/nvidia.sh" &
python "$CHEZMOI_WORKING_TREE/scripts/detect/mime.py" &
python "$CHEZMOI_WORKING_TREE/scripts/detect/service.py" &

wait

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

workspace=$(realpath $(dirname $0))
source "$workspace/scripts/setup/bitwarden.sh"
bash "$workspace/scripts/setup/github.sh"
bash "$workspace/scripts/setup/rclone.sh"

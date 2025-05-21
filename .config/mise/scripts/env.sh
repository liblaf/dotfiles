#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source /etc/os-release
export CHEZMOI_SOURCE_DIR="$PWD/$ID"

#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

link "${HOME}/Android/Sdk/platform-tools/adb" "${HOME}/.local/bin/adb"

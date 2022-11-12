#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

remove "${HOME}/.local/share/fonts"
call fc-cache --force

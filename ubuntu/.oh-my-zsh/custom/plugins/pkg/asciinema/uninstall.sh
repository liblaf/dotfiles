#!/usr/bin/sh
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

call brew uninstall asciinema
remove "${HOME}/.local/bin/agg"

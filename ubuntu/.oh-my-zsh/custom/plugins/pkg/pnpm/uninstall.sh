#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

remove "${HOME}/.npm"
remove "${PNPM_HOME}"

call brew uninstall pnpm
call brew uninstall node

call unset PNPM_HOME

#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source "${PKG_HOME}/utility.sh"

call brew install node
call brew install pnpm

call pnpm setup
call pnpm install-completion zsh
call pnpm env use --global lts

#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

brew install node
brew install pnpm

pnpm setup
pnpm install-completion zsh
pnpm env use --global lts

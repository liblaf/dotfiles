#!/usr/bin/bash
set -o errexit
set -o nounset

brew install node
brew install pnpm

pnpm setup
pnpm install-completion zsh
pnpm env use --global lts

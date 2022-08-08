#!/usr/bin/env bash
set -o errexit
set -o nounset

brew install node
brew install pnpm

pnpm setup
pnpm install-completion zsh
pnpm add --global commitizen
pnpm add --global cz-conventional-changelog
pnpm add --global npm-check-updates
cat <<-EOF | tee "${HOME}/.czrc" >"/dev/null"
{
  "path": "cz-conventional-changelog"
}
EOF

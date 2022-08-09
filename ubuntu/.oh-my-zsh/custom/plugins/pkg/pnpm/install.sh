#!/usr/bin/env bash
set -o errexit
set -o nounset

brew install node
brew install pnpm

pnpm setup
pnpm install-completion zsh
pnpm env use --global lts
pnpm add --global \
  commitizen \
  cz-conventional-changelog \
  npm-check-updates
cat <<-EOF | tee "${HOME}/.czrc" >"/dev/null"
{
  "path": "cz-conventional-changelog"
}
EOF

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ":$PATH:" != *":$HOME/.bun/bin:"* ]]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi

skills update --global --yes

function skills-add() {
  skills add --global --agent 'codex' --yes "$@"
}

skills-add 'liblaf/skills'
skills-add 'liblaf/cherries'
skills-add 'vercel-labs/skills' --skill 'find-skills'
skills-add 'mattpocock/skills' --skill \
  codebase-design \
  domain-modeling \
  grill-me \
  grill-with-docs \
  grilling \
  improve-codebase-architecture

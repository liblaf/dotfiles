#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ":$PATH:" != *":$HOME/.bun/bin:"* ]]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi

function skills-add() {
  skills add --global --agent 'codex' --yes "$@"
}

skills remove --global --yes --all

skills-add 'liblaf/cherries'
skills-add 'liblaf/skills'
skills-add 'vercel-labs/skills' --skill 'find-skills'

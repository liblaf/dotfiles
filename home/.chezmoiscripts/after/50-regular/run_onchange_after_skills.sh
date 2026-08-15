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

skills-add 'cangtianhuang/humanizer-academic-zh' --skill 'humanizer-academic-zh'
skills-add 'liblaf/cherries'
skills-add 'liblaf/skills'
skills-add 'op7418/humanizer-zh' --skill 'humanizer-zh'
skills-add 'vercel-labs/skills' --skill 'find-skills'
skills-add 'mattpocock/skills' --skill \
  codebase-design \
  domain-modeling \
  grill-me \
  grill-with-docs \
  grilling \
  improve-codebase-architecture

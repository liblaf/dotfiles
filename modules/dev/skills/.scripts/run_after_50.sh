#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ":$PATH:" != *":$HOME/.bun/bin:"* ]]; then
  export PATH="$HOME/.bun/bin:$PATH"
fi

skills add liblaf/skills --global --yes

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

uv run 'gen/starship/main.py'
tombi format 'modules/cli-starship/dot_config/starship.toml'

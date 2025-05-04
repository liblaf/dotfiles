#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

export PATH="$HOME/.local/bin:$PATH"

function uv-tool() {
  flock --exclusive /tmp/uv-tool.lock --command "uv tool $*"
}

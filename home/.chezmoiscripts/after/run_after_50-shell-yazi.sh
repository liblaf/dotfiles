#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

PLUGINS=(
  yazi-rs/plugins:full-border
  yazi-rs/plugins:git
  yazi-rs/plugins:mime-ext
  yazi-rs/plugins:mount
  yazi-rs/plugins:smart-filter
)

ya pkg upgrade
for plugin in "${PLUGINS[@]}"; do
  ya pkg add "$plugin" || true
done

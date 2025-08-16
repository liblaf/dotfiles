#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

PLUGINS=(
  yazi-rs/plugins:chmod
  yazi-rs/plugins:full-border
  yazi-rs/plugins:git
  yazi-rs/plugins:mount
  yazi-rs/plugins:types
  yazi-rs/plugins:zoom
)

INSTALLED="$(ya pkg list)"
TO_INSTALL=()
for plugin in "${PLUGINS[@]}"; do
  if ! grep --quiet "$plugin" <<< "$INSTALLED"; then
    TO_INSTALL+=("$plugin")
  fi
done

ya pkg upgrade
if ((${#TO_INSTALL[@]} > 0)); then
  ya pkg add "${TO_INSTALL[@]}"
fi

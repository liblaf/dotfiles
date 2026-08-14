#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

legacy_extensions=(
  'clipboard-indicator@tudmotu.com'
  'codexbar@inled.es'
)

readarray -t extensions_to_uninstall < <(
  comm -1 -2 \
    <(printf '%s\n' "${legacy_extensions[@]}" | sort) \
    <(gnome-extensions list --user | sort)
)

for extension in "${extensions_to_uninstall[@]}"; do
  gnome-extensions uninstall "$extension"
done

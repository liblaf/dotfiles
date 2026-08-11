#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

deprecated_extensions=(
  'clipboard-indicator@tudmotu.com'
  'codexbar@inled.es'
)

for uuid in "${deprecated_extensions[@]}"; do
  if gnome-extensions info "$uuid" &> /dev/null; then
    gnome-extensions uninstall "$uuid"
  fi
done

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly units=(
  mihomo-pull.service
  mihomo-pull.timer
  mihomo-push.service
  mihomo-push.timer
)

for unit in "${units[@]}"; do
  if systemctl --quiet --user is-enabled "$unit"; then
    systemctl --user --now disable "$unit"
  fi
  rm --force --verbose "$HOME/.config/systemd/user/$unit"
done

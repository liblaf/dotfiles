#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

GROUP="chezmoi"

systemctl --user enable --now pueued.service
pueue reset --force
sleep 1
pueue group add "$GROUP" || true
sleep 1
pueue parallel --group "$GROUP" 8
sleep 1

readarray -t scripts < <(find "$HOME/.cache/dotfiles/scripts" -type f)
for script in "${scripts[@]}"; do
  case "$script" in
    *.fish) pueue add --group "$GROUP" -- "fish '$script' < /dev/null" ;;
    *.py) pueue add --group "$GROUP" -- python "$script" ;;
    *.sh) pueue add --group "$GROUP" -- bash "$script" ;;
  esac
done

pueue wait --group "$GROUP"

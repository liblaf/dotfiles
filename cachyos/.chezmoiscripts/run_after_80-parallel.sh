#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

GROUP="chezmoi"

systemctl --user enable --now pueued.service
sleep 3 # wait for pueued to start
pueue reset --force
pueue group add "$GROUP" || true
pueue parallel --group "$GROUP" 8
sleep 1 # wait for pueued to start

readarray -t scripts < <(find "$HOME/.cache/dotfiles/scripts" -type f)
for script in "${scripts[@]}"; do
  case "$script" in
    *.fish) pueue add --group "$GROUP" -- "fish '$script' < /dev/null" ;;
    *.py) pueue add --group "$GROUP" -- python "$script" ;;
    *.sh) pueue add --group "$GROUP" -- bash "$script" ;;
  esac
done

pueue wait --group "$GROUP"

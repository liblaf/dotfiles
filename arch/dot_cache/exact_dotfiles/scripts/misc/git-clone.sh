#!/bin/bash
set -o errexit -o nounset -o pipefail

prefix="$HOME/github"

readarray -t repos < <(
  gh repo list \
    --jq ".[].nameWithOwner" \
    --json "nameWithOwner" \
    --limit 1000 \
    --no-archived \
    --source
)

for repo in "${repos[@]}"; do
  case "$repo" in
    */dotfiles) target=$HOME/.local/share/chezmoi ;;
    *) target=$prefix/$repo ;;
  esac
  if [[ -d "$target/.git" ]]; then
    echo "Updating '$target' ..."
    git -C "$target" pull || true
  else
    mkdir --parents --verbose "$(dirname -- "$target")"
    gh repo clone "$repo" "$target" || true
  fi
done

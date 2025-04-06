#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

prefix="$HOME/github"

readarray -t repos < <(
  gh repo list \
    --jq ".[].nameWithOwner" \
    --json "nameWithOwner" \
    --limit 1000 \
    --no-archived \
    --source
)

function clone() {
  local repo="$1"
  case "$repo" in
    */dotfiles) target="$HOME/.local/share/chezmoi" ;;
    *) target="$prefix/$repo" ;;
  esac
  echo "Updating '$repo' -> '$target'..."
  if [[ -d "$target/.git" ]]; then
    git -C "$target" pull --ff-only || true
  else
    mkdir --parents --verbose "$(dirname -- "$target")"
    gh repo clone "$repo" "$target" || true
  fi
}

export prefix
export -f clone

parallel --bar --eta --jobs 8 --progress clone ::: "${repos[@]}"

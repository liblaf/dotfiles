#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt --quiet; then exit; fi

PREFIX="$HOME/github"

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
    *) target="$PREFIX/$repo" ;;
  esac
  echo "Updating '$repo' -> '$target'..."
  if [[ -d "$target/.git" ]]; then
    git -C "$target" pull --ff-only || true
  else
    mkdir --parents --verbose "$(dirname -- "$target")"
    gh repo clone "$repo" "$target" || true
  fi
}

export PREFIX
export -f clone

parallel --bar --eta --jobs 8 --progress clone ::: "${repos[@]}"

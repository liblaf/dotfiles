#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt --quiet; then exit; fi
if ! gh auth status; then exit; fi

export PREFIX="$HOME/github"

function gh-clone() {
  local full_name="$1"
  local target="$PREFIX/$full_name"
  if [[ -d "$target/.git" ]]; then
    git -C "$target" pull --ff-only || true
  else
    mkdir --parents --verbose "$(dirname -- "$target")"
    gh repo clone "$full_name" "$target" || true
  fi
}
export -f gh-clone

readarray -t repos < <(
  gh api '/user/repos' \
    --jq '.[] | select((.archived | not) and (.fork | not)) | .full_name' \
    --paginate
)

parallel --bar --eta --jobs 8 --progress gh-clone ::: "${repos[@]}"

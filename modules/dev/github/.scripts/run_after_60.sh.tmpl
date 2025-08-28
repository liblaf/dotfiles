#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt --quiet; then exit; fi

echo '{{ (rbwFields "GitHub").GITHUB_CLI_TOKEN.value }}' |
  gh auth login --git-protocol https --with-token

function gh-clone() {
  local prefix="$HOME/github"
  local repository="$1"
  local target="$prefix/$repository"
  if [[ -d "$target/.git" ]]; then
    git -C "$target" pull --ff-only || true
  else
    mkdir --parents --verbose "$(dirname -- "$target")"
    gh repo clone "$repository" "$target" || true
  fi
}
export -f gh-clone

readarray -t repos < <(
  gh api '/user/repos' \
    --jq '.[] | select((.archived | not) and (.fork | not)) | .full_name' \
    --paginate
)
parallel --bar --eta --jobs 8 --progress gh-clone ::: "${repos[@]}"

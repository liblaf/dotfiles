#!/bin/bash
# -*- mode: sh; -*-
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt --quiet; then exit; fi

glab auth login \
  --api-protocol https \
  --git-protocol https \
  --hostname gitlab.com \
  --token '{{ (rbwFields "GitLab").GITLAB_CLI_TOKEN.value }}' \
  --use-keyring

function glab-clone() {
  local prefix="$HOME/gitlab"
  local repository="$1"
  local target="$prefix/$repository"
  if [[ -d $target ]]; then
    git -C "$target" pull --ff-only || true
  else
    mkdir --parents --verbose "$(dirname -- "$target")"
    glab repo clone "$repository" "$target" || true
  fi
}
export -f glab-clone

readarray -t repos < <(
  glab repo list --mine --output json --per-page 1000 \
    yq '.[] | select(.marked_for_deletion_on | not).path_with_namespace'
)
parallel --bar --eta --jobs 8 --progress glab-clone ::: "${repos[@]}"

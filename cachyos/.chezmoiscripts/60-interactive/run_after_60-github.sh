#!/bin/bash
# shellcheck disable=SC2317
set -o errexit
set -o nounset
set -o pipefail

# TODO: re-enable this when I figure out a better way for interactive setup
exit

if systemd-detect-virt --quiet; then exit; fi

if ! gh auth status; then
  gh auth login --git-protocol https --scopes delete_repo --web
fi

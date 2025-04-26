#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if ! gh auth status; then
  gh auth login --git-protocol https --scopes delete_repo --web
fi

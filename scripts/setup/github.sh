#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if gh auth status; then
  exit 0
fi

gh auth login

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ -f /usr/bin/go-task ]]; then
  sudo ln --force --symbolic --no-target-directory --verbose \
    /usr/bin/go-task /usr/local/bin/task
fi

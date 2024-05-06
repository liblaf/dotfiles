#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if on-battery; then
  exit 0
fi

restic unlock
restic backup --tag="scheduled" "$HOME/Documents/data"
restic check --with-cache
restic forget --keep-hourly="24" --keep-daily="7" --keep-weekly="4" --keep-monthly="12" --keep-yearly="1" --keep-tag="archive" --prune

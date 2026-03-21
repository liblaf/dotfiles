#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt --quiet; then
  resticprofile unschedule
else
  resticprofile schedule
fi

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if systemd-detect-virt; then exit; fi

resticprofile schedule

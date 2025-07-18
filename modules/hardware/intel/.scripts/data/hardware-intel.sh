#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if grep --ignore-case --quiet intel /proc/cpuinfo; then
  echo ".hardware.intel.exists = true"
else
  echo ".hardware.intel.exists = false"
fi

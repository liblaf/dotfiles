#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [[ ${argc_yes-} == 1 ]]; then
  sudo fwupdmgr update --assume-yes || true
else
  sudo fwupdmgr update || true
fi

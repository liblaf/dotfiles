#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rm --force --recursive -- \
  "home.link" \
  "home" \
  "modules.stow" \
  "tmp"

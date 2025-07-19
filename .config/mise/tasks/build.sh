#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

bash "scripts/build.sh" "profiles/cachyos.yaml"

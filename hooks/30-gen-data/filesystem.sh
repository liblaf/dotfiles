#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

findmnt --json / |
  yq '{ "fs": .filesystems[0] }' --output-format json

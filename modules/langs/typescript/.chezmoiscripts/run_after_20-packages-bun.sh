#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

bun update --no-save --global --latest

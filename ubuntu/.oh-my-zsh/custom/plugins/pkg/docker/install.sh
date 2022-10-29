#!/usr/bin/env bash
# https://docs.docker.com/engine/security/rootless/
set -o errexit
set -o nounset
set -o pipefail

curl -fsSL https://get.docker.com/rootless | sh

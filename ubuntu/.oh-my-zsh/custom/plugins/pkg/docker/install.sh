#!/usr/bin/env bash
# https://docs.docker.com/engine/security/rootless/
set -o errexit
set -o nounset

curl -fsSL https://get.docker.com/rootless | sh

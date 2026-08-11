#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

docker system prune --all --force --volumes

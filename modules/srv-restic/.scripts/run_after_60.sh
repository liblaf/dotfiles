#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$HOME/srv/restic"
docker compose up --remove-orphans --wait

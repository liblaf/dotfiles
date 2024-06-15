#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$HOME/services"
docker compose pull
docker compose up --detach || true
docker system prune --all --force --volumes

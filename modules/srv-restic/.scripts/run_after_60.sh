#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# {{ if eq .virt "none" }}

# {{ template "docker.sh" }}

cd "$HOME/srv/restic"
docker compose up --remove-orphans --wait

# {{ end }}

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo systemctl enable --now docker.service

cd ~/services
sudo docker compose pull
sudo docker compose up --detach || true
sudo docker system prune --all --force --volumes

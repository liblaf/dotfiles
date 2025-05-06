#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

cd "$(dirname -- "$0")"

for _ in $(seq 3); do
  gum confirm "Attention:
You will reset MLflow.
All the data on the disk will be lost!!!" \
    --default="no" \
    --show-output
done

docker compose down
rm --force --verbose basic-auth/basic-auth.db
rm --force --verbose mlruns/mlruns.db
rm --force --recursive --verbose mlartifacts/*

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

tmp="$(mktemp --suffix=".yaml")"
trap 'rm --force "$tmp"' EXIT
gist_id="$(gh gist list --filter "Mihomo" | awk '{ print $1 }')"
gh gist view "$gist_id" --filename "mihomo.yaml" > "$tmp"
sudo install -D --mode="u=rw,go=r" --no-target-directory --verbose "$tmp" "/etc/clash-meta/config.yaml"
sudo systemctl enable --now clash-meta.service
sudo systemctl restart clash-meta.service

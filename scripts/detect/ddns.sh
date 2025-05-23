#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

DATA_FILE="$CHEZMOI_SOURCE_DIR/.chezmoidata/generated/ddns.json"
echo "{}" > "$DATA_FILE"

base_domain="liblaf.me"
hostname="$(hostnamectl hostname | tr '[:upper:]' '[:lower:]')"
domain="$hostname.$base_domain"
echo "DDNS > Base Domain: $base_domain" >&2
echo "DDNS > Domain: $domain" >&2
yq --inplace ".ddns.base_domain = \"$base_domain\"" "$DATA_FILE"
yq --inplace ".ddns.domain = \"$domain\"" "$DATA_FILE"

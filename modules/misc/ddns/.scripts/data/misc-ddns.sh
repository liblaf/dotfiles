#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

base_domain="liblaf.me"
hostname="$(hostnamectl hostname | tr '[:upper:]' '[:lower:]')"
domain="$hostname.ddns.$base_domain"
echo ".ddns.baseDomain = \"$base_domain\""
echo ".ddns.domain = \"$domain\""

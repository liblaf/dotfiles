#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

# ref: <https://git-scm.com/docs/git#Documentation/git.txt-codeGITEXTERNALDIFFcode>
path="$1"
# shellcheck disable=SC2034
old_file="$2"
old_hex="$3"
old_mode="$4"
new_file="$5"
new_hex="$6"
new_mode="$7"

if [[ $path == *.lock || $path == "go.sum" ]]; then
  generated=true
elif head --lines="5" "$new_file" | grep --quiet "@generated"; then
  generated=true
else
  generated=false
fi

if [[ $generated != "true" ]]; then
  exec difft "$@"
fi

RESET=$'\e[0m'
FAINT=$'\e[2m'
BOLD_BRIGHT_YELLOW=$'\e[1;93m'

echo "${BOLD_BRIGHT_YELLOW}${path}${RESET}${FAINT} --- Generated${RESET}"

if [[ $path != "$new_file" ]]; then
  echo "${FAINT}Renamed from ${path} to ${new_file}${RESET}"
fi

if [[ $old_mode != "$new_mode" ]]; then
  echo "File permissions changed from ${old_mode} to ${new_mode}."
fi

if [[ $old_hex != "$new_hex" ]]; then
  echo "Generated contents changed."
else
  echo "No changes."
fi

echo

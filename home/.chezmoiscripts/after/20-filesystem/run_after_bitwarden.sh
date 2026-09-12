#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

rbw list --raw |
  jq --raw-output '.[] | select(.folder == "Dotfiles") | .name' |
  while read -r item; do
    target="${item/#'~'/"$HOME"}"
    mkdir --parents --verbose "$(dirname -- "$target")"
    tmpfile="$(mktemp)"
    rbw get --folder 'Dotfiles' "$item" > "$tmpfile"
    mv "$tmpfile" "$target"
    rm --force "$tmpfile"
    chmod --verbose 'u=rw,go=' "$target"
    echo "Bitwarden -> '$target'"
  done

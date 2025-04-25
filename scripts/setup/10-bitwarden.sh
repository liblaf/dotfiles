#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

BW_SESSION_FILE="${BW_SESSION_FILE:-"$HOME/.config/credstore/BW_SESSION"}"

if [[ -z ${BW_SESSION-} ]]; then
  if [[ -r $BW_SESSION_FILE ]]; then
    BW_SESSION=$(< "$BW_SESSION_FILE")
    export BW_SESSION
  fi
fi
if ! bw login --check >&2; then
  BW_SESSION=$(bw login --raw)
  export BW_SESSION
fi
if ! bw unlock --check >&2; then
  BW_SESSION=$(bw --raw unlock)
  export BW_SESSION
  bw unlock --check >&2
fi
mkdir --parents --verbose "$(dirname -- "$BW_SESSION_FILE")"
echo "$BW_SESSION" > "$BW_SESSION_FILE"

if [[ ! -f "$HOME/.config/rbw/config.json" ]]; then
  rbw config set email "no-reply.liblaf@outlook.com"
  rbw config set lock_timeout 604800
fi
rbw login
rbw sync

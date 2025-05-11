#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

LOCAL_PATH="$HOME/mihomo"

id=$(gh gist list --filter "Mihomo" | awk '{ print $1 }')
port=$(gsettings get org.gnome.system.proxy.https port)
if [[ -d $LOCAL_PATH ]]; then
  git -C "$LOCAL_PATH" pull
else
  gh gist clone "$id" "$LOCAL_PATH"
fi

TMPDIR="$(mktemp --directory)"
trap 'rm --force --recursive --verbose "$TMPDIR"' EXIT
wget --output-document="$TMPDIR/template.default.yaml" \
  "https://github.com/liblaf/sub-converter/raw/refs/heads/main/templates/mihomo/default.yaml"

sub-converter mihomo \
  --output "$LOCAL_PATH/mihomo.yaml" \
  --port "$port" \
  --profile "$LOCAL_PATH/profile.yaml" \
  --template "$TMPDIR/template.default.yaml"
clash-meta -f "$LOCAL_PATH/mihomo.yaml" -t

git -C "$LOCAL_PATH" add --all
if [[ -n "$(git -C "$LOCAL_PATH" status --porcelain)" ]]; then
  git -C "$LOCAL_PATH" commit --message="" --allow-empty-message
  git -C "$LOCAL_PATH" push
fi

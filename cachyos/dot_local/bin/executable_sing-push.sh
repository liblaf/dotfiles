#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

LOCAL_PATH="$HOME/github/liblaf/GFW/"

id=$(gh gist list --filter "GFW" | awk '{ print $1 }')
port=$(gsettings get org.gnome.system.proxy.https port)
if [[ -d $LOCAL_PATH ]]; then
  git -C "$LOCAL_PATH" pull
else
  gh gist clone "$id" "$LOCAL_PATH"
fi

sing --config "$LOCAL_PATH/config.json" --output "$LOCAL_PATH/sing-box.json" --port "$port" --template "default"
sing --config "$LOCAL_PATH/config.json" --output "$LOCAL_PATH/sing-box.ios.json" --port "$port" --template "ios"
git -C "$LOCAL_PATH" add --all
if [[ -n "$(git -C "$LOCAL_PATH" status --porcelain)" ]]; then
  git -C "$LOCAL_PATH" commit --message="" --allow-empty-message
  git -C "$LOCAL_PATH" push
fi

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if ! pgrep --exact --quiet pot; then
  if type pot &> /dev/null; then
    declare -ar cmd=(pot)
  else
    declare -ar cmd=(flatpak run com.pot_app.pot)
  fi
  nohup "${cmd[@]}" &> /dev/null &
  disown
  sleep 1
fi

# ref: <https://pot-app.com/docs/invoke.html>
declare -r screenshot="$HOME/.cache/com.pot-app.desktop/pot_screenshot_cut.png"
mkdir --parents --verbose -- "$(dirname -- "$screenshot")"
rm --force --verbose "$screenshot"
flameshot gui --path "$screenshot" --accept-on-select
xh GET 'http://127.0.0.1:60828/ocr_translate' screenshot==false

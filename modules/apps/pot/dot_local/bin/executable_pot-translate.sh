#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if ! pgrep --exact --quiet pot; then
  if type pot &> /dev/null; then
    readonly -a cmd=(pot)
  else
    readonly -a cmd=(flatpak run com.pot_app.pot)
  fi
  nohup "${cmd[@]}" &> /dev/null &
  disown
  sleep 1
fi

# ref: <https://pot-app.com/docs/invoke.html>
xh GET 'http://127.0.0.1:60828/translate'

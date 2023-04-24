#!/usr/bin/zsh

function has() {
  command -v "${@}" > /dev/null 2>&1
}

function ntp() {
  # https://tuna.moe/help/ntp/
  sudo systemctl restart systemd-timesyncd
}

if has wslact; then
  function time-sync() {
    # https://wslutiliti.es/wslu/man/wslact.html
    sudo wslact time-sync
  }
fi

unset -f has

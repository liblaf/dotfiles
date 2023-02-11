#!/usr/bin/zsh

function ntp() {
  # https://tuna.moe/help/ntp/
  sudo systemctl restart systemd-timesyncd
}

function time-sync() {
  # https://wslutiliti.es/wslu/man/wslact.html
  sudo wslact time-sync
}

#!/usr/bin/zsh

function ntp() {
  # https://tuna.moe/help/ntp/
  sudo sntp "${1:-"ntp.tuna.tsinghua.edu.cn"}"
}

function time-sync() {
  # https://wslutiliti.es/wslu/man/wslact.html
  sudo wslact time-sync
}

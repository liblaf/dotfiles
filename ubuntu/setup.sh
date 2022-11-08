#!/usr/bin/env bash

function install-common() {
  sudo apt install build-essential procps curl file git # brew requirements
  sudo apt install sntp
  sudo apt install libarchive-tools # ranger requirements (bsdtar)
}

function install-zsh() {
  sudo apt install zsh
  chsh --shell "$(which zsh)"
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install-brew() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

sub_command="${1:-"all"}"
shift

case "${sub_command}" in
  "all")
    install-common
    install-zsh
    install-brew
    ;;
  *)
    "install-${sub_command}"
    ;;
esac

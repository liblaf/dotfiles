#!/usr/bin/env bash

function _exec() {
  echo -n "\x1b[1;94m"
  echo "${@}"
  echo -n "\x1b[0m"
  "${@}"
}

function clean-apt() {
  _exec sudo apt clean
  _exec sudo apt autoclean
  _exec sudo apt autoremove
}

function clean-brew() {
  _exec brew autoremove
  _exec brew cleanup
}

function clean-cache() {
  _exec rm --force --recursive "${HOME}/.cache/"
}

function clean-pip() {
  _exec conda clean --all
  _exec pip cache purge
}

function clean-pnpm() {
  _exec pnpm store prune
}

function clean-zsh() {
  _exec rm --force ${HOME}/.zcompdump*
}

function clean() {
  case "${1:-"all"}" in
  "all")
    for target in apt brew cache pip pnpm zsh; do
      "clean-${target}"
    done
    ;;
  *)
    "clean-${1}"
    ;;
  esac
}

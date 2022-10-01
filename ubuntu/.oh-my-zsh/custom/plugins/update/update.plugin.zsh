#!/usr/bin/env bash

function _exec() {
  echo -n "\x1b[1;94m"
  echo "${@}"
  echo -n "\x1b[0m"
  "${@}"
}

function update-apt() {
  _exec sudo apt update
  _exec sudo apt upgrade
}

function update-brew() {
  _exec brew update
  _exec brew upgrade
}

function update-pip() {
  _exec conda update --all
  pip list --outdated --format freeze |
    grep --invert-match '^\-e' |
    cut --delimiter='=' --fields=1 |
    _exec xargs --max-args=1 --no-run-if-empty pip install --upgrade
}

function update-pnpm() {
  _exec pnpm env use --global lts
  _exec pnpm update --global
}

function update-snap() {
  _exec sudo snap refresh
}

function update() {
  case "${1:-"all"}" in
  "all")
    for target in apt brew pip pnpm snap; do
      "update-${target}"
    done
    ;;
  *)
    "update-${1}"
    ;;
  esac
}

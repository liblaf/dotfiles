#!/usr/bin/zsh

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
  while read pkg; do
    _exec pip install --upgrade "${pkg}"
  done < <(
    pip list --outdated --format json |
      jq --raw-output '.[] | "\(.name)==\(.latest_version)"' |
      cut --delimiter '=' --fields 1
  )
}

function update-pnpm() {
  _exec pnpm env use --global lts
  _exec pnpm update --global
}

function update-snap() {
  _exec sudo snap refresh
}

function update() {
  function _exec() {
    echo -n "\x1b[1;94m"
    echo "${@}"
    echo -n "\x1b[0m"
    "${@}"
  }
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
  unset _exec
}

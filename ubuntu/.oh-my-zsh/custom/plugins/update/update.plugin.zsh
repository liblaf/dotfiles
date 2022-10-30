#!/usr/bin/zsh

function call() {
  rich --print "[bold bright_blue]+ ${*}"
  "${@}"
}

function update-apt() {
  call sudo apt update
  call sudo apt dist-upgrade
}

function update-brew() {
  call brew update
  call brew upgrade
}

function update-npm() {
  call pnpm env use --global lts
  call pnpm update --global
}

function update-pip() {
  call conda update --all
  while read pkg; do
    call pip install --upgrade "${pkg}"
  done < <(
    pip list --outdated --format json |
      jq --raw-output '.[] | "\(.name)==\(.latest_version)"' |
      cut --delimiter '=' --fields 1
  )
}

function update-snap() {
  call sudo snap refresh
}

function update-tldr() {
  call tldr --update
}

function update() {
  if [[ -n "${1}" ]]; then
    local cmd="${1}"
    shift 1
  else
    local cmd="all"
  fi
  case "${cmd}" in
  "all")
    for target in apt brew cache npm snap tldr; do
      "update-${target}" "${@}"
    done
    ;;
  *)
    "update-${cmd}" "${@}"
    ;;
  esac
}

#!/usr/bin/zsh

function call() {
  rich --print "[bold bright_blue]+ ${*}"
  "${@}"
}

function clean-apt() {
  call sudo apt autoclean
  call sudo apt autoremove
  call sudo apt clean
}

function clean-brew() {
  call brew autoremove
  call brew cleanup
}

function clean-cache() {
  call rm --force --recursive "${HOME}/.cache/"
  local files=(/tmp/*)
  for file in "${files[@]}"; do
    call rm --force --recursive "${file}"
  done
}

function clean-npm() {
  call pnpm store prune
}

function clean-pip() {
  call conda clean --all
  call pip cache purge
}

function clean-tldr() {
  call tldr --clear-cache
}

function clean-zsh() {
  local files=(${HOME}/.zcompdump* ${HOME}/.bash*)
  for file in "${files[@]}"; do
    call rm --force --recursive "${file}"
  done
}

function clean() {
  if [[ -n "${1}" ]]; then
    local cmd="${1}"
    shift 1
  else
    local cmd="all"
  fi
  case "${cmd}" in
  "all")
    for target in apt brew cache npm pip tldr zsh; do
      "clean-${target}" "${@}"
    done
    ;;
  *)
    "clean-${cmd}" "${@}"
    ;;
  esac
}

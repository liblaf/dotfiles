#!/usr/bin/zsh

function pkg-list() {
  fd --type directory . ubuntu/.oh-my-zsh/custom/plugins/pkg --exec basename |
    sort |
    pr --columns 4 --omit-header --omit-pagination --width 80
}

function pkg-call() {
  if [[ -e "${PKG_HOME}/${name}/${cmd}.zsh" ]]; then
    zsh "${PKG_HOME}/${name}/${cmd}.zsh" "${@}"
  elif [[ -e "${PKG_HOME}/${name}/${cmd}.sh" ]]; then
    bash "${PKG_HOME}/${name}/${cmd}.sh" "${@}"
  else
    bash "${PKG_HOME}/${name}/${cmd}.sh" "${@}"
  fi
}

function pkg-source() {
  if [[ -e "${PKG_HOME}/${name}/${cmd}.zsh" ]]; then
    source "${PKG_HOME}/${name}/${cmd}.zsh"
  elif [[ -e "${PKG_HOME}/${name}/${cmd}.sh" ]]; then
    source "${PKG_HOME}/${name}/${cmd}.sh"
  else
    source "${PKG_HOME}/${name}/${cmd}.sh"
  fi
}

function pkg() {
  local PKG_HOME="${ZSH_CUSTOM}/plugins/pkg"
  export PKG_HOME
  local cmd="${1}"
  shift 1
  if [[ -n "${1}" ]]; then
    local name="${1}"
    shift 1
  fi
  case "${cmd}" in
  doctor) pkg-call "${@}" ;;
  install) pkg-call "${@}" ;;
  list) pkg-list ;;
  load) pkg-source "${@}" ;;
  reinstall)
    pkg install "${name}" "${@}"
    pkg uninstall "${name}" "${@}"
    ;;
  uninstall) pkg-call "${@}" ;;
  unload) pkg-source "${@}" ;;
  *) pkg-call "${@}" ;;
  esac
}

pkg load llvm

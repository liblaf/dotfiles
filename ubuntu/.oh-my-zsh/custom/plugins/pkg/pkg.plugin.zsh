#!/usr/bin/zsh

function pkg_exec() {
  if [[ -e "${PKG_HOME}/${name}/${cmd}.zsh" ]]; then
    zsh "${PKG_HOME}/${name}/${cmd}.zsh" "${@}"
  elif [[ -e "${PKG_HOME}/${name}/${cmd}.sh" ]]; then
    bash "${PKG_HOME}/${name}/${cmd}.sh" "${@}"
  else
    bash "${PKG_HOME}/${name}/${cmd}.sh" "${@}"
  fi
}

function pkg_source() {
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
  local name="${2}"
  shift 2
  case "${cmd}" in
  doctor) pkg_exec "${@}" ;;
  install) pkg_exec "${@}" ;;
  load) pkg_source "${@}" ;;
  reinstall)
    pkg uninstall "${name}" "${@}"
    pkg install "${name}" "${@}"
    ;;
  uninstall) pkg_exec "${@}" ;;
  unload) pkg_source "${@}" ;;
  *) pkg_exec "${@}" ;;
  esac
}

pkg load llvm

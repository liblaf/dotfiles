#!/usr/bin/env zsh

pkg_scripts_dir="$(dirname "${0}")"

function pkg() {
  local cmd="${1}"
  shift
  local name="${1}"
  shift
  case "${cmd}" in
  install)
    bash "${pkg_scripts_dir}/${name}/${cmd}.sh" "${@}"
    ;;
  uninstall)
    bash "${pkg_scripts_dir}/${name}/${cmd}.sh" "${@}"
    ;;
  load)
    source "${pkg_scripts_dir}/${name}/${cmd}.sh" "${@}"
    ;;
  unload)
    source "${pkg_scripts_dir}/${name}/${cmd}.sh" "${@}"
    ;;
  doctor)
    bash "${pkg_scripts_dir}/${name}/${cmd}.sh" "${@}"
    ;;
  *)
    bash "${pkg_scripts_dir}/${name}/${cmd}.sh" "${@}"
    ;;
  esac
}

pkg load llvm
pkg load most

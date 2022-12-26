#!/bin/bash

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

function info() {
  if ! exists rich; then
    rich --print --style "bold bright_blue" "${*}"
  else
    echo -e -n "\x1b[1;94m"
    echo -n "${*}"
    echo -e "\x1b[0m"
  fi
}

function success() {
  if ! exists rich; then
    rich --print --style "bold bright_green" "${*}"
  else
    echo -e -n "\x1b[1;92m"
    echo -n "${*}"
    echo -e "\x1b[0m"
  fi
}

function call() {
  info "+ ${*}"
  "${@}"
}

function copy() {
  mkdir --parents "$(realpath --canonicalize-missing "${2}/..")"
  cp --force --recursive "${1}" "${2}"
  success "Copy: ${1} -> ${2}"
}

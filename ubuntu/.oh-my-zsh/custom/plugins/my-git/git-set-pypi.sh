#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function info() {
  rich --print "[bold bright_blue]${*}"
}

function ask() {
  name="${1}"
  default="${2}"
  shift 2
  echo -e -n "\x1b[1;92m"
  echo -n "?"
  echo -e -n "\x1b[0m\x1b[1m"
  echo -n " ${*} "
  echo -e -n "\x1b[0m\x1b[90m"
  echo -n "[${default}] "
  echo -e -n "\x1b[0m\x1b[96m"
  read "${name}"
  echo -e "\x1b[0m"
}

function call() {
  info "+ ${*}"
  "${@}"
}

info '+ PYPI_TOKEN="$(bw get notes PYPI_TOKEN)"'
PYPI_TOKEN="$(bw get notes PYPI_TOKEN)"
info '+ gh secret set PYPI_TOKEN --body "${PYPI_TOKEN}"'
gh secret set PYPI_TOKEN --body "${PYPI_TOKEN}"

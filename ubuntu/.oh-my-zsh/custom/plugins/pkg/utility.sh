#!/bin/bash

export DESKTOP_FILE_INSTALL_DIR="${HOME}/.local/share/applications"

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

function _log() {
  echo -e -n "\x1b[${1}m"
  echo -n "${*:2}"
  echo -e "\x1b[0m"
}

function critical() {
  if exists rich; then
    rich --print --style "bold reverse bright_red" "${*}"
  else
    _log "1;7;91" "${*}"
  fi
}

function error() {
  if exists rich; then
    rich --print --style "bold red" "${*}"
  else
    _log "1;91" "${*}"
  fi
}

function warning() {
  if exists rich; then
    rich --print --style "bold bright_yellow" "${*}"
  else
    _log "1;93" "${*}"
  fi
}

function info() {
  if exists rich; then
    rich --print --style "bright_blue" "${*}"
  else
    _log "94" "${*}"
  fi
}

function debug() {
  if exists rich; then
    rich --print --style "" "${*}"
  else
    _log "0" "${*}"
  fi
}

function trace() {
  if exists rich; then
    rich --print --style "dim" "${*}"
  else
    _log "2" "${*}"
  fi
}

function success() {
  if exists rich; then
    rich --print --style "bold bright_green" "${*}"
  else
    _log "1;92" "${*}"
  fi
}

function tip() {
  if exists rich; then
    rich --print --style "bold bright_cyan" "${*}"
  else
    _log "1;96" "${*}"
  fi
}

function call() {
  info "+ ${*}"
  "${@}"
}

function confirm() {
  echo -e -n "\x1b[1;92m"
  echo -n "?"
  echo -e -n "\x1b[0m\x1b[1m"
  echo -n " ${*:-"Confirm"} "
  echo -e -n "\x1b[0m\x1b[90m"
  echo -n "(y/N) "
  echo -e -n "\x1b[0m\x1b[2m"
  read res
  echo -e "\x1b[0m"
  if [[ ${res} =~ ^([yY][eE][sS]|[yY])$ ]]; then
    return 0
  else
    return 1
  fi
}

function take() {
  mkdir --parents "${@}"
  cd "${@}"
}

function move() {
  mkdir --parents "$(realpath --canonicalize-missing "${2}/..")"
  mv "${1}" "${2}"
  success "Move: ${1} -> ${2}"
}

function copy() {
  mkdir --parents "$(realpath --canonicalize-missing "${2}/..")"
  cp --recursive "${1}" "${2}"
  success "Copy: ${1} -> ${2}"
}

function remove() {
  rm --force --recursive "${@}"
  success "Remove: ${@}"
}

function replace() {
  rm --force --recursive "${2}"
  mkdir --parents "$(realpath --canonicalize-missing "${2}/..")"
  mv "${1}" "${2}"
  success "Replace: ${1} -> ${2}"
}

function link() {
  mkdir --parents "$(realpath --canonicalize-missing "${2}/..")"
  ln --force --relative --symbolic "${1}" "${2}"
  success "Link: ${2} -> ${1}"
}

function make-desktop-entry-append() {
  local key="${1}"
  local default="${2:-""}"
  local value="${!key:-"${default}"}"
  if [[ -n ${value:-""} ]]; then
    echo "${key}=${value}" >> "${filepath}"
  fi
}

function make-desktop-entry() {
  local filename="${1}.desktop"
  mkdir --parents "${DESKTOP_FILE_INSTALL_DIR}"
  local filepath="${DESKTOP_FILE_INSTALL_DIR}/${filename}"
  echo "[Desktop Entry]" > "${filepath}"
  make-desktop-entry-append Type "Application"
  make-desktop-entry-append Name "${1}"
  make-desktop-entry-append Comment
  make-desktop-entry-append Path
  make-desktop-entry-append Exec
  make-desktop-entry-append Icon
  make-desktop-entry-append Terminal "false"
  make-desktop-entry-append Categories
  make-desktop-entry-append MimeType
  make-desktop-entry-append GenericName
  make-desktop-entry-append StartupNotify
  desktop-file-install --dir "${DESKTOP_FILE_INSTALL_DIR}" "${filepath}"
  success "Desktop Entry: ${1}"
}

function _download() {
  if exists https; then
    https --body --download --output "${output}" "${url}"
  elif exists curl; then
    curl --output "${output}" "${url}"
  elif exists wget; then
    wget --output-document="${output}" "${url}"
  else
    error "Download tool not found!"
    tip 'Supported download tools: "httpie", "cURL", "Wget"'
  fi
}

function download() {
  local url="${1}"
  local output="${2:-"$(basename "${url}")"}"
  if [[ -e ${output} ]]; then
    if confirm "${output} already exists. Do you wish to overwrite?"; then
      _download
    fi
  else
    local dirname="$(dirname "${output}")"
    if [[ -n ${dirname} ]]; then
      mkdir --parents "${dirname}"
    fi
    _download
  fi
  success "Download: ${url} -> ${output}"
}

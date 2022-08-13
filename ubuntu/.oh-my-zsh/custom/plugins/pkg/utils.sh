#!/usr/bin/env bash

function confirm() {
  echo -n "${@:-"Are you sure?"} [y/N] "
  read response
  if [[ "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    true
  else
    false
  fi
}

function download() {
  local url="${1}"
  local output="${2:-"$(basename "${url}")"}"
  if [[ -e "${output}" ]]; then
    if confirm "Are you sure to overwrite \"${output}\"?"; then
      wget --output-document="${output}" "${url}"
    fi
  else
    local dirname="$(dirname "${output}")"
    if [[ -n "${dirname}" ]]; then
      mkdir --parents "${dirname}"
    fi
    wget --output-document="${output}" "${url}"
  fi
}

function extract() {
  local input="${1}"
  local output="${2:-"$(pwd)"}"
  if [[ -e "${output}" ]]; then
    echo "Are you sure to overwrite all existing files under \"${output}\"?"
    if confirm "YES to comfirm or NO to skip extracting of existing files."; then
      local overwrite_mode="-aoa"
    else
      local overwrite_mode="-aos"
    fi
  fi
  mkdir --parents "${output}"
  if [[ "${input}" =~ ^.*\.zip$ ]]; then
    7zz x "${overwrite_mode}" -snld -o"${output}" -- "${input}"
  elif [[ "${input}" =~ ^.*\.tar\.gz$ ]]; then
    7zz x -so -snld -- "${input}" |
      7zz x "${overwrite_mode}" -si -snld -ttar -o"${output}"
  fi
}

#!/usr/bin/bash

export DESKTOP_FILE_INSTALL_DIR="${HOME}/.local/share/applications"

function info() {
  rich --print "[bold bright_blue]${*}"
}

function success() {
  rich --print "[bold bright_green]${*}"
}

function call() {
  info "+ ${*}"
  "${@}"
}

function confirm() {
  echo -e -n "\x1b[1;92m"
  echo -n "?"
  echo -e -n "\x1b[0m\x1b[1m"
  echo -n " ${@:-"Confirm"} "
  echo -e -n "\x1b[0m\x1b[90m"
  echo -n "(y/N) "
  echo -e -n "\x1b[0m\x1b[96m"
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

function replace() {
  rm --force --recursive "${2}"
  mv "${1}" "${2}"
}

function desktop-entry-install-append() {
  local key="${1}"
  local default="${2:-""}"
  local value="${!key:-"${default}"}"
  if [[ -n ${value:-""} ]]; then
    echo "${key}=${value}" >> "${filepath}"
  fi
}

function desktop-entry-install() {
  function append() {
    desktop-entry-install-append "${@}"
  }
  local filename="${1}.desktop"
  mkdir --parents "${DESKTOP_FILE_INSTALL_DIR}"
  local filepath="${DESKTOP_FILE_INSTALL_DIR}/${filename}"
  echo "[Desktop Entry]" > "${filepath}"
  append Type "Application"
  append Name "${1}"
  append Comment
  append Path
  append Exec
  append Icon
  append Terminal "false"
  append Categories
  append MimeType
  append GenericName
  append StartupNotify
  desktop-file-install --dir "${DESKTOP_FILE_INSTALL_DIR}" "${filepath}"
}

if command -v https > /dev/null 2>&1; then
  # HTTPie
  function _download() {
    https --body --download --output "${output}" "${url}"
  }
elif command -v curl > /dev/null 2>&1; then
  # cURL
  function _download() {
    curl --output "${output}" "${url}"
  }
elif command -v wget > /dev/null 2>&1; then
  function _download() {
    wget --output-document="${output}" "${url}"
  }
else
  echo "Download tool not found!"
  echo 'Supported download tools: "HTTPie", "cURL", "wget"'
fi

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
  success "Download: [link=${output}]${output}[/link]"
  success "          <= [link=${url}]${url}[/link]"
}

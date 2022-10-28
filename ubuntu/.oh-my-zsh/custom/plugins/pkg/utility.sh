#!/usr/bin/bash

export DESKTOP_FILE_INSTALL_DIR="${HOME}/.local/share/applications"

function note() {
  echo -e -n "\033[1;94m"
  echo -n "[NOTE] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function confirm() {
  echo -n "${@:-"Are you sure?"} [y/N] "
  read response
  if [[ "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    return 0
  else
    return 1
  fi
}

function take() {
  mkdir --parents "${@}"
  cd "${@}"
}

function desktop-entry-install() {
  local filename="${1}.desktop"
  mkdir --parents "${DESKTOP_FILE_INSTALL_DIR}"
  local filepath="${DESKTOP_FILE_INSTALL_DIR}/${filename}"
  echo "[Desktop Entry]" >"${filepath}"
  echo "Type=${type:-"Application"}" >>"${filepath}"
  echo "Name=${name:-"${1}"}" >>"${filepath}"
  if [[ -n "${folder:-""}" ]]; then
    echo "Path=${folder}" >>"${filepath}"
  fi
  echo "Exec=${exec}" >>"${filepath}"
  if [[ -n "${icon:-""}" ]]; then
    echo "Icon=${icon}" >>"${filepath}"
  fi
  echo "Terminal=${terminal:-"false"}" >>"${filepath}"
  desktop-file-install --dir "${DESKTOP_FILE_INSTALL_DIR}" "${filepath}"
}

if command -v https >/dev/null 2>&1; then
  # HTTPie
  function _download() {
    https --body --download --output "${output}" "${url}"
  }
elif command -v curl >/dev/null 2>&1; then
  # cURL
  function _download() {
    curl --output "${output}" "${url}"
  }
elif command -v wget >/dev/null 2>&1; then
  function _download() {
    wget --output-document="${output}" "${url}"
  }
else
  echo "Download tool not found!"
  echo "Supported download tools: \"HTTPie\", \"cURL\", \"wget\""
fi

function download() {
  local url="${1}"
  local output="${2:-"$(basename "${url}")"}"
  if [[ -e "${output}" ]]; then
    if confirm "${output} already exists. Do you wish to overwrite?"; then
      _download
    fi
  else
    local dirname="$(dirname "${output}")"
    if [[ -n "${dirname}" ]]; then
      mkdir --parents "${dirname}"
    fi
    _download
  fi
}

# function extract() {
#   local input="${1}"
#   local output="${2:-"$(pwd)"}"
#   local overwrite=""
#   if [[ -e "${output}" ]]; then
#     echo "YES    : overwrite existing files without prompting."
#     echo "NO     : never overwrite existing files."
#     echo "Ctrl-C : cancel extraction."
#     if confirm "Are you sure to overwrite existing files under \"${output}\"?"; then
#       overwrite="y"
#     else
#       overwrite="n"
#     fi
#   else
#     mkdir --parents "${output}"
#   fi
#   if [[ "${input}" =~ ^.*\.zip$ ]]; then
#     if [[ "${overwrite}" == "y" ]]; then
#       overwrite="-o"
#     else
#       overwrite="-n"
#     fi
#     local num_files="$(zipinfo -1 "${input}" | wc --lines)"
#     unzip ${overwrite} "${input}" -d "${output}" |
#       pv --size "${num_files}" --line-mode --name "${input} => ${output}" >"/dev/null"
#   elif [[ "${input}" =~ ^.*\.tar\.gz$ ]]; then
#     if [[ "${overwrite}" == "y" ]]; then
#       overwrite="--overwrite"
#     else
#       overwrite="--keep-old-files"
#     fi
#     pv --name "${input} => ${output}" "${input}" |
#       tar --extract ${overwrite} --gunzip --directory "${output}"
#   else
#     echo "Cannot extract \"${input}\"."
#     echo "Supported formats: *.zip, *.tar.gz"
#   fi
# }

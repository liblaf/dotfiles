#!/usr/bin/zsh

source "${ZSH}/plugins/extract/extract.plugin.zsh"

if command -v extract >/dev/null 2>&1; then
  function ext() {
    local work_dir="${2:-"$(pwd)"}"
    mkdir --parents "${work_dir}"
    (
      cd "${work_dir}"
      set +o errexit
      extract "${1}"
    )
    success "Extract: [link=${1}]${1}[/link]"
    success "         => [link=${work_dir}]${work_dir}[/link]"
  }
fi

source "${PKG_HOME}/utility.sh"

function desktop-entry-install-append() {
  local key="${1}"
  local default="${2:-""}"
  local value="${(P)key:-"${default}"}"
  if [[ -n "${value:-""}" ]]; then
    echo "${key}=${value}" >>"${filepath}"
  fi
}

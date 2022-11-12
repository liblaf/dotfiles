#!/usr/bin/zsh

source "${ZSH}/plugins/extract/extract.plugin.zsh"
source "${PKG_HOME}/utility.sh"

if exists extract; then
  function ext() {
    local work_dir="${2:-"$(pwd)"}"
    take "${work_dir}"
    (
      set +o errexit
      extract "${1}"
    )
    success "Extract: ${1} -> ${work_dir}"
  }
fi

function make-desktop-entry-append() {
  local key="${1}"
  local default="${2:-""}"
  local value="${(P)key:-"${default}"}"
  if [[ -n ${value:-""} ]]; then
    echo "${key}=${value}" >> "${filepath}"
  fi
}

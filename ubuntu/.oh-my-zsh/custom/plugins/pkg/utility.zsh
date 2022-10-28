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
  }
fi

source "${PKG_HOME}/utility.sh"

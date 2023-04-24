function has() {
  command -v "${@}" > /dev/null 2>&1
}

function run() {
  if has gum; then
    local prefix="$(gum style --background=14 --foreground=0 --padding="0 1" RUN)"
    local message="$(gum style --foreground=14 "${*}")"
    gum join --horizontal "${prefix}" " " "${message}"
  fi
  "${@}"
  local ret=$?
  if has gum; then
    if ((ret != 0)); then
      local prefix="$(gum style --background=9 --foreground=7 --padding="0 1" "FAIL ${ret}")"
      local message="$(gum style --foreground=9 "${*}")"
      gum join --horizontal "${prefix}" " " "${message}"
    fi
  fi
}

function run-safe() {
  (
    set +o errexit
    run "${@}"
  )
}

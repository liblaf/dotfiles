function has() {
  command -v "${@}" > /dev/null 2>&1
}

function run() {
  if has gum; then
    local prefix="$(gum style --background=14 --foreground=0 --padding="0 1" RUN)"
    local message="$(gum style --foreground=14 "${*}")"
    gum join --horizontal "${prefix}" " " "${message}"
  else
    echo -e "\x1b[1;7;96m RUN \x1b[0m" "${*}"
  fi
  "${@}"
  local ret=$?
  if ((ret != 0)); then
    if has gum; then
      local prefix="$(gum style --background=9 --foreground=7 --padding="0 1" "FAIL ${ret}")"
      local message="$(gum style --foreground=9 "${*}")"
      gum join --horizontal "${prefix}" " " "${message}"
    else
      echo -e "\x1b[1;7;91m FAIL ${ret} \x1b[0m" "${*}"
    fi
  fi
}

function run-safe() {
  (
    set +o errexit
    run "${@}"
  )
}

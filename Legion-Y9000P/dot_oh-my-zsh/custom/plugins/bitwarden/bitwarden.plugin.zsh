function bw-unlock() {
  if BW_SESSION=$(bw unlock --raw); then
    export BW_SESSION
    mkdir --parents --verbose "${HOME}/.cache/env"
    echo "export BW_SESSION=\"${BW_SESSION}\"" > "${HOME}/.cache/env/bw.envrc"
  else
    return 1
  fi
}

if [[ -r "${HOME}/.cache/env/bw.envrc" ]]; then
  source "${HOME}/.cache/env/bw.envrc"
fi

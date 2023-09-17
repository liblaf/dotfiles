function bw-unlock() {
  if ! bw unlock --check; then
    if BW_SESSION=$(bw unlock --raw); then
      export BW_SESSION
    else
      return 1
    fi
  fi
  mkdir --parents --verbose "$HOME/.cache/env"
  echo "export BW_SESSION=\"$BW_SESSION\"" > "$HOME/.cache/env/bw.envrc"
}

if [[ -r "$HOME/.cache/env/bw.envrc" ]]; then
  source "$HOME/.cache/env/bw.envrc"
fi

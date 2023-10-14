function bw-unlock() {
  if ! bw unlock --check; then
    if BW_SESSION=$(bw unlock --raw); then
      export BW_SESSION
    else
      return 1
    fi
  fi
  mkdir --parents --verbose "$HOME/.config/environment.d"
  echo "export BW_SESSION=\"$BW_SESSION\"" > "$HOME/.config/environment.d/bitwarden.conf"
}

#!/usr/bin/zsh

function exists() {
  command -v "${@}" > /dev/null
}

if exists lsd; then
  alias ls="lsd"
fi

unfunction exists

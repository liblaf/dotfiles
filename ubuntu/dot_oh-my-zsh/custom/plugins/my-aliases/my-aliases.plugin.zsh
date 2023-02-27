#!/usr/bin/zsh

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

alias c="clear"
alias u="utils"

if exists colored; then
  alias less="colored less"
fi

if exists exa; then
  alias ls="exa --icons --git"
  if ! exists tree; then
    alias tree="exa --tree --icons"
  fi
fi

unset -f exists

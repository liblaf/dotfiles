#!/usr/bin/zsh

function has() {
  command -v "${@}" > /dev/null 2>&1
}

alias c="clear"
alias u="utils"

if has colored; then
  alias less="colored less"
fi

if has exa; then
  alias ls="exa --icons --git"
  if ! has tree; then
    alias tree="exa --tree --icons"
  fi
fi

unset -f has

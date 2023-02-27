#!/usr/bin/zsh

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

if exists colored; then
  alias less="colored less"
fi

if exists exa; then
  alias ls="exa --icon --git"
  if ! exists tree; then
    alias tree="exa --tree --icons"
  fi
fi

#!/usr/bin/env zsh

# exa
if command -v exa >"/dev/null"; then
  alias l="exa --long --all --header --git"
  alias la="exa --long --all --header --git"
  alias ll="exa --long --header --git"
  alias ls="exa --git"
  alias lsa="exa --long --all --all --header --git"
  if ! command -v tree >"/dev/null"; then
    alias tree="exa --tree"
  fi
fi

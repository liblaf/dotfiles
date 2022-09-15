#!/usr/bin/env zsh

# exa
if command -v exa >"/dev/null"; then
  alias l="exa --long --icons --all --header --git"
  alias la="exa --long --icons --all --header --git"
  alias ll="exa --long --icons --header --git"
  alias ls="exa --git"
  alias lsa="exa --long --icons --all --all --header --git"
  if ! command -v tree >"/dev/null"; then
    alias tree="exa --tree --icons"
  fi
fi

#!/usr/bin/env zsh

function _exist() {
  if command -v "${@}" >"/dev/null" 2>&1; then
    return 0
  else
    return 1
  fi
}

# bat
if _exist bat; then
  alias cat="bat"
fi

# colored
if _exist colored; then
  alias less="colored less"
fi

# exa
if _exist exa; then
  alias l="exa --long --icons --all --header --git"
  alias la="exa --long --icons --all --header --git"
  alias ll="exa --long --icons --header --git"
  alias ls="exa --git"
  alias lsa="exa --long --icons --all --all --header --git"
  if ! command -v tree >"/dev/null"; then
    alias tree="exa --tree --icons"
  fi
fi

# glances
if _exist glances; then
  alias top="glances"
fi

# zoxide
if _exist z; then
  alias cd="z"
fi

unset _exist

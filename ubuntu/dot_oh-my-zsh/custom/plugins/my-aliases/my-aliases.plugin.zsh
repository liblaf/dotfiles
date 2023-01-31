#!/usr/bin/zsh

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

# bat
if exists bat; then
  alias cat="bat"
fi

# bottom
if exists btm; then
  alias top="btm"
fi

# colored
if exists colored; then
  alias less="colored less"
fi

# exa
if exists exa; then
  alias l="exa --long --icons --all --header --git"
  alias la="exa --long --icons --all --header --git"
  alias ll="exa --long --icons --header --git"
  alias ls="exa --git"
  alias lsa="exa --long --icons --all --all --header --git"
  if ! exists tree; then
    alias tree="exa --tree --icons"
  fi
fi

# neovim
if exists nvim; then
  alias vi="nvim"
  alias vim="nvim"
fi

# texdoc-cli
if exists texdoc-cli; then
  alias texdoc="texdoc-cli pkg"
fi

# zoxide
if exists z; then
  alias cd="z"
fi

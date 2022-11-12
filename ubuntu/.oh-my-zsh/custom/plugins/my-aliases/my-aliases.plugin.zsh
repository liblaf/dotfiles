#!/usr/bin/zsh

function exist() {
  command -v "${@}" > "/dev/null" 2>&1
}

# bat
if exist bat; then
  alias cat="bat"
fi

# bottom
if exist btm; then
  alias top="btm"
fi

# colored
if exist colored; then
  alias less="colored less"
fi

# exa
if exist exa; then
  alias l="exa --long --icons --all --header --git"
  alias la="exa --long --icons --all --header --git"
  alias ll="exa --long --icons --header --git"
  alias ls="exa --git"
  alias lsa="exa --long --icons --all --all --header --git"
  if ! command -v tree > "/dev/null"; then
    alias tree="exa --tree --icons"
  fi
fi

# neovim
if exist nvim; then
  alias vim="nvim"
fi

# onedrive
if exist onedrive; then
  alias drive-p="onedrive --confdir \"${HOME}/.config/onedrive-personal\""
  alias drive="onedrive --confdir \"${HOME}/.config/onedrive-public\""
fi

# texdoc-cli
if exist texdoc-cli; then
  alias texdoc="texdoc-cli pkg"
fi

# zoxide
if exist z; then
  alias cd="z"
fi

unset exist

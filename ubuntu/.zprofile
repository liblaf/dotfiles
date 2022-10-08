# ~/.zprofile: user .zprofile file for zsh(1).
#
# This file is sourced only for login shells (i.e. shells
# invoked with "-" as the first character of argv[0], and
# shells invoked with the -l flag.)
#
# Global Order: zshenv, zprofile, zshrc, zlogin

if ! command -v brew &>"/dev/null"; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    BREW_LOCATION="/opt/homebrew/bin/brew"
  elif [[ -x /usr/local/bin/brew ]]; then
    BREW_LOCATION="/usr/local/bin/brew"
  elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    BREW_LOCATION="/home/linuxbrew/.linuxbrew/bin/brew"
  elif [[ -x "$HOME/.linuxbrew/bin/brew" ]]; then
    BREW_LOCATION="$HOME/.linuxbrew/bin/brew"
  else
    return
  fi
fi

# https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

if [[ -z "$HOMEBREW_PREFIX" ]]; then
  if [[ -z $BREW_LOCATION ]]; then
    eval "$(brew shellenv)"
  else
    eval "$("$BREW_LOCATION" shellenv)"
  fi
fi

if [[ -d "$(brew --prefix)/share/zsh/site-functions" ]]; then
  fpath+="$(brew --prefix)/share/zsh/site-functions"
  export FPATH
fi

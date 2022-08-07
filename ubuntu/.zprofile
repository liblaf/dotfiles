# ~/.zprofile: executed by the command interpreter for login shells.

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

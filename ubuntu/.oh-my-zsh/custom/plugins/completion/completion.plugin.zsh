#!/usr/bin/zsh

source "$(dirname "${0}")/argcomplete.sh"

if brew --prefix git-extras >/dev/null 2>&1; then
  source "$(brew --prefix git-extras)/share/git-extras/git-extras-completion.zsh"
fi

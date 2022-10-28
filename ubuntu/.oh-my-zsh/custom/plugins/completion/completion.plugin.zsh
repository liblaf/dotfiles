#!/usr/bin/zsh

completion_home="${ZSH_CUSTOM}/plugins/completion"

if [[ ! -f "${completion_home}/argcomplete.sh" ]]; then
  commitizen_home=$(brew --prefix commitizen)
  if [[ -d "${commitizen_home}" ]]; then
    if [[ -x "${commitizen_home}/libexec/bin/register-python-argcomplete" ]]; then
      "${commitizen_home}/libexec/bin/register-python-argcomplete" cz >"${commitizen_home}/argcomplete.sh"
    fi
  fi
fi

if [[ -f "${completion_home}/argcomplete.sh" ]]; then
  source "${completion_home}/argcomplete.sh"
fi

if brew --prefix git-extras >/dev/null 2>&1; then
  source "$(brew --prefix git-extras)/share/git-extras/git-extras-completion.zsh"
fi

unset completion_home

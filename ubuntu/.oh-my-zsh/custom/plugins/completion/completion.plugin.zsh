#!/usr/bin/zsh

completion_home="${ZSH_CUSTOM}/plugins/completion"

# commitizen
if [[ ! -f "${completion_home}/_cz" ]]; then
  commitizen_home="$(brew --prefix commitizen)"
  if [[ -d ${commitizen_home} ]]; then
    if [[ -x "${commitizen_home}/libexec/bin/register-python-argcomplete" ]]; then
      "${commitizen_home}/libexec/bin/register-python-argcomplete" cz > "${completion_home}/_cz"
    fi
  fi
  unset commitizen_home
fi

# git-extras
if brew --prefix git-extras > /dev/null 2>&1; then
  source "$(brew --prefix git-extras)/share/git-extras/git-extras-completion.zsh"
fi

# rich
if [[ ! -f "${completion_home}/_rich" ]]; then
  _RICH_COMPLETE=zsh_source rich > "${completion_home}/_rich"
fi

for file in $(ls "${completion_home}"); do
  if [[ ! ${file} =~ ^.*\.plugin\.zsh ]]; then
    source "${completion_home}/${file}"
  fi
done

unset completion_home

#!/usr/bin/zsh

if [[ -r "${HOME}/.ssh/config" ]]; then
  zstyle -s ':completion:*:hosts' hosts _ssh_config
  _ssh_config+=($(cat "${HOME}/.ssh/config" | sed --quiet --expression="s/Host[=\t ]//p"))
  zstyle ':completion:*:hosts' hosts ${_ssh_config}
fi

if [[ -d "${HOME}/.zfunc" ]]; then
  case ":${FPATH}:" in
    *":${HOME}/.zfunc:"*) ;;
    *) export FPATH="${HOME}/.zfunc${FPATH:+:${FPATH}}" ;;
  esac
fi

if [[ -f /usr/share/doc/git-extras/git-extras-completion.zsh ]]; then
  source /usr/share/doc/git-extras/git-extras-completion.zsh
fi
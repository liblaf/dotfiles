#!/usr/bin/zsh

if [[ -d "${HOME}/.zfunc" ]]; then
  case ":${FPATH}:" in
    *":${HOME}/.zfunc:"*) ;;
    *) export FPATH="${HOME}/.zfunc${FPATH:+:${FPATH}}" ;;
  esac
fi

if [[ -f /usr/share/doc/git-extras/git-extras-completion.zsh ]]; then
  source /usr/share/doc/git-extras/git-extras-completion.zsh
fi

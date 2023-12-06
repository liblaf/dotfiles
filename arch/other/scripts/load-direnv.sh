#shellcheck disable=SC2148

if type direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

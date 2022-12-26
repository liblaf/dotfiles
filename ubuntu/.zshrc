# ~/.zshrc: user-wide .zshrc file for zsh(1).
#
# This file is sourced only for interactive shells. It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-"${HOME}/.cache"}/p10k-instant-prompt-${USER}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-"${HOME}/.cache"}/p10k-instant-prompt-${USER}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH}/custom"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  aliases
  brew
  colored-man-pages
  command-not-found
  common-aliases
  cp
  extract
  git
  perms
  tmux
  universalarchive
  zoxide

  conda-zsh-completion
  wakatime
  zsh-autocomplete
  zsh-syntax-highlighting

  clean
  completion
  ipkg
  key
  my-aliases
  my-git
  ntp
  proxy
  rclone
  update
)
ipkg_loads=(
  conda
  docker
  llvm
)

source "${ZSH}/oh-my-zsh.sh"

# pnpm
export PNPM_HOME="${HOME}/.local/share/pnpm"
export PATH="${PNPM_HOME}:${PATH}"
# pnpm end

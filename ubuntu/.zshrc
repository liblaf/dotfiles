# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH}/custom"
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

ulimit -n "$(ulimit -H -n)"

# pnpm
export PNPM_HOME="/home/liblaf/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

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
  key
  my-aliases
  my-git
  ntp
  pkg
  proxy
  rclone
  update
)
source $ZSH/oh-my-zsh.sh

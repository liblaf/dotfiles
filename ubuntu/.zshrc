# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${ZSH}/custom"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  aliases
  brew
  colored-man-pages
  command-not-found
  common-aliases
  extract
  fzf
  git
  perms
  tmux
  universalarchive
  zoxide

  conda-zsh-completion
  wakatime
  zsh-autocomplete
  zsh-autosuggestions
  zsh-syntax-highlighting

  clean
  completion
  key
  my-aliases
  my-git
  ntp
  pkg
  proxy
  update
)

# fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

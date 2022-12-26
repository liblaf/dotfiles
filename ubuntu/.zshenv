# ~/.zshenv: user-wide .zshenv file for zsh(1).
#
# This file is sourced on all invocations of the shell.
# If the -f flag is present or if the NO_RCS option is
# set within this file, all other initialization files
# are skipped.
#
# This file should contain commands to set the command
# search path, plus other important environment variables.
# This file should not contain commands that produce
# output or assume the shell is attached to a tty.
#
# Global Order: zshenv, zprofile, zshrc, zlogin

export PATH="${HOME}/.local/bin:${PATH}"

# https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
# https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

# brew shellenv
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH-}"

export FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"

ulimit -n "$(ulimit -H -n)"

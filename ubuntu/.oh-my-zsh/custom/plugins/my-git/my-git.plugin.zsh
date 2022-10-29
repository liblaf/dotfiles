#!/usr/bin/zsh

function git-init() {
  bash "${ZSH_CUSTOM}/plugins/my-git/git-init.sh" "${@}"
}

function git-setup() {
  bash "${ZSH_CUSTOM}/plugins/my-git/git-setup.sh" "${@}"
}

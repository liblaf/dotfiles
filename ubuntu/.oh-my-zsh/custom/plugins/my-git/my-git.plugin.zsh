#!/usr/bin/zsh

function git-init() {
  bash "${ZSH_CUSTOM}/plugins/my-git/git-init.sh" "${@}"
}

function git-reset() {
  bash "${ZSH_CUSTOM}/plugins/my-git/git-reset.sh" "${@}"
}

function git-set-pypi() {
  bash "${ZSH_CUSTOM}/plugins/my-git/git-set-pypi.sh" "${@}"
}

function git-setup() {
  bash "${ZSH_CUSTOM}/plugins/my-git/git-setup.sh" "${@}"
}

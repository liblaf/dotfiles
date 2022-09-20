#!/usr/bin/env bash
set -o xtrace
set -o errexit
set -o nounset

cd "$(dirname "${0}")"
prefix="$(pwd)"

function setup-omz() {
  git submodule update --init --remote --depth 1 --recursive
  rm --force --recursive "${ZSH_CUSTOM:-"${ZSH:-"${HOME}/.oh-my-zsh"}/custom"}"
  cp --recursive "${prefix}/.oh-my-zsh/custom/" "${ZSH_CUSTOM:-"${ZSH:-"${HOME}/.oh-my-zsh"}/custom"}"
  cp "${prefix}/.zshrc" "${HOME}/"
  cp "${prefix}/.zprofile" "${HOME}/"
  cp "${prefix}/.p10k.zsh" "${HOME}/"
}

function setup-brew() {
  cp "${prefix}/.Brewfile" "${HOME}/"
  rm --force "${HOME}/.Brewfile.lock.json"
  if command -v brew >"/dev/null"; then
    brew bundle install --global
  fi
}

function setup-pip() {
  if command -v pip >"/dev/null"; then
    pip install --requirement "${prefix}/requirements.txt"
  fi
}

function setup-grub-theme() {
  bash "${prefix}/grub-theme/install.sh"
}

if [[ -n "${@}" ]]; then
  for sub_command in "${@}"; do
    "setup-${sub_command}"
  done
else
  for sub_command in omz brew pip grub-theme; do
    "setup-${sub_command}"
  done
fi

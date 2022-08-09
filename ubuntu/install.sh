#!/usr/bin/env bash
set -o xtrace
set -o errexit
set -o nounset

cd "$(dirname "${0}")"
prefix="$(pwd)"
git submodule update --init --depth 1 --recursive
rm --force --recursive "${ZSH_CUSTOM:-"${ZSH:-"${HOME}/.oh-my-zsh"}/custom"}"
cp --recursive "${prefix}/.oh-my-zsh/custom/" "${ZSH_CUSTOM:-"${ZSH:-"${HOME}/.oh-my-zsh"}/custom"}"
cp "${prefix}/.zshrc" "${HOME}/"
cp "${prefix}/.zprofile" "${HOME}/"
cp "${prefix}/.p10k.zsh" "${HOME}/"

# Homebrew
cp "${prefix}/.Brewfile" "${HOME}/"
brew bundle install --global

# Python
pip install --requirement "${prefix}/requirements.txt"

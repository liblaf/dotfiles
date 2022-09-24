#!/usr/bin/env bash

function update() {
  apt-update
  brew-update
  pip-update
  pnpm-update
  snap-update
}

function apt-update() {
  echo "Updating APT packages ..."
  sudo apt update
  sudo apt upgrade
}

function snap-update() {
  echo "Updating Snap packages ..."
  sudo snap refresh
}

function brew-update() {
  echo "Updating Homebrew packages ..."
  brew update
  brew upgrade
}

function pip-update() {
  echo "Updating Conda packages ..."
  conda update --all
  echo "Updating pip packages ..."
  pip list --outdated --format freeze |
    grep --invert-match '^\-e' |
    cut --delimiter='=' --fields=1 |
    xargs --max-args=1 --no-run-if-empty pip install --upgrade
}

function pnpm-update() {
  echo "Updating Node.js ..."
  pnpm env use --global lts
  echo "Updating pnpm packages ..."
  pnpm update --global
}

function clean() {
  apt-clean
  brew-clean
  cache-clean
  pip-clean
  pnpm-clean
  zsh-clean
}

function apt-clean() {
  echo "Cleaning APT ..."
  sudo apt clean
  sudo apt autoclean
  sudo apt autoremove
}

function brew-clean() {
  echo "Cleaning Homebrew ..."
  brew autoremove
  brew cleanup
}

function cache-clean() {
  echo "Cleaning cache ..."
  rm --force --recursive "${HOME}/.cache/"
}

function pip-clean() {
  echo "Cleaning python ..."
  conda clean --all
  pip cache purge
}

function pnpm-clean() {
  echo "Cleaning pnpm store ..."
  pnpm store prune
}

function zsh-clean() {
  echo "Cleaning ZSH ..."
  rm --force ${HOME}/.zcompdump*
}

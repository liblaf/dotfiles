#!/usr/bin/env bash

function u-update() {
  apt-update
  snap-update
  brew-update
  python-update
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

function python-update() {
  echo "Updating Conda packages ..."
  conda update --all
  echo "Updating pip packages ..."
  pip list --outdated --format freeze |
    grep --invert-match '^\-e' |
    cut --delimiter='=' --fields=1 |
    xargs --max-args=1 --no-run-if-empty pip install --upgrade
}

function u-clean() {
  apt-clean
  brew-clean
  cache-clean
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

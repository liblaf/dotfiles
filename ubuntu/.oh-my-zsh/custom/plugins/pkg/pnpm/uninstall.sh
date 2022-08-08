#!/usr/bin/env bash
set -o errexit
set -o nounset

rm --force "${HOME}/.czrc"
rm --force --recursive "${HOME}/.npm/"
rm --force --recursive "${PNPM_HOME}"

brew uninstall pnpm
brew uninstall node

unset PNPM_HOME

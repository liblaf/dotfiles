#!/usr/bin/bash
set -o errexit
set -o nounset

rm --force --recursive "${HOME}/.npm"
rm --force --recursive "${PNPM_HOME}"

brew uninstall pnpm
brew uninstall node

unset PNPM_HOME

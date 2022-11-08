#!/usr/bin/bash
set -o nounset

function info() {
  rich --print "[bold bright_blue]${*}"
}

function ask() {
  name="${1}"
  default="${2}"
  shift 2
  echo -e -n "\x1b[1;92m"
  echo -n "?"
  echo -e -n "\x1b[0m\x1b[1m"
  echo -n " ${*} "
  echo -e -n "\x1b[0m\x1b[90m"
  echo -n "[${default}] "
  echo -e -n "\x1b[0m\x1b[96m"
  read "${name}"
  echo -e "\x1b[0m"
}

function call() {
  info "+ ${*}"
  "${@}"
}

call git config --global init.defaultBranch main

old_user_name="$(git config --global user.name)"
if [[ -z ${old_user_name} ]]; then
  old_user_name="Qin Li"
fi
ask new_user_name "${old_user_name}" "Enter your Git username"
if [[ -n ${new_user_name} ]]; then
  call git config --global user.name "${new_user_name}"
else
  call git config --global user.name "${old_user_name}"
fi

old_user_email="$(git config --global user.email)"
if [[ -z ${old_user_email} ]]; then
  old_user_email="30631553+liblaf@users.noreply.github.com"
fi
ask new_user_email "${old_user_email}" "Enter your email address"
if [[ -n ${new_user_email} ]]; then
  call git config --global user.email "${new_user_email}"
else
  call git config --global user.email "${old_user_email}"
fi

# https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
echo "GPG secret keys:"
gpg --list-secret-keys --keyid-format=long
call git config --global commit.gpgsign true
old_user_signingkey="$(git config --global user.signingkey)"
if [[ -z ${old_user_signingkey} ]]; then
  old_user_signingkey="7A12444CF9D6DD75"
fi
ask new_user_signingkey "${old_user_signingkey}" "Enter your GPG key ID"
if [[ -n ${new_user_signingkey} ]]; then
  call git config --global user.signingkey "${new_user_signingkey}"
else
  call git config --global user.signingkey "${old_user_signingkey}"
fi

call git --no-pager config --global --list

call gh auth login
call gh auth setup-git

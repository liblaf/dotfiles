#!/usr/bin/bash
set -o nounset

git config --global init.defaultBranch main

old_user_name="$(git config --global user.name)"
if [[ -z "${old_user_name}" ]]; then
  old_user_name="Qin Li"
fi
echo -n "Enter your Git username [${old_user_name}]: "
read new_user_name
if [[ -n "${new_user_name}" ]]; then
  git config --global user.name "${new_user_name}"
else
  git config --global user.name "${old_user_name}"
fi

old_user_email="$(git config --global user.email)"
if [[ -z "${old_user_email}" ]]; then
  old_user_email="30631553+liblaf@users.noreply.github.com"
fi
echo -n "Enter your email address [${old_user_email}]: "
read new_user_email
if [[ -n "${new_user_email}" ]]; then
  git config --global user.email "${new_user_email}"
else
  git config --global user.email "${old_user_email}"
fi

# https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
echo "GPG secret keys:"
gpg --list-secret-keys --keyid-format=long
git config --global commit.gpgsign true
old_user_signingkey="$(git config --global user.signingkey)"
if [[ -z "${old_user_signingkey}" ]]; then
  old_user_signingkey="7A12444CF9D6DD75"
fi
echo -n "Enter your GPG key ID [${old_user_signingkey}]: "
read new_user_signingkey
if [[ -n "${new_user_signingkey}" ]]; then
  git config --global user.signingkey "${new_user_signingkey}"
else
  git config --global user.signingkey "${old_user_signingkey}"
fi

git config --global --list

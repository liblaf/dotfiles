#!/usr/bin/env bash

function git-config() {
  old_user_name="$(git config --global user.name)"
  echo -n "Enter your Git username [${old_user_name}]: "
  read new_user_name
  if [[ -n "${new_user_name}" ]]; then
    git config --global user.name "${new_user_name}"
  fi

  old_user_email="$(git config --global user.email)"
  echo -n "Enter your email address [${old_user_email}]: "
  read new_user_email
  if [[ -n "${new_user_email}" ]]; then
    git config --global user.email "${new_user_email}"
  fi

  # https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
  echo "GPG secret keys:"
  gpg --list-secret-keys --keyid-format=long
  old_user_signingkey="$(git config --global user.signingkey)"
  echo -n "Enter your GPG key ID [${old_user_signingkey}]: "
  read new_user_signingkey
  if [[ -n "${new_user_signingkey}" ]]; then
    git config --global commit.gpgsign true
    git config --global user.signingkey "${new_user_signingkey}"
  fi
  echo "git config list:"
  git config --global --list
}

function git-delete-tags() {
  local prefix="$(pwd)"
  if [[ -d "${prefix}/.git" ]]; then
    git pull --tags
    git tag --list | xargs --max-args=1 --no-run-if-empty git push origin --delete
    git tag --list | xargs --max-args=1 --no-run-if-empty git tag --delete
    git push --force
  else
    echo "fatal: not a git repository: .git"
  fi
}

function git-reinit() {
  local prefix="$(pwd)"
  if [[ -r "${prefix}/.git/config" ]]; then
    git-delete-tags
    cp "${prefix}/.git/config" "/tmp/tmp-git-config"
    rm --force --recursive ".git/"
    git init --initial-branch="main"
    git add "."
    git commit --gpg-sign --message="Initial commit"
    cp "/tmp/tmp-git-config" "${prefix}/.git/config"
    git push --force
  else
    echo "fatal: not a git repository: .git"
  fi
}

function git-verify() {
  local prefix="$(pwd)"
  if [[ -d "${prefix}/.git/" ]]; then
    git filter-branch --commit-filter 'git commit-tree --gpg-sign "$@";' -- --all
    git push --force
  else
    echo "fatal: not a git repository: .git"
  fi
}

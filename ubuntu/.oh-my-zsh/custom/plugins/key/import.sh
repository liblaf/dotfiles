#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function info() {
  rich --print "[bold bright_blue]${*}"
}

function success() {
  rich --print "[bold bright_green]${*}"
}

function call() {
  info "+ ${*}"
  "${@}"
}

if [[ -n ${1:-""} && -d ${1} ]]; then
  keys_home="${1}"
else
  keys_home="$(pwd)"
fi
success "Importing keys from ${keys_home} ..."

# ssh
ssh_home="${keys_home}/ssh"
success "Importing SSH keys from ${ssh_home} ..."
mkdir --parents "${HOME}/.ssh"
if [[ -r "${ssh_home}/config" ]]; then
  success "Importing SSH config ..."
  call cp "${ssh_home}/config" "${HOME}/.ssh"
  call chmod ug=rw,o=r "${HOME}/.ssh/config"
else
  success "SSH config file not found"
fi
for type in rsa dsa ecdsa ed25519; do
  if [[ -r "${ssh_home}/id_${type}" ]]; then
    success "Import SSH ${type} key ..."
    call cp "${ssh_home}/id_${type}" "${HOME}/.ssh"
    call chmod u=rw,go= "${HOME}/.ssh/id_${type}"
    call cp "${ssh_home}/id_${type}.pub" "${HOME}/.ssh"
    call chmod u=rw,go=r "${HOME}/.ssh/id_${type}.pub"
  fi
done

# gpg
gpg_home="${keys_home}/gpg"
success "Importing GPG keys from ${gpg_home} ..."
call gpg --import "${gpg_home}/secret.asc"
signing_key="$(git config user.signingKey)"
if [[ -n ${signing_key} ]]; then
  call gpg --edit-key "$(git config user.signingKey)" trust
fi

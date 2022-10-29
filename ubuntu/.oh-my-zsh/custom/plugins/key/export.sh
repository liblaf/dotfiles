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

if [[ -n "${1:-""}" ]]; then
  keys_home="${1}"
else
  keys_home="$(pwd)"
fi
success "Exporting keys to ${keys_home} ..."

# ssh
ssh_home="${keys_home}/ssh"
success "Exporting SSH keys to ${ssh_home} ..."
mkdir --parents "${ssh_home}"
if [[ -r "${HOME}/.ssh/config" ]]; then
  success "Exporting SSH config ..."
  call cp "${HOME}/.ssh/config" "${ssh_home}"
else
  success "SSH config file not found"
fi
for type in dsa ecdsa ed25519 ed25519-sk rsa; do
  if [[ -r "${HOME}/.ssh/id_${type}" ]]; then
    success "Exporting SSH ${type} key ..."
    call cp "${HOME}/.ssh/id_${type}" "${ssh_home}"
    call cp "${HOME}/.ssh/id_${type}.pub" "${ssh_home}"
  fi
done

# gpg
gpg_home="${keys_home}/gpg"
success "Exporting GPG keys to ${gpg_home} ..."
mkdir --parents "${gpg_home}"
info "+ gpg --export-secret-keys --armor"
gpg --export-secret-keys --armor |
  tee "${gpg_home}/secret.key" >/dev/null

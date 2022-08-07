#!/usr/bin/env bash

function import-keys() {
  if [[ -n "${1}" && -d "${1}" ]]; then
    local prefix="${1}"
  else
    local prefix="$(pwd)"
  fi
  echo "Importing keys from \"${prefix}\" ..."

  # ssh
  local ssh_prefix="${prefix}/ssh"
  echo "Importing SSH keys from \"${ssh_prefix}\" ..."
  mkdir --parents "${HOME}/.ssh/"
  if [[ -r "${ssh_prefix}/config" ]]; then
    echo "Importing SSH config ..."
    cp "${ssh_prefix}/config" "${HOME}/.ssh/"
    chmod ug=rw,o=r "${HOME}/.ssh/config"
  else
    echo "SSH config file not found"
  fi
  for type in rsa dsa ecdsa ed25519; do
    if [[ -r "${ssh_prefix}/id_${type}" ]]; then
      echo "Import SSH ${type} key ..."
      cp "${ssh_prefix}/id_${type}" "${HOME}/.ssh/"
      chmod u=rw,go= "${HOME}/.ssh/id_${type}"
      cp "${ssh_prefix}/id_${type}.pub" "${HOME}/.ssh/"
      chmod u=rw,go=r "${HOME}/.ssh/id_${type}.pub"
    fi
  done

  # gpg
  local gpg_prefix="${prefix}/gpg"
  echo "Importing GPG keys from \"${gpg_prefix}\" ..."
  gpg --import "${gpg_prefix}/secret.key"
}

function export-keys() {
  if [[ -n "${1}" ]]; then
    local prefix="${1}"
  else
    local prefix="$(pwd)"
  fi
  echo "Exporting keys to \"${prefix}/\" ..."

  # ssh
  echo "Exporting SSH keys to \"${ssh_prefix}\" ..."
  mkdir --parents "${ssh_prefix}/"
  if [[ -r "${HOME}/.ssh/config" ]]; then
    echo "Exporting SSH config ..."
    cp "${HOME}/.ssh/config" "${ssh_prefix}/"
  else
    echo "SSH config file not found"
  fi
  for type in dsa ecdsa ed25519 ed25519-sk rsa; do
    if [[ -r "${HOME}/.ssh/id_${type}" ]]; then
      echo "Exporting SSH ${type} key ..."
      cp "${HOME}/.ssh/id_${type}" "${ssh_prefix}/"
      cp "${HOME}/.ssh/id_${type}.pub" "${ssh_prefix}/"
    fi
  done

  # gpg
  local gpg_prefix="${prefix}/gpg"
  echo "Exporting GPG keys to \"${gpg_prefix}\" ..."
  mkdir --parents "${gpg_prefix}"
  gpg --export-secret-keys --armor |
    tee "${gpg_prefix}/secret.key" >"/dev/null"
}

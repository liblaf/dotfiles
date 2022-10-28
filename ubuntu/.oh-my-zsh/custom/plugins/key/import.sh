#!/usr/bin/bash
set -o errexit
set -o nounset

function note() {
  echo -e -n "\033[1;94m"
  echo -n "[NOTE] "
  echo -n "${@}"
  echo -e "\033[0m"
}

if [[ -n "${1:-""}" && -d "${1}" ]]; then
  keys_home="${1}"
else
  keys_home="$(pwd)"
fi
note "Importing keys from \"${keys_home}\" ..."

# ssh
ssh_home="${keys_home}/ssh"
note "Importing SSH keys from \"${ssh_home}\" ..."
mkdir --parents "${HOME}/.ssh"
if [[ -r "${ssh_home}/config" ]]; then
  note "Importing SSH config ..."
  cp "${ssh_home}/config" "${HOME}/.ssh"
  chmod ug=rw,o=r "${HOME}/.ssh/config"
else
  note "SSH config file not found"
fi
for type in rsa dsa ecdsa ed25519; do
  if [[ -r "${ssh_home}/id_${type}" ]]; then
    note "Import SSH ${type} key ..."
    cp "${ssh_home}/id_${type}" "${HOME}/.ssh"
    chmod u=rw,go= "${HOME}/.ssh/id_${type}"
    cp "${ssh_home}/id_${type}.pub" "${HOME}/.ssh"
    chmod u=rw,go=r "${HOME}/.ssh/id_${type}.pub"
  fi
done

# gpg
gpg_home="${keys_home}/gpg"
note "Importing GPG keys from \"${gpg_home}\" ..."
gpg --import "${gpg_home}/secret.key"

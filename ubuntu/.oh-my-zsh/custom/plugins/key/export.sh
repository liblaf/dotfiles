#!/usr/bin/bash
set -o errexit
set -o nounset

function note() {
  echo -e -n "\033[1;94m"
  echo -n "[NOTE] "
  echo -n "${@}"
  echo -e "\033[0m"
}

if [[ -n "${1:-""}" ]]; then
  keys_home="${1}"
else
  keys_home="$(pwd)"
fi
note "Exporting keys to \"${keys_home}/\" ..."

# ssh
ssh_home="${keys_home}/ssh"
note "Exporting SSH keys to \"${ssh_home}\" ..."
mkdir --parents "${ssh_home}"
if [[ -r "${HOME}/.ssh/config" ]]; then
  note "Exporting SSH config ..."
  cp "${HOME}/.ssh/config" "${ssh_home}"
else
  note "SSH config file not found"
fi
for type in dsa ecdsa ed25519 ed25519-sk rsa; do
  if [[ -r "${HOME}/.ssh/id_${type}" ]]; then
    note "Exporting SSH ${type} key ..."
    cp "${HOME}/.ssh/id_${type}" "${ssh_home}"
    cp "${HOME}/.ssh/id_${type}.pub" "${ssh_home}"
  fi
done

# gpg
gpg_home="${keys_home}/gpg"
note "Exporting GPG keys to \"${gpg_home}\" ..."
mkdir --parents "${gpg_home}"
gpg --export-secret-keys --armor |
  tee "${gpg_home}/secret.key" >/dev/null

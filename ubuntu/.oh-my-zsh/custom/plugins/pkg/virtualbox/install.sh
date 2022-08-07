#!/usr/bin/env bash
# https://www.virtualbox.org/wiki/Linux_Downloads
set -o errexit
set -o nounset

cat <<-EOF | sudo tee "/etc/apt/sources.list.d/virtualbox.list" >"/dev/null"
deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian jammy contrib
EOF

wget --output-document="-" "https://www.virtualbox.org/download/oracle_vbox_2016.asc" |
  sudo gpg --dearmor --yes --output "/usr/share/keyrings/oracle-virtualbox-2016.gpg"

sudo apt update
sudo apt install virtualbox-6.1

#!/usr/bin/env bash
# https://typora.io/#linux
set -o errexit
set -o nounset

# or run:
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget --output-document="-" "https://typora.io/linux/public-key.asc" |
  sudo tee "/etc/apt/trusted.gpg.d/typora.asc" >"/dev/null"

# add Typora's repository
sudo add-apt-repository "deb https://typora.io/linux ./"
sudo apt update

# install typora
sudo apt install typora

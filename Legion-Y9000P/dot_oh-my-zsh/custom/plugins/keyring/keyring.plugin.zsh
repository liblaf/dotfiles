#!/usr/bin/zsh

# https://stackoverflow.com/a/76049791
function keyring-unlock() {
  read -r -s -p "Password: " password
  eval $(echo -n ${password} | gnome-keyring-daemon --replace --unlock)
}

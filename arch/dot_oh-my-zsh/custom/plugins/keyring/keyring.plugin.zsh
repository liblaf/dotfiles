# https://stackoverflow.com/a/76049791
function keyring-unlock() {
  echo -n "[keyring] password for $USER: "
  read -r -s password
  echo
  eval $(echo -n $password | gnome-keyring-daemon --replace --unlock)
}

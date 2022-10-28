function info() {
  echo -e -n "\033[94m"
  echo -n "   [INFO] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function success() {
  echo -e -n "\033[1;92m"
  echo -n "[SUCCESS] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function warn() {
  echo -e -n "\033[1;93m"
  echo -n "[WARNING] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function error() {
  echo -e -n "\033[1;91m"
  echo -n "  [ERROR] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function exec() {
  info "${@}"
  "${@}"
}

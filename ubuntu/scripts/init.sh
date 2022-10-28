function info() {
  echo -e -n "\033[94m"
  echo -n "[$(date "+%F %T.%N")]    [INFO] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function success() {
  echo -e -n "\033[1;92m"
  echo -n "[$(date "+%F %T.%N")] [SUCCESS] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function warn() {
  echo -e -n "\033[1;93m"
  echo -n "[$(date "+%F %T.%N")] [WARNING] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function error() {
  echo -e -n "\033[1;91m"
  echo -n "[$(date "+%F %T.%N")]   [ERROR] "
  echo -n "${@}"
  echo -e "\033[0m"
}

function exec() {
  info "${@}"
  "${@}"
}

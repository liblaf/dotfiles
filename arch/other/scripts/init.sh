function has() {
  type "$@" &> /dev/null
}

function run() {
  (
    echo -e "\x1b[1;92;100m>>> $*\x1b[0m"
    "$@"
  )
  local ret=$?
  if ((ret != 0)); then
    echo -e "\x1b[1;91m\uf00d $ret >>>" "$*" "\x1b[0m" #  nf-fa-close
  fi
}

function run-safe() {
  (
    set +o errexit
    run "$@"
  )
}

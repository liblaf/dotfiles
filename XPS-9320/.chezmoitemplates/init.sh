function has() {
  command -v "${@}" > /dev/null 2>&1
}

function run() {
  (
    export PS4=$'\x1b[1;92;100m>>> '
    set -o xtrace
    "${@}"
  )
  local ret=$?
  if ((ret != 0)); then
    echo -e "\x1b[1;91m\uf00d ${ret} >>>" "${*}" "\x1b[0m" #  nf-fa-close
  fi
}

function run-safe() {
  (
    set +o errexit
    run "${@}"
  )
}

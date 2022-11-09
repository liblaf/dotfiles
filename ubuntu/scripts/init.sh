function exist() {
  command -v "${@}" > /dev/null 2>&1
}

if exist rich; then
  function info() {
    rich --print "[bold bright_blue]   [INFO] ${*}"
  }
else
  function info() {
    echo -e -n "\x1b[1;94m"
    echo -n "   [INFO] ${*}"
    echo -e "\x1b[0m"
  }
fi

if exist rich; then
  function success() {
    rich --print "[bold bright_green][SUCCESS] ${*}"
  }
else
  function success() {
    echo -e -n "\x1b[1;92m"
    echo -n "[SUCCESS] ${*}"
    echo -e "\x1b[0m"
  }
fi

if exist rich; then
  function warning() {
    rich --print "[bold bright_yellow][WARNING] ${*}"
  }
else
  function warning() {
    echo -e -n "\x1b[1;93m"
    echo -n "[WARNING] ${*}"
    echo -e "\x1b[0m"
  }
fi

if exist rich; then
  function error() {
    rich --print "[bold bright_red]  [ERROR] ${*}"
  }
else
  function error() {
    echo -e -n "\x1b[1;91m"
    echo -n "  [ERROR] ${*}"
    echo -e "\x1b[0m"
  }
fi

if exist rich; then
  function call() {
    rich --print "[bold bright_blue]+ ${*}"
    "${@}"
  }
else
  function call() {
    echo -e -n "\x1b[1;94m"
    echo -n "+ ${*}"
    echo -e "\x1b[0m"
    "${@}"
  }
fi

function copy() {
  mkdir --parents "$(realpath --canonicalize-missing "${2}/..")"
  cp --recursive "${1}" "${2}"
  success "${2} <= ${1}"
}

function info() {
  rich --print "[bold bright_blue]   [INFO] ${*}"
}

function success() {
  rich --print "[bold bright_green][SUCCESS] ${*}"
}

function warning() {
  rich --print "[bold bright_yellow][WARNING] ${*}"
}

function error() {
  rich --print "[bold bright_red]  [ERROR] ${*}"
}

function call() {
  rich --print "[bold bright_blue]+ ${*}"
  "${@}"
}

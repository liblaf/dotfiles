function upload() {
  local prefix="${PREFIX:-"${HOME}/Desktop/onedrive-personal/public/image"}"
  if [[ -f ${1} ]]; then
    local year="$(date +%Y)"
    local month="$(date +%m)"
    local day="$(date +%d)"
    local hour="$(date +%H)"
    local minute="$(date +%M)"
    local second="$(date +%S)"
    local extension="$(echo "${1}" | sed --expression="s/^[^\.]*//g")"
    local target="${prefix}/${year}/${month}/${day}/${year}-${month}-${day}-${hour}-${minute}-${second}${extension}"
    install -D --mode="u=rw,go=r" --no-target-directory --verbose "${1}" "${target}"
  else
    echo "${1} is not a file"
    false
  fi
}

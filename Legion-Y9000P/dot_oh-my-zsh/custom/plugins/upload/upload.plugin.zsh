function upload() {
  local prefix="personal:/public/img"
  if [[ -f ${1} ]]; then
    local year="$(date +%Y)"
    local month="$(date +%m)"
    local day="$(date +%d)"
    local hour="$(date +%H)"
    local minute="$(date +%M)"
    local second="$(date +%S)"
    local extension="$(echo "${1}" | sed --expression="s/^[^\.]*//g")"
    local target="${prefix}/${year}/${month}/${day}/$(date +%Y-%m-%dT%H%M%S)${extension}"
    rclone copyto "${1}" "${target}" --progress
  else
    echo "'${1}' is not a file"
    false
  fi
}

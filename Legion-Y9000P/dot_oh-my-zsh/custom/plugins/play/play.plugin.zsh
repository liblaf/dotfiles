function play() {
  local folder=${1:-"/tmp/play"}
  mkdir --parents --verbose ${folder}
  code ${folder}
}

function ssh-play() {
  local remote=${1}
  local folder=${2:-"/tmp/play"}
  ssh ${remote} mkdir --parents --verbose ${folder}
  code --folder-uri="vscode-remote://ssh-remote+${remote}${folder}"
}
compdef ssh-play=ssh

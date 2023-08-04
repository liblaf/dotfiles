function pull() {
  local remote=${1}
  local toplevel=$(git rev-parse --show-toplevel)
  if [[ -d ${toplevel} ]]; then
    echo "${remote} -> '${toplevel}'"
    rsync --info=PROGRESS2 --archive --delete --force --partial --compress --filter="dir-merge,- .gitignore" ${remote}:${toplevel}/ ${toplevel}
  else
    echo "not a git repository: '${toplevel}'"
  fi
}
compdef pull=ssh

function push() {
  local remote=${1}
  local toplevel=$(git rev-parse --show-toplevel)
  if [[ -d ${toplevel} ]]; then
    echo "'${toplevel}' -> ${remote}"
    rsync --info=PROGRESS2 --archive --delete --force --partial --compress --filter="dir-merge,- .gitignore" ${toplevel}/ ${remote}:${toplevel}
  else
    echo "not a git repository: '${toplevel}'"
  fi
}
compdef push=ssh

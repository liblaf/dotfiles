#!/usr/bin/zsh

alias rsync="rsync --info=PROGRESS2 --archive --delete --force --partial --compress"

function rsync-pull() {
  local remote=$1
  rsync $remote:$(pwd)/ $(pwd)
}
compdef rsync-pull=ssh

function rsync-push() {
  local remote=$1
  rsync $(pwd)/ $remote:$(pwd)
}
compdef rsync-push=ssh

function rsync-git-pull() {
  local remote=$1
  local toplevel=$(git rev-parse --show-toplevel)
  if [[ -d $toplevel ]]; then
    echo "$remote -> '$toplevel'"
    rsync --filter="dir-merge,- .gitignore" $remote:$toplevel/ $toplevel
  else
    return 1
  fi
}
compdef rsync-git-pull=ssh

function rsync-git-push() {
  local remote=$1
  local toplevel=$(git rev-parse --show-toplevel)
  if [[ -d $toplevel ]]; then
    echo "'$toplevel' -> $remote"
    rsync --filter="dir-merge,- .gitignore" $toplevel/ $remote:$toplevel
  else
    return 1
  fi
}
compdef rsync-git-push=ssh

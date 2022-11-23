#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

if [[ -e ${1:-""} ]]; then
  cd "${1}"
else
  cd "$(git rev-parse --show-toplevel)"
fi

repo_name="$(basename "$(pwd)")"
rm --force --recursive .git
git init
git remote add origin "https://github.com/liblaf/${repo_name}.git"
git add --all
git commit --message "initial commit"
git push --force --set-upstream origin main

#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

source scripts/init.sh

backup=/etc/apt/sources.list.save
if [[ ! -e ${backup} ]]; then
  sudo cp /etc/apt/sources.list "${backup}"
  success "Copy: /etc/apt/sources.list -> ${backup}"
fi

if grep --color "http://.*archive.ubuntu.com" /etc/apt/sources.list; then
  call sudo sed --in-place "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
fi
if grep --color "http://.*security.ubuntu.com" /etc/apt/sources.list; then
  call sudo sed --in-place "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
fi

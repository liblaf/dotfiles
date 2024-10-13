#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

ARCH_DIR=$1

function checksums() {
	pushd "$ARCH_DIR"
	test -f "$ARCH_DIR/archlinux-x86_64.iso" || return 1
	b2sum --check --ignore-missing "b2sums.txt" || return 1
	popd
}

wget --output-document="$ARCH_DIR/b2sums.txt" "https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/b2sums.txt"
if checksums; then
	exit 0
fi
wget --output-document="$ARCH_DIR/archlinux-x86_64.iso" "https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/archlinux-x86_64.iso"
checksums

ALL += apt

APT_PKGS := build-essential curl git zsh
APT_PKGS += apt-file
APT_PKGS += libfuse2 # AppImage
APT_PKGS += sntp     # NTP

.PHONY: apt
apt: scripts/apt-mirror.sh
	@ # https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	@ bash $<
	@ call sudo apt install $(APT_PKGS)

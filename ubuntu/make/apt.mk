ALL += apt

APT_PKGS := build-essential curl git zsh
APT_PKGS += sntp     # NTP
APT_PKGS += libfuse2 # AppImage

.PHONY: apt
apt: scripts/apt-mirror.sh
	@ # https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	@ bash $<
	@ call sudo apt install $(APT_PKGS)

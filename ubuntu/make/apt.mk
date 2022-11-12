ALL += apt

APT_PKGS := build-essential curl git zsh
APT_PKGS += libarchive-tools sntp
APT_PKGS += libfuse2 libffi7
.PHONY: apt
apt: apt-mirror $(addsuffix -apt, $(APT_PKGS))

.PHONY: apt-mirror
apt-mirror:
	# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	@ call sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
	@ call sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

define apt-rule =
.PHONY: $(1)-apt
$(1)-apt:
	@ if ! apt list $(1) 2>&1 | grep "\[installed\]" > /dev/null 2>&1; then call sudo apt install $(1);	fi
endef
$(foreach pkg, $(APT_PKGS), $(eval $(call apt-rule, $(pkg))))

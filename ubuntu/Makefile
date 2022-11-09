SHELL    := /usr/bin/bash --init-file $(CURDIR)/scripts/init.sh -o errexit -i
ALL      := apt brew config grub npm pip ubuntu zsh
CONDARC  := $(HOME)/.condarc
FZF      := $(HOME)/.fzf.zsh
NPMRC    := $(HOME)/.npmrc
P10K     := $(HOME)/.p10k.zsh
ZPROFILE := $(HOME)/.zprofile
ZSHRC    := $(HOME)/.zshrc

.PHONY: all
all: $(ALL)

APT_PKGS := build-essential curl git zsh
APT_PKGS += libarchive-tools sntp
APT_PKGS += libfuse2 libffi7
.PHONY: apt
apt: $(addsuffix .deb, $(APT_PKGS))

define apt-install =
.PHONY: $(1).deb
$(1).deb:
	@ call sudo apt install $(1)
endef
$(foreach pkg, $(APT_PKGS), $(eval $(call apt-install, $(pkg))))

.PHONY: brew
brew: .Brewfile
ifndef HOMEBREW_PREFIX
	@ warning \`brew\` is not installed
	@ call bash brew-install/install.sh
	@ warning You need to re-run \`make\` to install brew bundle
else
	@ call cp $< $(HOME)
	@ call brew bundle install --global --no-lock
endif

.PHONY: config
config:
	@ call cp --recursive .config $(HOME)

.PHONY: grub
grub:
	@ call sudo grub2-themes/install.sh --screen 4k

.PHONY: npm
npm: $(NPMRC)

$(NPMRC): .npmrc
	@ call cp $< $(HOME)

.PHONY: pip
pip: $(CONDARC)
	@ call python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
	@ call pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

$(CONDARC): .condarc
	@ call cp $^ $@

.PHONY: ubuntu
ubuntu:
	# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	@ call sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
	@ call sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

.PHONY: zsh
zsh: $(FZF) $(P10K) $(ZPROFILE) $(ZSHRC)
ifndef ZSH
	@ warning \`zsh\` is not installed
	@ call REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git bash ohmyzsh/tools/install.sh
	@ git -C $(HOME)/.oh-my-zsh remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
	@ git -C $(HOME)/.oh-my-zsh pull
	@ warning You need to re-run \`make\` to install ohmyzsh
else
	@ call rm --force --recursive $(ZSH_CUSTOM)
	@ call cp --recursive .oh-my-zsh/custom $(ZSH_CUSTOM)
endif

$(FZF)      : .fzf.zsh
$(P10K)     : .p10k.zsh
$(ZPROFILE) : .zprofile
$(ZSHRC)    : .zshrc
$(FZF) $(P10K) $(ZPROFILE) $(ZSHRC):
	@ call cp $^ $@

.PHONY: gitmodules
gitmodules:
	@ call git submodule update --init --remote --depth 1 --recursive

SHELL    := /usr/bin/bash --init-file $(CURDIR)/scripts/init.sh -i
ALL      := brew conda grub pip ubuntu zsh
CONDA    := $(HOME)/.condarc
FZF      := $(HOME)/.fzf.zsh
P10K     := $(HOME)/.p10k.zsh
ZPROFILE := $(HOME)/.zprofile
ZSHRC    := $(HOME)/.zshrc

.PHONY: all
all: $(ALL)

.PHONY: brew
brew: .Brewfile
ifndef HOMEBREW_PREFIX
	@ warn \`brew\` is not installed
	@ exec bash brew-install/install.sh
	@ warn You need to re-run \`make\` to install brew bundle
else
	@ exec cp $< $(HOME)
	@ exec brew bundle install --global --no-lock
endif

.PHONY: conda
conda: $(CONDA)

$(CONDA): .condarc
	@ exec cp $^ $@

.PHONY: grub
grub:
	@ exec sudo grub2-themes/install.sh --screen 4k

.PHONY: pip
pip:
	@ exec python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
	@ exec pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

.PHONY: ubuntu
ubuntu:
	# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	@ exec sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
	@ exec sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

.PHONY: zsh
zsh: $(FZF) $(P10K) $(ZPROFILE) $(ZSHRC)
ifndef ZSH
	@ warn \`zsh\` is not installed
	@ exec REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git bash ohmyzsh/tools/install.sh
	@ git -C $(HOME)/.oh-my-zsh remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
	@ git -C $(HOME)/.oh-my-zsh pull
	@ warn You need to re-run \`make\` to install ohmyzsh
else
	@ exec rm --force --recursive $(ZSH_CUSTOM)
	@ exec cp --recursive .oh-my-zsh/custom $(ZSH_CUSTOM)
endif

$(FZF)      : .fzf.zsh
$(P10K)     : .p10k.zsh
$(ZPROFILE) : .zprofile
$(ZSHRC)    : .zshrc
	@ exec cp $^ $@

.PHONY: gitmodules
gitmodules:
	@ exec git submodule update --init --remote --depth 1 --recursive

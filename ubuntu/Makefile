install: brew conda config fzf grub ohmyzsh pip ubuntu

git-submodules:
	git submodule update --init --remote --depth 1 --recursive

brew: .Brewfile
ifndef HOMEBREW_PREFIX
	bash brew-install/install.sh
endif
	cp $< $(HOME)/
	brew bundle install --global

conda: .condarc
	cp $^ $(HOME)/

config: | .config
	cp --recursive $| $(HOME)/

fzf: .fzf.zsh
	cp $^ $(HOME)/

grub: git-submodules | grub2-themes
	sudo $|/install.sh --screen 4k

ohmyzsh: git-submodules .p10k.zsh .zprofile .zshrc | .oh-my-zsh/
ifndef ZSH
	REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git sh ohmyzsh/tools/install.sh
	bash $|/custom/plugins/pkg/fonts/install.sh
	git -C $$ZSH remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
	git -C $$ZSH pull
endif
	cp --recursive $| $(HOME)/
	cp .p10k.zsh $(HOME)/
	cp .zprofile $(HOME)/
	cp .zshrc $(HOME)/

pip:
	python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
	pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

ubuntu:
	# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
	sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

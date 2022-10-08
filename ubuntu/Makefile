install: brew conda config fzf grub ohmyzsh pip ubuntu

git-submodules:
	git submodule update --init --remote --depth 1 --recursive

brew: .Brewfile
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
	# cd grub-theme/argon-grub-theme/ && sudo bash install.sh --install --background dusk --resolution 4k --fontsize 32 --help-label

ohmyzsh: git-submodules .zprofile .zshrc .p10k.zsh | .oh-my-zsh/
	cp .zprofile $(HOME)/
	cp .zshrc $(HOME)/
	cp .p10k.zsh $(HOME)/
	cp --recursive .oh-my-zsh/ $(HOME)/

pip:
	python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip
	pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

ubuntu:
	# https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
	sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
	sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

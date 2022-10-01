install: brew conda fzf grub oh-my-zsh

git-modules:
	git submodule update --init --remote --depth 1 --recursive

oh-my-zsh: git-modules .zprofile .zshrc .p10k.zsh | .oh-my-zsh/
	cp .zprofile $(HOME)/
	cp .zshrc $(HOME)/
	cp .p10k.zsh $(HOME)/
	cp --recursive .oh-my-zsh/ $(HOME)/

brew: .Brewfile
	cp $< $(HOME)/
	brew bundle install --global

grub: git-modules
	cd grub-theme/argon-grub-theme/ && sudo bash install.sh --install --background Dusk --resolution 4k --fontsize 32 --help-label

conda: .condarc
	cp $^ $(HOME)/

fzf: .fzf.zsh
	cp $^ $(HOME)/

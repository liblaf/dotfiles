ALL += zsh

FZF      := $(HOME)/.fzf.zsh
P10K     := $(HOME)/.p10k.zsh
ZPROFILE := $(HOME)/.zprofile
ZSHRC    := $(HOME)/.zshrc

.PHONY: zsh
ifndef ZSH
zsh: ohmyzsh/tools/install.sh
	@ warning '`zsh` is not installed'
	@ call REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git bash ohmyzsh/tools/install.sh
	@ call git -C $(HOME)/.oh-my-zsh remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
	@ call git -C $(HOME)/.oh-my-zsh pull
	@ tip 'You need to re-run `make` to install ohmyzsh'
else
zsh: $(FZF) $(P10K) $(ZPROFILE) $(ZSHRC)
	@ call rm --force --recursive $(ZSH_CUSTOM)
	@ call cp --recursive .oh-my-zsh/custom $(ZSH_CUSTOM)
endif

$(FZF)     : .fzf.zsh
$(P10K)    : .p10k.zsh
$(ZPROFILE): .zprofile
$(ZSHRC)   : .zshrc
$(FZF) $(P10K) $(ZPROFILE) $(ZSHRC):
	@ copy $< $@

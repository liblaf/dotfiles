ALL += zsh

P10K  := $(HOME)/.p10k.zsh
ZSHRC := $(HOME)/.zshrc

.PHONY: zsh
zsh: $(P10K) $(ZSHRC)
	@ call rm --force --recursive $(ZSH_CUSTOM)
	@ call cp --recursive .oh-my-zsh/custom $(ZSH_CUSTOM)

$(P10K)  : .p10k.zsh
$(ZSHRC) : .zshrc
$(P10K) $(ZSHRC):
	@ copy $< $@

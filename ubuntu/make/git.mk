ALL += git

GITCONFIG := $(HOME)/.gitconfig

.PHONY: git
git: $(GITCONFIG)
	@ call gh auth setup-git

$(GITCONFIG): .gitconfig
	@ copy $< $@

ALL += brew

BREWFILE := $(HOME)/.Brewfile

.PHONY: brew
ifndef HOMEBREW_PREFIX
brew: brew-install/install.sh
	@ warning '`brew` is not installed'
	@ call bash $<
	@ tip 'You need to re-run `make` to install brew bundle'
else
brew: $(BREWFILE)
endif

$(BREWFILE): .Brewfile
	@ copy $< $@
	@ call brew bundle install --global --no-lock

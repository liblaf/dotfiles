ALL += brew

BREWFILE := .Brewfile

.PHONY: brew
brew: $(BREWFILE)
	@ call brew bundle install --file $< --verbose --no-lock

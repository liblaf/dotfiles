ALL += npm

NPMRC := $(HOME)/.npmrc

.PHONY: npm
npm: $(NPMRC)

$(NPMRC): .npmrc
	@ copy $< $@

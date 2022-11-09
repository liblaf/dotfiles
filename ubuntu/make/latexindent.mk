ALL += latexindent

INDENTCONFIG := $(HOME)/.indentconfig.yaml
SETTINGS     := $(HOME)/.config/latexindent/settings.yaml

.PHONY: latexindent
latexindent: $(INDENTCONFIG) $(SETTINGS)

$(INDENTCONFIG): .indentconfig.yaml
$(SETTINGS)    : .config/latexindent/settings.yaml
$(INDENTCONFIG) $(SETTINGS):
	@ copy $< $@

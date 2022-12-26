ALL += templates

.PHONY: templates
templates: | Templates
	@ copy $| $(HOME)

SHELL := /usr/bin/bash --init-file $(CURDIR)/scripts/init.sh -i
ALL   :=

include make/*.mk

.DEFAULT_GOAL := all
.PHONY: all
all: $(ALL)

.PHONY: list
list:
	@ echo $(ALL) | sed 's@\s\+@\n@g' | sort | pr --columns 4 --omit-header --omit-pagination --width 80

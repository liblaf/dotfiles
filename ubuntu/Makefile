SHELL       := /bin/bash scripts/exec.sh
.SHELLFLAGS :=
ALL         :=

include make/*.mk

.DEFAULT_GOAL := all
.PHONY: all
all: $(ALL)

.PHONY: list
list:
	@ echo $(ALL) | sed 's@\s\+@\n@g' | sort | pr --columns 4 --omit-header --omit-pagination

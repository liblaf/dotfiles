ALL += pip

CONDARC  := $(HOME)/.config/conda/.condarc
PIP_CONF := $(HOME)/.config/pip/pip.conf

.PHONY: pip
pip: $(CONDARC) $(PIP_CONF)

$(CONDARC) : .config/conda/.condarc
$(PIP_CONF): .config/pip/pip.conf
$(CONDARC) $(PIP_CONF):
	@ copy $< $@

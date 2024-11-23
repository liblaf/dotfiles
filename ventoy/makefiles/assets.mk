DEST_DIR ?= $(error DEST_DIR is not set)

ASSEET_LIST += $(DEST_DIR)/proxy-on.sh

.PHONY: assets
assets: $(ASSEET_LIST)

$(DEST_DIR)/proxy-on.sh: assets/proxy-on.sh.tmpl
	@ mkdir --parents --verbose "$(@D)"
	@ chezmoi execute-template < "$<" > "$@"

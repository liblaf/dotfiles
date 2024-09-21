DEST_DIR    ?= $(error DEST_DIR is not set)
SINGBOX_DIR := $(DEST_DIR)/sing-box

.PHONY: sing-box
sing-box: $(SINGBOX_DIR)/sing-box $(SINGBOX_DIR)/config.json

$(SINGBOX_DIR)/sing-box: /usr/bin/sing-box
	@ install -D --no-target-directory --verbose "$<" "$@"

$(SINGBOX_DIR)/config.json: /etc/sing-box/config.json
	@ install -D --mode="u=rw,go=r" --no-target-directory --verbose "$<" "$@"

DEST_DIR    ?= $(error DEST_DIR is not set)
SINGBOX_DIR := $(DEST_DIR)/sing-box

.PHONY: sing-box
sing-box: $(SINGBOX_DIR)/sing-box $(SINGBOX_DIR)/config.json

$(SINGBOX_DIR)/sing-box: $(SINGBOX_DIR)/sing-box-linux-amd64.tar.gz
	@ mkdir --parents --verbose "$(@D)"
	tar --extract --file "$<" --directory "$(@D)"
	@ install -D --no-target-directory --verbose "$(@D)"/sing-box-*-linux-amd64/sing-box "$@"
	@ $(RM) --recursive "$(@D)"/sing-box-*-linux-amd64

$(SINGBOX_DIR)/sing-box-linux-amd64.tar.gz:
	@ mkdir --parents --verbose "$(@D)"
	gh release --repo "SagerNet/sing-box" download --clobber --output "$@" --pattern 'sing-box-*-linux-amd64.tar.gz'

$(SINGBOX_DIR)/config.json: /etc/sing-box/config.json
	@ install -D --mode="u=rw,go=r" --no-target-directory --verbose "$<" "$@"

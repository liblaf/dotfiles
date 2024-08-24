DEST_DIR ?= $(error DEST_DIR is not set)
ARCH_DIR := $(DEST_DIR)/arch

.PHONY: arch
arch: $(ARCH_DIR)/archlinux-x86_64.iso

$(ARCH_DIR)/archlinux-x86_64.iso: scripts/arch/download.sh
	@ mkdir --parents --verbose "$(@D)"
	bash "$<" "$(@D)"

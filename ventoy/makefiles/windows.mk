DEST_DIR ?= $(error DEST_DIR is not set)
WIN_DIR  := $(DEST_DIR)/windows

.PHONY: windows
windows: $(WIN_DIR)/win11x64.iso

$(WIN_DIR)/%.iso: $(WIN_DIR)/Mido.sh
	@ mkdir --parents --verbose "$(@D)"
	@- bash "$<" "$*"

.PHONY: $(WIN_DIR)/Mido.sh
$(WIN_DIR)/Mido.sh:
	@ mkdir --parents --verbose "$(@D)"
	wget --output-document="$@" "https://raw.githubusercontent.com/ElliotKillick/Mido/main/Mido.sh"

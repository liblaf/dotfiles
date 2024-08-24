DEVICE ?= $(error DEVICE is not set)

ventoy-install:
	sudo ventoy -I "$(DEVICE)"
	systemctl --user restart "gvfs-udisks2-volume-monitor.service"

ventoy-update:
	sudo ventoy -u "$(DEVICE)"
	systemctl --user restart "gvfs-udisks2-volume-monitor.service"

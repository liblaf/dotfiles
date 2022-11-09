ALL += rclone

DRIVE   := $(HOME)/.config/systemd/user/drive.service
DRIVE_P := $(HOME)/.config/systemd/user/drive-p.service

.PHONY: rclone
rclone: $(DRIVE) $(DRIVE_P)

$(DRIVE)  : .config/systemd/user/drive.service
$(DRIVE_P): .config/systemd/user/drive-p.service
$(DRIVE) $(DRIVE_P):
	@ copy $< $@

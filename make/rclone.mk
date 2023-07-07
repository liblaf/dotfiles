SCRIPTS := $(CURDIR)/scripts

rclone: $(SCRIPTS)/setup-rclone.sh bw
	bash $<

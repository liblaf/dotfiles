SCRIPTS := $(CURDIR)/scripts

rclone: $(SCRIPTS)/rclone.sh
	bash $<

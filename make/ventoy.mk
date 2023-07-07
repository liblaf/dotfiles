DEVICE     ?= /dev/sda
MOUNTPOINT ?= /run/media/$(USER)/Ventoy

VENTOY_FILE_LIST += $(MOUNTPOINT)/archlinux-x86_64.iso
VENTOY_FILE_LIST += $(MOUNTPOINT)/Fido.ps1
VENTOY_FILE_LIST += $(MOUNTPOINT)/KMS-Cangshui.net.bat

ventoy: $(VENTOY_FILE_LIST)

ventoy-install:
	sudo ventoy -i -u $(DEVICE)

#####################
# Auxiliary Targets #
#####################

$(MOUNTPOINT)/archlinux-x86_64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/Fido.ps1:
	wget --output-document=$@ https://github.com/pbatard/Fido/raw/master/$(@F)

$(MOUNTPOINT)/KMS-Cangshui.net.bat:
	wget --output-document=$@ https://kms.cangshui.net/kms/$(@F)

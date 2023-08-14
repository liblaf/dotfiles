DEVICE     ?= /dev/sda
MOUNTPOINT ?= /run/media/$(USER)/Ventoy

UBUNTU_VERSION ?= 22.04.2

VENTOY_FILE_LIST += $(MOUNTPOINT)/archlinux-x86_64.iso $(MOUNTPOINT)/b2sums.txt
VENTOY_FILE_LIST += $(MOUNTPOINT)/Fido.ps1
VENTOY_FILE_LIST += $(MOUNTPOINT)/KMS-Cangshui.net.bat
# VENTOY_FILE_LIST += $(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso

ventoy: verify $(VENTOY_FILE_LIST)

ventoy-install:
	sudo ventoy -i -u $(DEVICE)

verify: $(MOUNTPOINT)/b2sums.txt $(MOUNTPOINT)/archlinux-x86_64.iso
	cd $(<D) && b2sum --check --ignore-missing $<

#####################
# Auxiliary Targets #
#####################

$(MOUNTPOINT)/archlinux-x86_64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/b2sums.txt:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/Fido.ps1:
	wget --output-document=$@ https://github.com/pbatard/Fido/raw/master/$(@F)

$(MOUNTPOINT)/KMS-Cangshui.net.bat:
	wget --output-document=$@ https://kms.cangshui.net/kms/$(@F)

$(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/$(UBUNTU_VERSION)/$(@F)

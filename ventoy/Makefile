LIVE_INJECTION_VERSION := 1.0
UBUNTU_VERSION         := 22.04.3

DEVICE         := /dev/sda
MOUNTPOINT     := /run/media/$(USER)/Ventoy
TMP            := /tmp
LIVE_INJECTION := $(TMP)/live-injection-$(LIVE_INJECTION_VERSION)

VENTOY_FILE_LIST += $(MOUNTPOINT)/archlinux-x86_64.iso
VENTOY_FILE_LIST += $(MOUNTPOINT)/live_injection.tar.gz
VENTOY_FILE_LIST += $(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso
VENTOY_FILE_LIST += $(MOUNTPOINT)/ventoy/ventoy.json

all: ventoy

clean:
	@ rm --force --recursive --verbose $(LIVE_INJECTION)
	@ rm --force --recursive --verbose $(VENTOY_FILE_LIST)
	@ rm --force --verbose $(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz

ventoy: verify $(VENTOY_FILE_LIST)

ventoy-force:
	sudo ventoy -I $(DEVICE)
	systemctl --user restart gvfs-udisks2-volume-monitor.service

ventoy-install:
	sudo ventoy -i -u $(DEVICE)

verify: verify-arch verify-ubuntu

###############
# Auxiliaries #
###############

$(MOUNTPOINT)/archlinux-x86_64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/$(UBUNTU_VERSION)/$(@F)

$(MOUNTPOINT)/ventoy/ventoy.json: ventoy.json
	install -D --mode="u=rw,go=r" --no-target-directory --verbose $< $@

##################
# Live Injection #
##################

SYSROOT              := $(LIVE_INJECTION)/sysroot
LIVE_INJECTION_FILES += $(SYSROOT)/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf

$(LIVE_INJECTION)/live_injection.tar.gz: $(LIVE_INJECTION)/pack.sh $(LIVE_INJECTION_FILES)
	cd $(<D) && bash $<

$(LIVE_INJECTION)/pack.sh: $(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz
	tar --extract --file=$< --directory=$(TMP)

$(MOUNTPOINT)/live_injection.tar.gz: $(LIVE_INJECTION)/live_injection.tar.gz
	@ install -D --mode="u=rw,go=r" --no-target-directory --verbose $< $@

$(SYSROOT)/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf: sysroot/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf.tmpl
	@ mkdir --parents --verbose $(@D)
	chezmoi execute-template <$< >$@

$(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz:
	wget --output-document=$@ https://github.com/ventoy/LiveInjection/releases/latest/download/$(@F)

##########
# Verify #
##########

verify-arch: $(MOUNTPOINT)/b2sums.txt
	cd $(<D) && b2sum --check --ignore-missing $<

verify-ubuntu: $(MOUNTPOINT)/SHA256SUMS
	cd $(<D) && sha256sum --check --ignore-missing --ignore-missing $<

$(MOUNTPOINT)/b2sums.txt: $(MOUNTPOINT)/archlinux-x86_64.iso
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/SHA256SUMS: $(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/$(UBUNTU_VERSION)/$(@F)

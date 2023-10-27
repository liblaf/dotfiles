CLASH_FOR_WINDOWS_VERSION != gh release --repo=Fndroid/clash_for_windows_pkg list --exclude-drafts --exclude-pre-releases --limit=1 | cut --fields=3
CLASH_PREMIUM_VERSION     := 2023.08.17
LIVE_INJECTION_VERSION    := 1.0
UBUNTU_VERSION            := 22.04.3

DEVICE         := /dev/sda
MOUNTPOINT     := /run/media/$(USER)/Ventoy
TMP            := /tmp
LIVE_INJECTION := $(TMP)/live-injection-$(LIVE_INJECTION_VERSION)

VENTOY_FILE_LIST += $(MOUNTPOINT)/archlinux-x86_64.iso $(MOUNTPOINT)/b2sums.txt
VENTOY_FILE_LIST += $(MOUNTPOINT)/clash-linux-amd64-v3-$(CLASH_PREMIUM_VERSION)
VENTOY_FILE_LIST += $(MOUNTPOINT)/clash/config.yaml
VENTOY_FILE_LIST += $(MOUNTPOINT)/Fido.ps1
VENTOY_FILE_LIST += $(MOUNTPOINT)/live_injection.tar.gz
# VENTOY_FILE_LIST += $(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso
VENTOY_FILE_LIST += $(MOUNTPOINT)/ventoy/ventoy.json

all: ventoy

clean:
	@ $(RM) --recursive --verbose $(LIVE_INJECTION)
	@ $(RM) --recursive --verbose $(VENTOY_FILE_LIST)
	@ $(RM) --verbose $(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz

ventoy: verify $(VENTOY_FILE_LIST)

ventoy-force:
	sudo ventoy -I $(DEVICE)
	systemctl --user restart gvfs-udisks2-volume-monitor.service

ventoy-install:
	sudo ventoy -i -u $(DEVICE)

verify: $(MOUNTPOINT)/b2sums.txt $(MOUNTPOINT)/archlinux-x86_64.iso
	cd $(<D) && b2sum --check --ignore-missing $<

###############
# Auxiliaries #
###############

$(MOUNTPOINT)/archlinux-x86_64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/b2sums.txt:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/archlinux/iso/latest/$(@F)

$(MOUNTPOINT)/clash-linux-amd64-v3-$(CLASH_PREMIUM_VERSION): $(TMP)/clash-linux-amd64-v3-$(CLASH_PREMIUM_VERSION).gz
	gunzip --stdout --keep --verbose $< > $@
	@ chmod --verbose u=rwx,go=rx $@

$(MOUNTPOINT)/clash/config.yaml: $(HOME)/.config/clash/config.yaml
	@ install -D --mode="u=rw,go=r" --no-target-directory --verbose $< $@

$(MOUNTPOINT)/Fido.ps1:
	wget --output-document=$@ https://github.com/pbatard/Fido/raw/master/$(@F)

$(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/$(UBUNTU_VERSION)/$(@F)

$(MOUNTPOINT)/ventoy/ventoy.json: ventoy.json
	install -D --mode="u=rw,go=r" --no-target-directory --verbose $< $@

$(TMP)/clash-linux-amd64-v3-$(CLASH_PREMIUM_VERSION).gz:
	wget --output-document=$@ https://github.com/Dreamacro/clash/releases/download/premium/$(@F)

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
	chezmoi execute-template < $< > $@

$(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz:
	wget --output-document=$@ https://github.com/ventoy/LiveInjection/releases/latest/download/$(@F)

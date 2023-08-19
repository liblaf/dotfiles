DEVICE     ?= /dev/sda
MOUNTPOINT ?= /run/media/$(USER)/Ventoy
TMP        := /tmp

CLASH_FOR_WINDOWS_VERSION != gh release --repo=Fndroid/clash_for_windows_pkg list --exclude-drafts --exclude-pre-releases --limit=1 | cut --fields=3
LIVE_INJECTION_VERSION    := 1.0
UBUNTU_VERSION            ?= 22.04.3

VENTOY_FILE_LIST += $(MOUNTPOINT)/archlinux-x86_64.iso $(MOUNTPOINT)/b2sums.txt
VENTOY_FILE_LIST += $(MOUNTPOINT)/clash-subscription.txt
VENTOY_FILE_LIST += $(MOUNTPOINT)/Clash.for.Windows-$(CLASH_FOR_WINDOWS_VERSION)-x64-linux.tar.gz
VENTOY_FILE_LIST += $(MOUNTPOINT)/Clash.for.Windows.Setup.$(CLASH_FOR_WINDOWS_VERSION).exe
VENTOY_FILE_LIST += $(MOUNTPOINT)/Fido.ps1
VENTOY_FILE_LIST += $(MOUNTPOINT)/KMS-Cangshui.net.bat $(MOUNTPOINT)/tcping.exe
VENTOY_FILE_LIST += $(MOUNTPOINT)/live_injection.tar.gz
# VENTOY_FILE_LIST += $(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso
VENTOY_FILE_LIST += $(MOUNTPOINT)/ventoy/ventoy.json

LIVE_INJECTION := $(TMP)/live-injection-$(LIVE_INJECTION_VERSION)

all: ventoy

clean:
	@ $(RM) --recursive --verbose $(LIVE_INJECTION)
	@ $(RM) --recursive --verbose $(VENTOY_FILE_LIST)
	@ $(RM) --verbose $(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz

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

$(MOUNTPOINT)/clash-subscription.txt: $(HOME)/.config/clash/profiles/list.yml
	dasel --file=$< --selector="files.all().filter(url).url" > $@

$(MOUNTPOINT)/Clash.for.Windows-$(CLASH_FOR_WINDOWS_VERSION)-x64-linux.tar.gz:
	wget --output-document=$@ https://github.com/Fndroid/clash_for_windows_pkg/releases/download/$(CLASH_FOR_WINDOWS_VERSION)/$(@F)

$(MOUNTPOINT)/Clash.for.Windows.Setup.$(CLASH_FOR_WINDOWS_VERSION).exe:
	wget --output-document=$@ https://github.com/Fndroid/clash_for_windows_pkg/releases/download/$(CLASH_FOR_WINDOWS_VERSION)/$(@F)

$(MOUNTPOINT)/Fido.ps1:
	wget --output-document=$@ https://github.com/pbatard/Fido/raw/master/$(@F)

$(MOUNTPOINT)/KMS-Cangshui.net.bat:
	wget --output-document=$@ https://kms.cangshui.net/kms/$(@F)

$(MOUNTPOINT)/tcping.exe:
	wget --output-document=$@ https://cangshui.net/-otherweb/kms/$(@F)

$(MOUNTPOINT)/ubuntu-$(UBUNTU_VERSION)-desktop-amd64.iso:
	wget --output-document=$@ https://mirrors.tuna.tsinghua.edu.cn/ubuntu-releases/$(UBUNTU_VERSION)/$(@F)

$(MOUNTPOINT)/ventoy/ventoy.json: $(CURDIR)/ventoy/ventoy.json
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
	install -D --mode="u=rw,go=r" --no-target-directory --verbose $< $@

$(SYSROOT)/etc/wpa_supplicant:
	@ mkdir --parents --verbose $@

TSINGHUA_SECURE_USERNAME != bw get username 802.1X
TSINGHUA_SECURE_PASSWORD != bw get password 802.1X
$(SYSROOT)/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf: $(CURDIR)/ventoy/sysroot/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf | $(SYSROOT)/etc/wpa_supplicant
	sed --expression="s/\"username\"/\"$(TSINGHUA_SECURE_USERNAME)\"/" \
	  --expression="s/\"password\"/\"$(TSINGHUA_SECURE_PASSWORD)\"/" \
	  $< > $@

$(TMP)/live-injection-$(LIVE_INJECTION_VERSION).tar.gz:
	wget --output-document=$@ https://github.com/ventoy/LiveInjection/releases/latest/download/$(@F)

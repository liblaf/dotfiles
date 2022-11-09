ALL += grub

.PHONY: grub
grub:
	@ call sudo grub2-themes/install.sh --screen 4k

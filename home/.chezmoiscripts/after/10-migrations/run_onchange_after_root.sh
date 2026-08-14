#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo rm --force --verbose \
  '/etc/mkinitcpio.conf.d/99-nvidia.conf' \
  '/etc/modprobe.d/99-nvidia.conf' \
  '/etc/pacman.d/hooks/99-nvidia-flatpak.hook' \
  '/etc/security/limits.d/99-limits.conf' \
  '/etc/security/limits.d/99-recommendations.conf' \
  '/etc/ssh/sshd_config.d/99-custom.conf' \
  '/etc/sudoers.d/99_env_keep' \
  '/etc/sudoers.d/99_nopasswd' \
  '/etc/sysctl.d/99-kernel-panic.conf' \
  '/etc/systemd/journald.conf.d/99-journal-size.conf' \
  '/etc/systemd/logind.conf.d/99-acpi.conf' \
  '/etc/systemd/resolved.conf.d/99-dnssec.conf' \
  '/etc/systemd/system.conf.d/99-limits.conf' \
  '/etc/systemd/system/gdm.service.d/99-override.conf' \
  '/etc/systemd/timesyncd.conf.d/99-local.conf' \
  '/etc/systemd/user.conf.d/99-limits.conf' \
  '/etc/ufw/applications.d/z-custom' \
  '/etc/yaycache-hook.conf' \
  '/usr/local/bin/grub-update' \
  '/usr/local/bin/mihomo' \
  '/usr/local/bin/paraview' \
  '/usr/local/lib/rate-mirrors-wrapper.py' \
  '/usr/local/share/libalpm/scripts/99-nvidia-flatpak.sh'

sudo rm --force --recursive --verbose \
  '/etc/pacman.d/mirrors/'

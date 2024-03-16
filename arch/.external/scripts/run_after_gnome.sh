#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

gsettings set com.github.libpinyin.ibus-libpinyin.libpinyin enable-cloud-input true
gsettings set com.github.libpinyin.ibus-libpinyin.libpinyin init-full-punct false
gsettings set com.github.libpinyin.ibus-libpinyin.libpinyin lookup-table-page-size 10
gsettings set org.gnome.desktop.a11y.applications screen-keyboard-enabled false
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.datetime automatic-timezone false
gsettings set org.gnome.desktop.input-sources sources '[("xkb", "us"), ("ibus", "libpinyin")]'
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface document-font-name 'Noto Sans 11'
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface locate-pointer true
gsettings set org.gnome.desktop.interface monospace-font-name 'Noto Sans Mono 10'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.privacy old-files-age 30
gsettings set org.gnome.desktop.privacy recent-files-max-age 30
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Noto Sans Bold 11'
gsettings set org.gnome.Evince.Default continuous true
gsettings set org.gnome.Evince.Default dual-page true
gsettings set org.gnome.Evince.Default dual-page-odd-left true
gsettings set org.gnome.Evince.Default enable-spellchecking true
gsettings set org.gnome.Evince.Default inverted-colors true
gsettings set org.gnome.Evince.Default sizing-mode 'automatic'
gsettings set org.gnome.mutter.keybindings toggle-tiled-left '[]'
gsettings set org.gnome.mutter.keybindings toggle-tiled-right '[]'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 900
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type suspend
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell favorite-apps '["microsoft-edge.desktop", "org.gnome.Nautilus.desktop", "org.wezfurlong.wezterm.desktop", "code.desktop"]'
gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock isolate-locations false
gsettings set org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'DYNAMIC'
gsettings set org.gnome.shell.extensions.vitals fixed-widths false
gsettings set org.gnome.shell.extensions.vitals hot-sensors '["_processor_usage_", "_memory_usage_", "__network-rx_max__", "__network-tx_max__", "__temperature_max__"]'

extensions=(
  apps-menu@gnome-shell-extensions.gcampax.github.com
  drive-menu@gnome-shell-extensions.gcampax.github.com
  places-menu@gnome-shell-extensions.gcampax.github.com
  screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com

  # paperwm@paperwm.github.com
  appindicatorsupport@rgcjonas.gmail.com
  dash-to-dock@micxgx.gmail.com
  Vitals@CoreCoding.com
)

for extension in "${extensions[@]}"; do
  gnome-extensions enable "$extension"
done

# Arch Linux

## fwupd

```shell
fwupdmgr get-devices --assume-yes # display all devices detected by fwupd
fwupdmgr refresh --assume-yes # download the latest metadata from LVFS
fwupdmgr get-updates --assume-yes # list updates available for any devices on the system
fwupdmgr update --assume-yes # install updates
```

## ibus-libpinyin

import `~/.local/chezmoi/dict.txt` as user dictionary

## pacman

### Removing unused packages (orphans)[^1]

[^1]: [pacman/Tips and tricks - ArchWiki](<https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans)>)

```shell
yay --query --deps --quiet --unrequired | yay --remove --nosave --recursive -
```

## 0.1.2 (2022-10-30)

### Fix

- **zsh/update**: auto update snap
- **zsh/clean**: fix glob error

## 0.1.1 (2022-10-30)

### Fix

- **brew**: remove vim

## 0.1.0 (2022-10-30)

### Feat

- big changes
- **zsh/pkg**: add zotero
- add plugin argcomplete
- add fonts
- add vscode extensions
- update grub theme
- add pkg `docker`
- **pkg**: add pkg `wemeet`
- add `conda` dotfiles
- add `fzf` dotfiles
- **pkg**: support `copy-prebuilt` for NDK management
- **proxy**: change function name
- support partial setup
- **grub-theme**: add `grub-theme`
- **plugins**: add plugin `wakatime`
- **ialias**: add plugin `ialias`
- **pkg**: add `ndk/doctor.sh`
- **brew**: update `.Brewfile`
- **update**: add more update and clean utils
- **ubuntu**: add `requirements.txt`
- **pkg**: install additional packages along with `pnpm`
- **git.plugin**: add `cz` function
- **.brewfile**: remove `most` package
- **ubuntu**: update .Brewfile
- **ubuntu**: add Homebrew global bundle
- **ubuntu**: use gitignore plugin
- **ubuntu**: add clash-for-windows pkg
- **ubuntu**: add .p10k.zsh
- **ubuntu**: add pkg plugin
- **ubuntu**: add update plugin
- **ubuntu**: add perms plugin
- **ubuntu**: add ntp plugin
- **ubuntu**: add key plugin
- **ubuntu**: add gpg plugin
- **ubuntu**: add git plugin
- **ubuntu**: add color plugin
- **ubuntu**: add proxy plugin

### Fix

- **zsh/my-git**: install pre-commit before commits
- **zsh/pkg**: fix list cmd
- **zsh**: fix conda init
- **zsh**: remove vscode plugin black-formatter
- **zsh**: use strict mode
- **zsh**: replace `mv` with function `replace()`
- **zsh**: pkg typora
- **zsh**: desktop entry creation
- **brew**: update
- **zsh**: update plugin `pkg`
- **zsh**: link `adb`
- **zsh**: update zshrc
- **zsh**: update zprofile
- **ohmyzsh**: update p10k config
- **brew**: update
- **ohmyzsh**: replace `glances` with `bottom`
- **ohmyzsh**: add Google Fonts
- **pip**: remove `requirements.txt`
- **brew**: add git-extras
- **pip**: remove `pip.conf`
- **ohmyzsh**: add completion for git-extras
- **ohmyzsh**: support more NDK versions
- **ohmyzsh**: add vscode plugins
- add VSCode extension vscode-clangd
- add VSCode extension latex-workshop
- use tuna mirrors
- remove global pnpm packages
- update `Makefile`
- use tuna mirrors
- use tuna mirrors
- use tuna mirrors
- update `.Brewfile`
- update plugin my-aliases
- fix rm directory error
- fix plugin `update`
- remove formula `jenv`
- fix git proxy
- suppress output
- fix file descriptors limit
- remove formula `openjdk`
- add plugin `conda-zsh-completion`
- add pkg `wps`
- update `.zprofile`
- update `.Brewfile`
- update zsh files
- update `.Brewfile`
- **pkg**: improve utils
- **pkg**: allow installing NDK with SDK Manager
- **pkg**: use `deb` instead of `snap`
- **pkg**: fix `clash-for-windows`
- **pkg**: add desktop entry of `Clash for Windows`
- **ntp**: replace deprecated `ntpdate` with `sntp`
- **update**: add `zsh-clean`
- **pkg**: fix "parameter unset" error
- **ialias**: display icons next to file names
- **perms**: use `umask` to get default file permissions
- **update**: update `update.plugin.zsh`
- **proxy**: update `proxy.plugin.zsh`
- **pkg**: update `llvm/load.sh`
- update `install.sh`
- update `.Brewfile`
- **key**: fix unset variable
- **pkg**: update `ndk/doctor.sh`
- **.zprofile**: imporve robustness
- **ubuntu**: fix git submodule update
- **update**: fix typo "tls" -> "lts"
- **brew**: remove `.Brewfile.lock.json`
- **pkg**: add pnpm global packages
- **proxy**: fix syntax error
- **.zshrc**: update `.zshrc`
- **git**: suppress `cz` function when `cz` is not available
- **pkg**: fix `pnpm/uninstall.sh`
- **ubuntu**: migrate from `most` to `less`
- **ubuntu**: improve `apt-clean`
- **ubuntu**: fix `pkg/android-studio/install.sh`
- **ubuntu**: update error message
- **ubuntu**: mkdir before access

### Refactor

- **zsh**: update plugin `git-setup`
- **zsh**: refactor plugins
- **zsh**: refactor plugin `pkg`
- add plugin `clean`
- **pkg**: improve code quality
- **igit**: rename plugin `git` to `igit`
- **pkg**: provide download and extract utils
- **ubuntu**: merge gpg plugin into key plugin

### Perf

- **pkg**: add `utils.sh`
- **pkg**: improve `android-studio/uninstall.sh`

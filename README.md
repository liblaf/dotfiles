<div align="center" markdown>

![Dotfiles](https://socialify.git.ci/liblaf/dotfiles/image?description=1&forks=1&issues=1&language=1&name=1&owner=1&pattern=Transparent&pulls=1&stargazers=1&theme=Auto)

[![Chezmoi](https://img.shields.io/badge/managed_with-chezmoi-6f42c1?logo=chezmoi&logoColor=white)](https://www.chezmoi.io/)
[![GitHub License](https://img.shields.io/github/license/liblaf/dotfiles?label=License)](https://github.com/liblaf/dotfiles/blob/main/LICENSE)

[Source](https://github.com/liblaf/dotfiles) · [Report Bug](https://github.com/liblaf/dotfiles/issues) · [Request Feature](https://github.com/liblaf/dotfiles/issues)

![Rule](https://cdn.jsdelivr.net/gh/andreasbm/readme/assets/lines/rainbow.png)

</div>

## ✨ Features

- 🧩 **Profile-driven modules:** `profiles/cachyos.yaml` selects layered modules for system packages, shells, languages, desktop apps, services, storage, networking, and developer tools.
- 🏗️ **Generated chezmoi source state:** hooks rebuild `home/` from reusable module files, scripts, templates, externals, root-file snippets, and generated host data.
- 🔐 **Secret-aware templates:** private files and service credentials are rendered through chezmoi templates and Bitwarden CLI workflows.
- 🧰 **Workstation batteries included:** fish, mise, uv, bun, Rust, Go, Git, GitHub CLI, Codex, OpenCode, Starship, Yazi, Docker, Caddy, Jellyfin, qBittorrent, restic, and more.
- 🧹 **Automated hygiene:** pre-commit, Rumdl, ShellCheck, Ruff, actionlint, MegaLinter, and Copier update automation keep the repository tidy.

## 🗺️ Layout

| Path | Purpose |
| --- | --- |
| `profiles/cachyos.yaml` | Default module list for the target CachyOS/Arch workstation. |
| `modules/` | Source modules containing dotfiles, scripts, package lists, externals, templates, and root snippets. |
| `hooks/` | Bootstrap, Bitwarden login, host-data generation, and module build pipeline. |
| `home/` | Generated chezmoi source directory applied to the destination home directory. |
| `.config/mise/` | Repository environment and shared maintenance tasks. |
| `.github/workflows/` | Shared automation for lint fixes, Copier updates, and approvals. |

## 📦 Installation

This repository is personal and opinionated. It targets CachyOS/Arch Linux and assumes sudo access, `pacman`, GitHub CLI authentication for GitHub-backed workflows, and Bitwarden CLI access for private templates.

Apply directly:

```bash
chezmoi init --apply liblaf
```

Review before applying:

```bash
chezmoi init liblaf
chezmoi diff
chezmoi apply
```

Manual host steps that are intentionally left outside chezmoi:

1. Choose kernels in CachyOS Kernel Manager.
2. Install the appropriate NVIDIA drivers.
3. Finish Microsoft Edge setup.
4. Run `gh auth login`.
5. Run `wrangler login`.

## ⌨️ Local Development

Clone or enter the chezmoi source tree:

```bash
gh repo clone liblaf/dotfiles ~/.local/share/chezmoi
cd ~/.local/share/chezmoi
```

Useful checks while editing:

```bash
chezmoi status
chezmoi diff
rumdl fmt .
pre-commit run --all-files
```

Any chezmoi command can trigger `hooks/read-source-state.pre.sh`; when module, hook, or profile files are newer than `home/.touch`, the hook regenerates host data and rebuilds `home/` before chezmoi reads the source state.

## 🤝 Contributing

Suggestions are welcome, especially for reproducibility, linting, and module hygiene. The configuration remains tailored to one workstation, so reusable improvements fit best as small, well-scoped pull requests.

[![PR WELCOME](https://img.shields.io/badge/%F0%9F%A4%AF%20PR%20WELCOME-%E2%86%92-ffcb47?labelColor=black&style=for-the-badge)](https://github.com/liblaf/dotfiles/pulls)

[![Contributors](https://contrib.rocks/image?repo=liblaf%2Fdotfiles)](https://github.com/liblaf/dotfiles/graphs/contributors)

---

#### 📝 License

Copyright © 2023 [liblaf](https://github.com/liblaf). <br />
This project is [MIT](https://github.com/liblaf/dotfiles/blob/main/LICENSE) licensed.

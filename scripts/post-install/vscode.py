import subprocess as sp
from collections.abc import Iterable

import rich

EXTENSION_PACKS: dict[str, set[str]] = {
    "shared": {
        "aaron-bond.better-comments",
        "chouzz.vscode-better-align",
        "chrislajoie.vscode-modelines",
        "christian-kohler.path-intellisense",
        "dnut.rewrap-revived",
        "esbenp.prettier-vscode",
        "fill-labs.dependi",
        "github.copilot-chat",
        "github.copilot",
        "GitHub.remotehub",
        "github.vscode-github-actions",
        "github.vscode-pull-request-github",
        "gruntfuggly.todo-tree",
        "iliazeus.vscode-ansi",
        "kisstkondoros.vscode-gutter-preview",
        "mechatroner.rainbow-csv",
        "mikestead.dotenv",
        "mkhl.shfmt",
        "ms-vscode-remote.remote-ssh-edit",
        "ms-vscode-remote.remote-ssh",
        "ms-vscode.makefile-tools",
        "ms-vscode.remote-explorer",
        "oderwat.indent-rainbow",
        "pkief.material-icon-theme",
        "redhat.vscode-xml",
        "redhat.vscode-yaml",
        "shd101wyy.markdown-preview-enhanced",
        "stackbreak.comment-divider",
        "streetsidesoftware.code-spell-checker",
        "timonwong.shellcheck",
        "tombi-toml.tombi",
        "usernamehw.errorlens",
        "visualstudioexptteam.intellicode-api-usage-examples",
        "VisualStudioExptTeam.vscodeintellicode-completions",
        "visualstudioexptteam.vscodeintellicode",
        "yzhang.markdown-all-in-one",
        # dependencies
        "ms-vscode.azure-repos",  # required by: ms-vscode.remote-repositories
        "ms-vscode.remote-repositories",  # required by: GitHub.remotehub
        # shared Python extensions
        "charliermarsh.ruff",
        "kevinrose.vsc-python-indent",
        "ms-python.debugpy",
        "ms-python.python",
        "ms-python.vscode-pylance",
        "ms-python.vscode-python-envs",
        # "marimo-team.vscode-marimo",
        # TODO: add marimo when it works well
    },
    "c/c++": {
        "llvm-vs-code-extensions.vscode-clangd",
        "ms-vscode.cmake-tools",
        "ms-vscode.cpptools",
        "sumneko.lua",  # for xmake.lua
        "tboox.xmake-vscode",
    },
    "dotfiles": {
        "bmalehorn.vscode-fish",
        "lkrms.inifmt",
        "matthewpi.caddyfile-support",
        "nico-castell.linux-desktop-file",
        "sumneko.lua",
    },
    "go": {
        "golang.go",
    },
    "latex": {
        "james-yu.latex-workshop",
        "sharzyl.cjk-word-handler",
    },
    "python": {
        "charliermarsh.ruff",
        "kevinrose.vsc-python-indent",
        "ms-python.debugpy",
        "ms-python.python",
        "ms-python.vscode-pylance",
        "ms-python.vscode-python-envs",
        "ms-toolsai.datawrangler",
        "ms-toolsai.jupyter-keymap",
        "ms-toolsai.jupyter-renderers",
        "ms-toolsai.jupyter",
        "ms-toolsai.vscode-jupyter-cell-tags",
        "ms-toolsai.vscode-jupyter-slideshow",
        "njpwerner.autodocstring",
        # "marimo-team.vscode-marimo",
        # TODO: add marimo when it works well
    },
    "rust": {
        "dustypomerleau.rust-syntax",
        "rust-lang.rust-analyzer",
    },
    "typescript": {
        "biomejs.biome",
    },
}


PROFILES: dict[str, list[str]] = {
    "Default": ["shared"],
    "C/C++": ["shared", "c/c++"],
    "Dotfiles": ["shared", "dotfiles"],
    "Full": [
        "shared",
        "c/c++",
        "dotfiles",
        "go",
        "latex",
        "python",
        "rust",
        "typescript",
    ],
    "Go": ["shared", "go"],
    "LaTeX": ["shared", "latex"],
    "Python": ["shared", "python"],
    "Rust": ["shared", "rust"],
    "Web": ["shared", "typescript"],
}


def list_extensions(profile: str = "Default") -> set[str]:
    proc: sp.CompletedProcess[str] = sp.run(
        ["code", "--profile", profile, "--list-extensions"],
        stdout=sp.PIPE,
        check=True,
        text=True,
    )
    extensions: list[str] = proc.stdout.splitlines()
    return set(extensions)


def install_extensions(
    extensions: Iterable[str], profile: str = "Default", *, force: bool = True
) -> None:
    for ext in extensions:
        args: list[str] = ["code", "--profile", profile, "--install-extension", ext]
        if force:
            args.append("--force")
        sp.run(args, check=True)


def uninstall_extensions(extensions: Iterable[str], profile: str = "Default") -> None:
    for ext in extensions:
        sp.run(
            ["code", "--profile", profile, "--uninstall-extension", ext], check=False
        )


def sync_extensions(extensions: Iterable[str], profile: str = "Default") -> None:
    source: set[str] = list_extensions(profile)
    target: set[str] = set(extensions)
    source = {ext.lower() for ext in source}
    target = {ext.lower() for ext in target}
    uninstall_extensions(source - target, profile)
    install_extensions(target - source, profile)


def main() -> None:
    for profile, packs in PROFILES.items():
        rich.print(f"[bold cyan]VS Code Profile: {profile}[/]")
        extensions: set[str] = set.union(*(EXTENSION_PACKS[pack] for pack in packs))
        sync_extensions(extensions, profile)


if __name__ == "__main__":
    main()

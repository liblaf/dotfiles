import functools
import operator
import subprocess as sp
from collections.abc import Iterable

import rich

EXTENSION_PACKS: dict[str, list[str]] = {
    "share": [
        "aaron-bond.better-comments",
        "chouzz.vscode-better-align",
        "chrislajoie.vscode-modelines",
        "christian-kohler.path-intellisense",
        "eamodio.gitlens",
        "esbenp.prettier-vscode",
        "fill-labs.dependi",
        "foxundermoon.shell-format",
        "github.copilot-chat",
        "github.copilot",
        "github.vscode-github-actions",
        "github.vscode-pull-request-github",
        "gruntfuggly.todo-tree",
        "iliazeus.vscode-ansi",
        "kisstkondoros.vscode-gutter-preview",
        "mechatroner.rainbow-csv",
        "mikestead.dotenv",
        "ms-azuretools.vscode-docker",
        "ms-vscode-remote.remote-containers",
        "ms-vscode-remote.remote-ssh-edit",
        "ms-vscode-remote.remote-ssh",
        "ms-vscode-remote.remote-wsl",
        "ms-vscode-remote.vscode-remote-extensionpack",
        "ms-vscode.makefile-tools",
        "ms-vscode.remote-explorer",
        "ms-vscode.remote-server",
        "nefrob.vscode-just-syntax",
        "oderwat.indent-rainbow",
        "pflannery.vscode-versionlens",
        "pkief.material-icon-theme",
        "redhat.vscode-xml",
        "redhat.vscode-yaml",
        "shd101wyy.markdown-preview-enhanced",
        "stackbreak.comment-divider",
        "stkb.rewrap",
        "streetsidesoftware.code-spell-checker",
        "tamasfe.even-better-toml",
        "timonwong.shellcheck",
        "unifiedjs.vscode-mdx",
        "usernamehw.errorlens",
        "visualstudioexptteam.intellicode-api-usage-examples",
        "visualstudioexptteam.vscodeintellicode",
        "vitaliymaz.vscode-svg-previewer",
        "wholroyd.jinja",
        "yzhang.markdown-all-in-one",
    ],
    "c/c++": [
        "llvm-vs-code-extensions.vscode-clangd",
        "ms-vscode.cmake-tools",
        "ms-vscode.cpptools",
        "tboox.xmake-vscode",
    ],
    "dotfiles": [
        "bmalehorn.vscode-fish",
        "lkrms.inifmt",
        "nico-castell.linux-desktop-file",
        "sumneko.lua",
    ],
    "go": [
        "golang.go",
    ],
    "latex": [
        "james-yu.latex-workshop",
        "sharzyl.cjk-word-handler",
    ],
    "python": [
        "charliermarsh.ruff",
        "czhang03.unicode-math-input",
        "donjayamanne.python-environment-manager",
        "kevinrose.vsc-python-indent",
        "marimo-team.vscode-marimo",
        "ms-python.debugpy",
        "ms-python.python",
        "ms-python.vscode-pylance",
        "ms-toolsai.datawrangler",
        "ms-toolsai.jupyter-keymap",
        "ms-toolsai.jupyter-renderers",
        "ms-toolsai.jupyter",
        "ms-toolsai.vscode-jupyter-cell-tags",
        "ms-toolsai.vscode-jupyter-slideshow",
        "njpwerner.autodocstring",
    ],
    "rust": [
        "dustypomerleau.rust-syntax",
        "rust-lang.rust-analyzer",
        # "1yib.rust-bundle",
    ],
    "typescript": [
        "biomejs.biome",
    ],
}

PROFILES: dict[str, list[str]] = {
    "Default": ["share", "python"],
    "C/C++": ["share", "c/c++"],
    "Dotfiles": ["share", "dotfiles", "python"],
    "Go": ["share", "go"],
    "LaTeX": ["share", "latex"],
    "Python": ["share", "python"],
    "Rust": ["share", "rust"],
    "Web": ["share", "typescript"],
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
    uninstall_extensions(source - target, profile)
    install_extensions(target - source, profile)


def main() -> None:
    for profile, packs in PROFILES.items():
        rich.print(f"[bold cyan]Profile: {profile}[/]")
        extensions: list[str] = functools.reduce(
            operator.iadd, (EXTENSION_PACKS[pack] for pack in packs), []
        )
        sync_extensions(extensions, profile)


if __name__ == "__main__":
    main()

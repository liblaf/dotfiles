#!/usr/bin/python
import subprocess as sp

DEFAULT: set[str] = {
    "aaron-bond.better-comments",
    "chouzz.vscode-better-align",
    "chrislajoie.vscode-modelines",
    "christian-kohler.path-intellisense",
    "dnut.rewrap-revived",
    "esbenp.prettier-vscode",
    "fill-labs.dependi",
    "gerrnperl.outline-map",
    "github.remotehub",
    "github.vscode-github-actions",
    "github.vscode-pull-request-github",
    "gruntfuggly.todo-tree",
    "iliazeus.vscode-ansi",
    "kisstkondoros.vscode-gutter-preview",
    "lkrms.inifmt",
    "mechatroner.rainbow-csv",
    "mikestead.dotenv",
    "mkhl.shfmt",
    "ms-vscode-remote.remote-ssh-edit",
    "ms-vscode-remote.remote-ssh",
    "ms-vscode.makefile-tools",
    "ms-vscode.remote-explorer",
    "oderwat.indent-rainbow",
    "openai.chatgpt",
    "pkief.material-icon-theme",
    "redhat.vscode-xml",
    "redhat.vscode-yaml",
    "rvben.rumdl",
    "shd101wyy.markdown-preview-enhanced",
    "stackbreak.comment-divider",
    "streetsidesoftware.code-spell-checker",
    "timonwong.shellcheck",
    "tombi-toml.tombi",
    "usernamehw.errorlens",
    "wakatime.vscode-wakatime",
    "yzhang.markdown-all-in-one",
    # dependencies
    "ms-vscode.azure-repos",  # required by: ms-vscode.remote-repositories
    "ms-vscode.remote-repositories",  # required by: github.remotehub
    # base python extensions
    "astral-sh.ty",
    "charliermarsh.ruff",
    "ms-python.debugpy",
    "ms-python.python",
    "ms-python.vscode-pylance",
}
CPP: set[str] = {
    "llvm-vs-code-extensions.vscode-clangd",
    "ms-vscode.cmake-tools",
    "ms-vscode.cpptools",
    "sumneko.lua",  # for xmake.lua
    "tboox.xmake-vscode",
}
DOTFILES: set[str] = {
    "bmalehorn.vscode-fish",
    "jamief.vscode-ssh-config-enhanced",
    "kdl-org.kdl-v1",
    "matthewpi.caddyfile-support",
    "nico-castell.linux-desktop-file",
    "sumneko.lua",
}
GO: set[str] = {
    "golang.go",
}
LATEX: set[str] = {
    "james-yu.latex-workshop",
    "sharzyl.cjk-word-handler",
}
PYTHON: set[str] = {
    "ms-toolsai.datawrangler",
    "ms-toolsai.jupyter-keymap",
    "ms-toolsai.jupyter-renderers",
    "ms-toolsai.jupyter",
    "ms-toolsai.vscode-jupyter-cell-tags",
    "ms-toolsai.vscode-jupyter-slideshow",
    "njpwerner.autodocstring",
}
RUST: set[str] = {
    "dustypomerleau.rust-syntax",
    "rust-lang.rust-analyzer",
}
TYPESCRIPT: set[str] = {
    "oxc.oxc-vscode",
}


PROFILES: dict[str, set[str]] = {
    "Default": DEFAULT,
    "C/C++": DEFAULT | CPP,
    "Dotfiles": DEFAULT | DOTFILES,
    "Go": DEFAULT | GO,
    "LaTeX": DEFAULT | LATEX,
    "Python": DEFAULT | PYTHON,
    "Rust": DEFAULT | RUST,
    "TypeScript": DEFAULT | TYPESCRIPT,
    "Full": DEFAULT | CPP | DOTFILES | GO | LATEX | PYTHON | RUST | TYPESCRIPT,
}


def list_extensions(profile: str = "Default") -> set[str]:
    proc: sp.CompletedProcess[str] = sp.run(
        ["code", "--profile", profile, "--list-extensions"],
        stdout=sp.PIPE,
        check=True,
        text=True,
    )
    extensions: list[str] = proc.stdout.lower().splitlines()
    return set(extensions)


def install_extensions(
    extensions: set[str], profile: str = "Default", *, force: bool = True
) -> None:
    for ext in extensions:
        args: list[str] = ["code", "--profile", profile, "--install-extension", ext]
        if force:
            args.append("--force")
        sp.run(args, check=True)


def uninstall_extensions(extensions: set[str], profile: str = "Default") -> None:
    for ext in extensions:
        sp.run(
            ["code", "--profile", profile, "--uninstall-extension", ext], check=False
        )


def sync_extensions(extensions: set[str], profile: str = "Default") -> None:
    installed: set[str] = list_extensions(profile)
    uninstall_extensions(installed - extensions, profile)
    install_extensions(extensions - installed, profile)


def main() -> None:
    for profile, extensions in PROFILES.items():
        print(
            f"\033[1;32m==>\033[0m \033[1mVisual Studio Code Profile: {profile}\033[0m"
        )
        sync_extensions(extensions, profile)


if __name__ == "__main__":
    main()

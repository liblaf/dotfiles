#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

extensions=(
  1YiB.rust-bundle
  aaron-bond.better-comments
  bmalehorn.vscode-fish
  charliermarsh.ruff
  chouzz.vscode-better-align
  christian-kohler.path-intellisense
  DavidAnson.vscode-markdownlint
  eamodio.gitlens
  esbenp.prettier-vscode
  foxundermoon.shell-format
  GitHub.copilot
  GitHub.copilot-labs
  golang.go
  Gruntfuggly.todo-tree
  iliazeus.vscode-ansi
  James-Yu.latex-workshop
  KevinRose.vsc-python-indent
  llvm-vs-code-extensions.vscode-clangd
  ms-python.python
  ms-toolsai.jupyter
  ms-vscode-remote.remote-ssh
  ms-vscode.cmake-tools
  ms-vscode.cpptools
  ms-vscode.makefile-tools
  nvarner.typst-lsp
  oderwat.indent-rainbow
  pflannery.vscode-versionlens
  PKief.material-icon-theme
  redhat.vscode-yaml
  shd101wyy.markdown-preview-enhanced
  streetsidesoftware.code-spell-checker
  tamasfe.even-better-toml
  timonwong.shellcheck
  usernamehw.errorlens
  VisualStudioExptTeam.vscodeintellicode
  yzhang.markdown-all-in-one
)

mapfile -t extensions_installed < <(code --list-extensions)

for extension in "${extensions[@]}"; do
  if [[ ! ${extensions_installed[*]} =~ $extension ]]; then
    code --install-extension "$extension" --force
  fi
done

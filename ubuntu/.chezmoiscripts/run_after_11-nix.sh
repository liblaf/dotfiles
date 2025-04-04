#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
sudo nix-channel --update
export NIXPKGS_ALLOW_UNFREE=1
# TODO: remove `--remove-all` to speed up the installation
sudo --preserve-env="NIXPKGS_ALLOW_UNFREE" nix-env --install --remove-all --file "$HOME/.cache/dotfiles/scripts/default.nix" --repair

PREFIX="/usr/local"
NIX_PROFILE="/nix/var/nix/profiles/default"
function nix-link() {
  local relative_path="$1"
  local source_directory="$NIX_PROFILE/$relative_path"
  local target_directory="$PREFIX/$relative_path"
  sudo mkdir --parents --verbose "$target_directory"
  sudo ln --force --symbolic --target-directory="$target_directory" "$source_directory"/*
}
nix-link "bin"
nix-link "lib/systemd/system"
nix-link "share/fish/vendor_completions.d"
nix-link "share/fonts"

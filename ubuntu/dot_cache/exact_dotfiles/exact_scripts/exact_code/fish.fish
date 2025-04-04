#!/usr/bin/fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

fisher install ~/.cache/dotfiles/fish/*
fisher install gazorby/fish-abbreviation-tips
fisher install gitlab.com/lusiadas/insist
fisher install lilyball/nix-env.fish

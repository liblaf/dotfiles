#!/usr/bin/env fish

set --append plugins \
    gazorby/fish-abbreviation-tips \
    gitlab.com/lusiadas/insist \
    ~/.config/fish/plugins/*

fisher install $plugins

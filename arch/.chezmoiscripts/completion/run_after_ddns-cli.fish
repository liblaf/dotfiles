#!/usr/bin/fish

set --local completions "$HOME/.config/fish/completions"
mkdir --parents --verbose $completions
ddns-cli complete --shell fish >"$completions/ddns-cli.fish"

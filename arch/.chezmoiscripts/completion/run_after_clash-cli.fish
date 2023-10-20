#!/usr/bin/fish

set --local completions "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose $completions
clash-cli completions fish >"$completions/clash-cli.fish"

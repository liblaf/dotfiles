#!/usr/bin/fish

set --local completions "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose $completions
ddns-cli complete fish >"$completions/ddns-cli.fish"

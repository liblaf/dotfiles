#!/usr/bin/fish

set --local completions "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose $completions
sing-box-cli complete fish >"$completions/sing-box-cli.fish"

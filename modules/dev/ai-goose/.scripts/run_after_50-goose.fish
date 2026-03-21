#!/usr/bin/fish

mkdir --parents --verbose "$HOME/.local/share/fish/vendor_completions.d"
goose completion fish >"$HOME/.local/share/fish/vendor_completions.d/goose.fish"

#!/usr/bin/fish

set --local completions "$HOME/.config/fish/completions"
mkdir --parents --verbose $completions
dasel completion fish >"$completions/dasel.fish"

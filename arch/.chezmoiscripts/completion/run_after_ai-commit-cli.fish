#!/usr/bin/fish

set --local completions "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose $completions
ai-commit-cli complete fish >"$completions/ai-commit-cli.fish"

#!/usr/bin/fish

set --local completions "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose $completions
rclone completion fish "$completions/rclone.fish"

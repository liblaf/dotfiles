#!/usr/bin/fish

set --local completions "$HOME/.config/fish/completions"
mkdir --parents --verbose $completions
rclone completion fish "$completions/rclone.fish"

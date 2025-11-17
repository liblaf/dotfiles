set FISH_COMPLETE_PATH "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose "$FISH_COMPLETE_PATH"

lime --install-completion --shell fish --output "$FISH_COMPLETE_PATH/lime.fish"
xhs --generate complete-fish >"$FISH_COMPLETE_PATH/xhs.fish"

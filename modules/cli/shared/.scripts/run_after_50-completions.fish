set FISH_COMPLETE_PATH "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose "$FISH_COMPLETE_PATH"

xhs --generate complete-fish >"$FISH_COMPLETE_PATH/xhs.fish"

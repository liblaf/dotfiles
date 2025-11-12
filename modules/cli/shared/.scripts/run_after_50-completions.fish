set FISH_COMPLETE_PATH "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose "$FISH_COMPLETE_PATH"

lime --completion generate >"$FISH_COMPLETE_PATH/lime.fish"
xh --generate complete-fish >"$FISH_COMPLETE_PATH/xh.fish"
xhs --generate complete-fish >"$FISH_COMPLETE_PATH/xhs.fish"

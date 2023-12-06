#!/usr/bin/fish

set --local bins ddns gfw

set --local completions "$HOME/.local/share/fish/vendor_completions.d"
mkdir --parents --verbose $completions
for bin in $bins
    $bin complete fish >"$completions/$bin.fish"
end

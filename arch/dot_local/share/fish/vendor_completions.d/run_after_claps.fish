#!/usr/bin/fish

set --local bins ddns gfw

for bin in $bins
    $bin complete fish >"$bin.fish"
end

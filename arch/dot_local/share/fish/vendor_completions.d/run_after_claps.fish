#!/usr/bin/fish

set --local bins ddns gfw pm

for bin in $bins
    $bin complete fish >"$bin.fish"
end

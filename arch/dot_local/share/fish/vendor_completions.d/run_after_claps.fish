#!/usr/bin/fish

set --local bins alist-cli ddns gfw pm

for bin in $bins
    $bin complete fish >"$bin.fish"
end

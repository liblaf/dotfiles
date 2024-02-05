#!/usr/bin/fish

set --local bins bws cf gfw pic

for bin in $bins
    $bin complete fish >"$bin.fish"
end

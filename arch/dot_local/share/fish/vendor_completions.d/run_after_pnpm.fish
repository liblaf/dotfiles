#!/usr/bin/fish

wget --output-document="-" "https://raw.githubusercontent.com/pnpm/tabtab/main/lib/scripts/fish.sh" |
    sed --expression="s/{pkgname}/pnpm/g" --expression="s/{completer}/pnpm/g" >"pnpm.fish"

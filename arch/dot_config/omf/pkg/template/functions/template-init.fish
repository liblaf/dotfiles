function template-init --wraps="make"
    set --function src "$HOME/github/liblaf/template"
    set --function target $PWD
    if ! test -d "$src/.git"
        gh repo clone liblaf/template "$src" -- --recurse-submodules --remote-submodules
    end
    make --directory="$target" --makefile="$src/init.mk" $argv
end

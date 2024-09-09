function sort-toml --description "sort TOML files" --wraps "toml-sort --in-place --all"
    toml-sort --in-place --all $argv
    taplo format $argv
end

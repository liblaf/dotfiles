function sort-toml
    toml-sort --in-place --all $argv
    taplo format $argv
end

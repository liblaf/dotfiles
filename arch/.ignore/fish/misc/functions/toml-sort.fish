function toml-sort --description="alias taplo format --option reorder_keys=true --option reorder_arrays=true" --wraps="taplo format"
    taplo format --option reorder_keys=true reorder_arrays=true $argv
end

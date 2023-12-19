function pre --description="alias pre pre-commit run --all-files" --wraps="pre-commit run --all-files"
    set --function git_root (git rev-parse --show-toplevel)
    pushd $git_root
    pre-commit run --all-files $argv
    popd
end

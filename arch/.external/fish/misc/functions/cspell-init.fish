function cspell-init
    set --function git_root (git rev-parse --show-toplevel)
    pushd $git_root
    command rm --force --verbose {.,}c{s,S}pell{,.config}{.json,.js,.cjs,.yaml,.yml}
    python "$HOME/github/liblaf/repo/scripts/cspell-init.py" >".cspell.json"
    prettier --write ".cspell.json"
    popd
end

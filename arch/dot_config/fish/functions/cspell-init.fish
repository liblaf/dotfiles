function cspell-init
    set --function git_root (git rev-parse --show-toplevel) || return $status
    pushd "$git_root"
    command rm --force --verbose {,.}c{s,S}pell{,.config}{.json,.js,.cjs,.yaml,.yml}
    /usr/bin/python ~/github/liblaf/repo/scripts/cspell-init.py $argv >".cspell.json"
    prettier --write ".cspell.json"
    popd
end

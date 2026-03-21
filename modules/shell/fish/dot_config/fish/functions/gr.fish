function gr --description="cd to the root of the git repository"
    set --function git_root (git rev-parse --show-toplevel) || return $status
    builtin cd $git_root
end

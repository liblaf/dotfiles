function git_current_branch
    git symbolic-ref --quiet HEAD |
        sed --expression="s|refs/heads/\(.*\)|\1|"
end

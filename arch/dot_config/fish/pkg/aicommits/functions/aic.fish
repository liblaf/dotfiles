function aic --wraps="aic"
    command aic $argv
    git-commit-amend
end

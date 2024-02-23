if status is-interactive
    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
    alias gaa "git add --all"
    alias gcan! "git commit --verbose --all --no-edit --amend"
    alias gd "git diff"
    alias gds "git diff --staged"
    alias gl "git pull"
    alias gloga "git log --oneline --decorate --graph --all"
    alias gp "git push"
    alias gpf! "git push --force"
    alias gpr "git pull --rebase"
    alias groh "git reset origin/(git_current_branch) --hard"
    alias gst "git status"
end

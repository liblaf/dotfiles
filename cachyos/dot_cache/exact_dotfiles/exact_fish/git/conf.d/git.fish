if status is-interactive
    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
    abbr --add gaa "git add --all"
    abbr --add gcan! "git commit --verbose --all --no-edit --amend"
    abbr --add gd "git diff"
    abbr --add gds "git diff --staged"
    abbr --add gl "git pull"
    abbr --add gloga "git log --oneline --decorate --graph --all"
    abbr --add gp "git push"
    abbr --add gpf! "git push --force"
    abbr --add gpr "git pull --rebase"
    abbr --add groh "git reset origin/(git_current_branch) --hard"
    abbr --add gst "git status"
end

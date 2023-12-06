function rsync-git-pull --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    set --function git_root (git rev-parse --show-toplevel)
    if test -d "$git_root"
        echo "$remote -> '$git_root'"
        rsync --filter="dir-merge,- .gitignore" "$remote:$git_root/" "$git_root"
    else
        return 1
    end
end

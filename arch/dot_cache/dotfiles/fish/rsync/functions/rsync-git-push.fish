function rsync-git-push --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    set --function git_root (git rev-parse --show-toplevel)
    if test -d "$git_root"
        echo "'$git_root' -> $remote"
        command rsync --info="progress2" --archive --delete --force --filter=":- .gitignore" --exclude=".git" --stats --human-readable --progress --itemize-changes "$git_root/" "$remote:$git_root"
    else
        return 1
    end
end

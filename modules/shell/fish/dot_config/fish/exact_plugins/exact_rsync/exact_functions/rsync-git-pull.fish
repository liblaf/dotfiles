function rsync-git-pull --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    set --function git_root (git rev-parse --show-toplevel)
    if test -d "$git_root"
        echo "$remote -> '$git_root'"
        command rsync --info="progress2" --archive --delete --force --compress --filter=":- .gitignore" --exclude=".git" --stats --human-readable --progress --itemize-changes "$remote:$git_root/" "$git_root"
    else
        return 1
    end
end

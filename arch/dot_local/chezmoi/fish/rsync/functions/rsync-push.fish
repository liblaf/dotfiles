function rsync-push --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    command rsync --info="progress2" --archive --delete --force --stats --human-readable --progress --itemize-changes "$PWD/" "$remote:$PWD"
end

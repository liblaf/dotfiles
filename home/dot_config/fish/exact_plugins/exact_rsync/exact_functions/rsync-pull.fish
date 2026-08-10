function rsync-pull --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    command rsync --info="progress2" --archive --delete --force --compress --stats --human-readable --progress --itemize-changes "$remote:$PWD/" "$PWD"
end

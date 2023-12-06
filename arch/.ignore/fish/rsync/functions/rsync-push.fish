function rsync-push --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    rsync "$PWD/" "$remote:$PWD"
end

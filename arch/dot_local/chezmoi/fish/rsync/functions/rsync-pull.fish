function rsync-pull --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    rsync "$remote:$PWD/" "$PWD"
end

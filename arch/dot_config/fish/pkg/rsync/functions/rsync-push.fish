function rsync-push --argument-names remote
    rsync "$(pwd)/" "$remote:$(pwd)"
end

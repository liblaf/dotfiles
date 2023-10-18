function rsync-pull --argument-names remote
    rsync "$remote:$(pwd)/" (pwd)
end

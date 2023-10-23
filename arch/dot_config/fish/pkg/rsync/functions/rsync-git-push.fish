function rsync-git-push --argument-names remote
    set --function toplevel (git rev-parse --show-toplevel)
    if test -d "$toplevel"
        echo "'$toplevel' -> $remote"
        rsync --filter="dir-merge,- .gitignore" "$toplevel/" "$remote:$toplevel"
    else
        return 1
    end
end

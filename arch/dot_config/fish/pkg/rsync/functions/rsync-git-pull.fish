function rsync-git-pull --argument-names remote
    if test -z "$remote"
        echo "Usage: $(status function) <REMOTE>"
        return 1
    end
    set --function toplevel (git rev-parse --show-toplevel)
    if test -d "$toplevel"
        echo "$remote -> '$toplevel'"
        rsync --filter="dir-merge,- .gitignore" "$remote:$toplevel/" $toplevel
    else
        return 1
    end
end

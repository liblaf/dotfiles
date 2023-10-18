function rsync-git-pull --argument-names remote
    set --function toplevel (git rev-parse --show-toplevel)
    if test -d "$toplevel"
        then
        echo "$remote -> '$toplevel'"
        rsync --filter="dir-merge,- .gitignore" "$remote:$toplevel/" $toplevel
    else
        return 1
    end
end

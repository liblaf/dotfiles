function rclone-push --argument-names remote
    if test -z $remote
        set --function remote business
    end
    set --function top_level (git rev-parse --show-toplevel)
    set --function repo (
        git remote get-url origin |
            sed --regexp-extended "s|https://github.com/(.+)/(.+).git|\1/\2|"
    )
    set --function args --progress --delete-excluded --exclude=".git/"
    if test -f $top_level/.rclone-ignore
        set --function --append args --exclude-from="$top_level/.rclone-ignore"
    end
    run rclone sync $args $top_level "$remote:/github/$repo"
end

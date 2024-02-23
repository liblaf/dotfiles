function rclone-push --argument-names remote
    if test -z $remote
        set --function remote business
    end
    set --function top_level (git rev-parse --show-toplevel)
    set --function repo (
      git remote get-url origin |
          sed --regexp-extended "s|https://github.com/(.+)/(.+).git|\1/\2|"
  )
    set --function args --progress
    run rclone sync $args "$remote:/github/$repo" $top_level
end

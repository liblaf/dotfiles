complete --command="rsync-pull" --no-files
complete --command="rsync-pull" \
    --arguments="(__fish_complete_user_at_hosts)" \
    --exclusive \
    --condition="test (__fish_number_of_cmd_args_wo_opts) -lt 2"

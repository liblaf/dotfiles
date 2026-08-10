function restic-browser --wraps="restic-browser"
    set --function RESTICPROFILE_CONFIG "$HOME/.config/resticprofile/profiles.toml"
    set --export --function RESTIC_PASSWORD_FILE (yq '.default.password-file' "$RESTICPROFILE_CONFIG")
    set --export --function RESTIC_REPOSITORY (yq '.default.repository' "$RESTICPROFILE_CONFIG")
    command restic-browser $argv
end

if status is-interactive
    if type --query mise
        set --export --global MISE_DEFAULT_CONFIG_FILENAME ".config/mise/config.toml"
        mise activate fish | source
    end
end

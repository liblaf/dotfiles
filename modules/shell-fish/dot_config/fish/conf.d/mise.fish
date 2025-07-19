if status is-interactive
    if type --query mise
        set --export --global MISE_DEFAULT_CONFIG_FILENAME ".config/mise/config.toml"
        set --export --global MISE_ENV "bench,dev,docs,test"
        mise activate fish | source
    end
end

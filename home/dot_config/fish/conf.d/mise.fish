if not status is-interactive
    or not type --query mise
    return
end

set --export --global MISE_DEFAULT_CONFIG_FILENAME ".config/mise/config.toml"
set --export --global MISE_ENV "bench,dev,docs,test"
mise activate fish | source

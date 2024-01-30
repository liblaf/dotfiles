function sing --description="Update sing-box config"
    gfw sub update
    mkdir --parents --verbose "$HOME/services/sing-box"
    dasel put --file="/etc/sing-box/config.json" --out="$HOME/services/sing-box/config.json" --selector="inbounds.[0].listen" --value="0.0.0.0"
end

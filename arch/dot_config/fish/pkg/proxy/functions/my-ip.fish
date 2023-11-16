function my-ip
    echo "========================================================="
    set --function ipv4 (curl --ipv4 --fail --max-time 3 ip.sb 2>/dev/null)
    echo "IPv4: $ipv4"
    echo ---------------------------------------------------------
    set --function ipv6 (curl --ipv6 --fail --max-time 3 ip.sb 2>/dev/null)
    echo "IPv6: $ipv6"
    echo ---------------------------------------------------------
    https --body --timeout=3 https://api.ip.sb/geoip 2>/dev/null
    echo "========================================================="
end

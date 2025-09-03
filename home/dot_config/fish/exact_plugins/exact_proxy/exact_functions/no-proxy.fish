function no-proxy
    env \
        --unset="all_proxy" \
        --unset="ALL_PROXY" \
        --unset="ftp_proxy" \
        --unset="FTP_PROXY" \
        --unset="http_proxy" \
        --unset="HTTP_PROXY" \
        --unset="https_proxy" \
        --unset="HTTPS_PROXY" \
        $argv
end

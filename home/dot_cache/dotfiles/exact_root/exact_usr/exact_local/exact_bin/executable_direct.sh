#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

readonly endpoint='http://127.0.0.1:62150'

if curl --fail --noproxy '' --proxy "$endpoint" --show-error --silent --url 'https://cp.cloudflare.com'; then
  export http_proxy="$endpoint"
  export https_proxy="$http_proxy"
  export ftp_proxy="$http_proxy"
  export all_proxy="$http_proxy"
  export no_proxy='localhost,127.0.0.0/8,::1'
  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export FTP_PROXY="$ftp_proxy"
  export ALL_PROXY="$all_proxy"
  export NO_PROXY="$no_proxy"
else
  unset http_proxy https_proxy ftp_proxy all_proxy no_proxy
  unset HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY NO_PROXY
fi

exec "$@"

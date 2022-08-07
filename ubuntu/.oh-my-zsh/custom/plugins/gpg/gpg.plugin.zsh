#!/usr/bin/env bash
# https://bytem.io/posts/wsl2-gpg/

function gpg-login() {
  export GPG_TTY="$(tty)"
  # 对 "test" 这个字符串进行 gpg 签名，这时候需要输密码。
  # 然后密码就会被缓存，下次就不用输密码了。
  # 重定向输出到 null，就不会显示到终端中。
  echo "test" | gpg --clearsign >"/dev/null"
}

function gpg-logout() {
  echo "reloadagent" | gpg-connect-agent
}

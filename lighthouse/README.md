## Firewall

### Allow

- `60022` (SSH)
- `60081` (Nginx Proxy Manager)

### Deny

- `22` (SSH)

## dotfiles

```shell
mkdir --parents --verbose ${HOME}/.local/share
git clone https://github.com/liblaf/dotfiles.git ${HOME}/.local/share/chezmoi
cd ${HOME}/.local/share/chezmoi
bash setup.sh
```

## Nginx Proxy Manager

- login with email `admin@example.com` and password `changeme`
- add SSL Certificate for `*.liblaf.me`
- add Proxy Host

### AList

`alist.liblaf.me` -> `http://alist:5244`

#### Custom Nginx Configuration[^1]

[^1]: [Reverse proxy | AList Docs](https://alist.nn.ci/guide/install/reverse-proxy.html)

```nginx
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header Host $http_host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header Range $http_range;
proxy_set_header If-Range $http_if_range;
proxy_redirect off;
# proxy_pass http://127.0.0.1:5244;
# the max size of file to upload
client_max_body_size 20000m;
```

### dash.

`dash.liblaf.me` -> `http://dash:3001`

### Nginx Proxy Manager

`nginx.liblaf.me` -> `http://nginx-proxy-manager:81`

## AList

See the log output for the admin's info:[^2]

```shell
docker exec -it alist ./alist admin
```

[^2]: [Use Docker | AList Docs](https://alist.nn.ci/guide/install/docker.html)

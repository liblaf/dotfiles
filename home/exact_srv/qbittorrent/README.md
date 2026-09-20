<!-- -*- mode: markdown; -*- -->

# qBittorrent

## Options

- Behavior > ✅ Show external IP in status bar
- Behavior > ✅ Log performance warnings
- Downloads > Saving Management > Default Torrent Management Mode: Automatic
- Downloads > Saving Management > When Torrent Category changed: Relocate torrent
- Downloads > Saving Management > When Default Save Path changed: Relocate affected torrent
- Downloads > Saving Management > When Category Save Path changed: Relocate affected torrent
- Downloads > Saving Management > ✅ Use Subcategories
- Downloads > Saving Management > Default Save Path: `/downloads`
- Connection > Listening Port > Port used for incoming connections: `63722`
- Connection > Connections Limits > ❌ Global maximum number of upload slots
- Connection > Connections Limits > ❌ Maximum number of upload slots per torrent
- BitTorrent > ❌ Torrent Queueing
- WebUI > Web User Interface (Remote control) > Port: `8080`
- WebUI > Web User Interface (Remote control) > Authentication > Username: `***`
- WebUI > Web User Interface (Remote control) > Authentication > Password: `***`
- WebUI > Web User Interface (Remote control) > Authentication > ✅ Bypass authentication for clients in whitelisted IP subnets
- WebUI > Web User Interface (Remote control) > Authentication > Whitelisted IP subnets (one per line):

  ```text
  10.208.11.1/32
  fd45:6e65:685e::1/128
  100.64.0.0/10
  fd7a:115c:a1e0::/48
  ```

- WebUI > Web User Interface (Remote control) > Security > ❌ Enable Host header validation
- WebUI > Web User Interface (Remote control) > Security > ✅ Enable reverse proxy support
- WebUI > Web User Interface (Remote control) > Security > Trusted proxies list: `10.208.11.1;fd45:6e65:685e::1`

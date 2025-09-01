# qBittorrent

## Options

- Behavior > ✅ Show external IP in status bar
- Behavior > ✅ Log performance warnings
- Downloads > Saving Management > Default Torrent Management Mode: Automatic
- Downloads > Saving Management > When Torrent Category changed: Relocate torrent
- Downloads > Saving Management > When Default Save Path changed: Relocate affected torrent
- Downloads > Saving Management > When Category Save Path changed: Relocate affected torrent
- Downloads > Saving Management > ✅ Use Subcategories
- Downloads > Saving Management > Default Save Path: /downloads
- Connection > Listening Port > Port used for incoming connections: `{{ .ports.qbittorrent }}`
- Connection > Connections Limits > ❌ Global maximum number of upload slots
- Connection > Connections Limits > ❌ Maximum number of upload slots per torrent
- BitTorrent > ❌ Torrent Queueing
- WebUI > Web User Interface (Remote control) > Port: `{{ .ports.qbittorrent_webui }}`
- WebUI > Web User Interface (Remote control) > Authentication > Username: `***`
- WebUI > Web User Interface (Remote control) > Authentication > Password: `***`
- WebUI > Web User Interface (Remote control) > ✅ Use alternative WebUI
- WebUI > Web User Interface (Remote control) > ✅ Use alternative WebUI > Files location: `/vuetorrent`
- WebUI > Web User Interface (Remote control) > Security > ❌ Enable Host header validation (for reverse proxy to work)

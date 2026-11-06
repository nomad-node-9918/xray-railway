#!/bin/sh
set -e
PORT="${PORT:-8080}"
UUID="${UUID:?UUID env var is required}"
WS_PATH="${WS_PATH:-/ws}"
mkdir -p /usr/local/etc/xray
cat > /usr/local/etc/xray/config.json <<JSON
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": ${PORT},
      "protocol": "vless",
      "settings": {"clients": [{"id": "${UUID}", "flow": ""}], "decryption": "none"},
      "streamSettings": {"network": "ws", "wsSettings": {"path": "${WS_PATH}"}}
    }
  ],
  "outbounds": [{"protocol": "freedom", "tag": "direct"}]
}
JSON
exec /usr/local/bin/xray run -c /usr/local/etc/xray/config.json

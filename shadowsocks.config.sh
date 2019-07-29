#!/bin/sh
cat > /data/shadowsocks/server.json << EOF
{
    "server": "${SERVER_HOST}",
    "server_port": ${SERVER_PORT-6550},
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "password": "${SERVER_PASSWORD-xxxxxx}",
    "timeout": 300,
    "method": "${SERVER_METHOD-rc4-md5}"
}
EOF

cat > /data/shadowsocks/broswer.json << EOF
{
    "server": "${SERVER_HOST}",
    "server_port": ${SERVER_PORT-6550},
    "local_address": "${SERVER_HOST}",
    "local_port": ${BROSWER_PROT-6551},
    "password": "${SERVER_PASSWORD-xxxxxx}",
    "timeout": 300,
    "method": "${SERVER_METHOD-rc4-md5}"
}
EOF

exec "$@"

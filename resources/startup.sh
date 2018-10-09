#!/bin/bash

domain=$SERVER_DOMAIN
balance=$LB_HOST
balanceport=$LB_PORT
emailregister=$EMAIL
cfgfile="Caddyfile"

#mkdir -p $(dirname $cfgfile)

cat > $cfgfile << EOF
$domain {
    tls $emailregister
    gzip
    log stdout
    errors stdout
    proxy / $balance:$balanceport {
        transparent
    }
}
EOF

cat $cfgfile
sleep 2

caddy -conf $cfgfile --agree=$ACME_AGREE $@
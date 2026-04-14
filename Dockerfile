FROM coturn/coturn:latest

# Renderの環境変数 PORT を使用するか、443を強制
ENV PORT=3478

# TCPのみ、443ポートで待ち受け、リレーポートを固定（Renderでは実質1ポート運用）
CMD turnserver \
    --listening-port=$PORT \
    --external-ip=$(curl -s ifconfig.me) \
    --no-udp \
    --no-udp-relay \
    --tcp-self-relay \
    --realm=://onrender.com \
    --user=myuser:mypassword \
    --lt-cred-mech

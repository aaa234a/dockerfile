FROM coturn/coturn:latest

USER root
# curl（IP取得用）と python3（ダミーWebサーバー用）をインストール
RUN apt-get update && apt-get install -y curl python3 && rm -rf /var/lib/apt/lists/*

USER coturn

# 1. バックグラウンドでPythonの簡易Webサーバーを起動（RenderのHealth Check対策）
# 2. その後、Coturnを起動
CMD python3 -m http.server $PORT & \
    turnserver \
    --listening-port=3479 \
    --external-ip=$(curl -s ifconfig.me) \
    --no-udp \
    --no-udp-relay \
    --tcp-self-relay \
    --realm=render-turn.com \
    --user=myuser:mypassword \
    --lt-cred-mech \
    --no-stdout-log

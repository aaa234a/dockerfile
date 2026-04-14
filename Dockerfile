FROM coturn/coturn:latest

# rootユーザーでcurlをインストール（IP取得用）
USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Coturnの一般ユーザーに戻す
USER coturn

# Render環境に合わせた起動設定
# --no-stdout-log を追加してログ出力を安定させ、
# ポートはRenderが提供する $PORT 環境変数を優先的に使用します
CMD turnserver \
    --listening-port=${PORT:-3478} \
    --external-ip=$(curl -s ifconfig.me) \
    --no-udp \
    --no-udp-relay \
    --tcp-self-relay \
    --realm=://onrender.com \
    --user=myuser:mypassword \
    --lt-cred-mech \
    --no-stdout-log

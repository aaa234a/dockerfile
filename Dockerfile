FROM coturn/coturn:latest

USER root
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

USER coturn

# 1. realm を適切な文字列に変更
# 2. shell形式のCMDにして変数を確実に展開させる
CMD turnserver \
    --listening-port=${PORT:-3478} \
    --external-ip=$(curl -s ifconfig.me) \
    --no-udp \
    --no-udp-relay \
    --tcp-self-relay \
    --realm=render-turn.com \
    --user=myuser:mypassword \
    --lt-cred-mech \
    --no-stdout-log

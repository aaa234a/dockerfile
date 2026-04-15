from flask import Flask, send_from_directory
from flask_sock import Sock

app = Flask(__name__)
sock = Sock(app)

clients = []

@app.route("/")
def index():
    return send_from_directory(".", "vnc.html")

@sock.route("/ws")
def ws(ws):
    clients.append(ws)

    while True:
        data = ws.receive()
        if data is None:
            break

        for c in clients:
            if c != ws:
                c.send(data)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)

import subprocess
from flask import Flask, send_from_directory

app = Flask(__name__, static_folder="noVNC")

@app.route("/")
def index():
    return send_from_directory("noVNC", "vnc.html")

@app.route("/<path:path>")
def static_files(path):
    return send_from_directory("noVNC", path)

# 🔥 websockify起動
subprocess.Popen([
    "websockify",
    "6080",
    "host.docker.internal:5900"
])

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)

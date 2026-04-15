from flask import Flask, send_from_directory
import os

app = Flask(__name__, static_folder="noVNC")

# ルートはvnc.html
@app.route("/")
def index():
    return send_from_directory("noVNC", "vnc.html")

# 🔥 重要：ディレクトリ丸ごと配信
@app.route("/<path:path>")
def static_files(path):
    file_path = os.path.join("noVNC", path)

    # 存在チェック（デバッグ用）
    if not os.path.exists(file_path):
        return f"404 NOT FOUND: {path}", 404

    return send_from_directory("noVNC", path)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)

import socket
import threading
from http.server import SimpleHTTPRequestHandler, HTTPServer

clients = []

def handle(conn):
    clients.append(conn)
    try:
        while True:
            data = conn.recv(4096)
            if not data:
                break
            for c in clients:
                if c != conn:
                    c.sendall(data)
    except:
        pass

def socket_server():
    s = socket.socket()
    s.bind(("0.0.0.0", 9999))
    s.listen()

    while True:
        conn, _ = s.accept()
        threading.Thread(target=handle, args=(conn,)).start()

threading.Thread(target=socket_server, daemon=True).start()

HTTPServer(("0.0.0.0", 10000), SimpleHTTPRequestHandler).serve_forever()
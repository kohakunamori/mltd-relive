#!/usr/bin/env python3
import argparse
import hashlib
import os
import socket
import ssl
import subprocess
import threading
import time

REFS = {
    "v0.1.6": "794f42f868268dc964c9ac0aa7b1ba82c019b53e",
    "v0.1.7": "ad7ee0d8ae4271bfcc47b6609cc54fad7ba636f6",
    "tls-worker": "47cc9b6628ac5c73a26f32b1ac3e6dd70e5a0789",
    "pre-upstream": "8601b12bb40080c1973df380bc7aa4173c9412c9",
    "upstream-merge": "5c124e0fc0ab1b044fe56f49ffe1de7589438361",
    "v0.1.8": "aa128151a8ffa87467d718445553ba2d67feb596",
    "hotfix": "d13f58723855064ace4c77b0c250f8e58fcebbec",
}


def git_show(ref: str, path: str) -> bytes:
    return subprocess.check_output(["git", "show", f"{ref}:{path}"])


def yesno(value: bool) -> str:
    return "yes" if value else "no"


def source_matrix() -> None:
    print("=== source matrix ===")
    auth_hashes = {}
    for name, ref in REFS.items():
        proxy = git_show(ref, "standalone/mltd/servers/proxy.py").decode("utf-8")
        dns = git_show(ref, "standalone/mltd/servers/dns.py").decode("utf-8")
        handler = git_show(ref, "standalone/mltd/servers/handler.py").decode("utf-8")
        auth = git_show(ref, "standalone/mltd/services/auth.py")
        theater = git_show(ref, "standalone/mltd/services/theater.py").decode("utf-8")
        setup = git_show(ref, "standalone/mltd/models/setup.py").decode("utf-8")
        auth_hashes[name] = hashlib.sha256(auth).hexdigest()
        listener_wrapped = "httpd.socket = context.wrap_socket" in proxy
        worker_tls = "process_request_thread" in proxy and "context.wrap_socket(request" in proxy
        socket_timeout = "request.settimeout" in proxy
        base_dns = "theaterdays.appspot.com." in dns
        base_host = "theaterdays.appspot.com" in handler
        dynamic_theater = "get_theater_status(session, user, now)" in theater
        theater_context = "GetTheater', context_arg='context'" in theater
        migration = "_migrate_theater_contact_and_user_contact_schedules" in setup
        print(
            f"{name:14} listener_tls={yesno(listener_wrapped):3} "
            f"worker_tls={yesno(worker_tls):3} timeout={yesno(socket_timeout):3} "
            f"base_dns={yesno(base_dns):3} base_host={yesno(base_host):3} "
            f"dynamic_theater={yesno(dynamic_theater):3} theater_context={yesno(theater_context):3} "
            f"theater_migration={yesno(migration):3} auth_sha256={auth_hashes[name][:12]}"
        )

    base_auth = auth_hashes["v0.1.6"]
    assert auth_hashes["v0.1.8"] == base_auth, "AuthService changed between v0.1.6 and v0.1.8"
    assert "httpd.socket = context.wrap_socket" in git_show(REFS["v0.1.6"], "standalone/mltd/servers/proxy.py").decode()
    assert "process_request_thread" in git_show(REFS["tls-worker"], "standalone/mltd/servers/proxy.py").decode()
    assert "get_theater_status(session, user, now)" not in git_show(REFS["pre-upstream"], "standalone/mltd/services/theater.py").decode()
    assert "get_theater_status(session, user, now)" in git_show(REFS["upstream-merge"], "standalone/mltd/services/theater.py").decode()
    print("source assertions: PASS")


def theater_smoke(iterations: int) -> None:
    from mltd.models.setup import upgrade_database
    from mltd.services.theater import get_theater

    upgrade_database()
    context = {"user_id": "ffffffff-ffff-ffff-ffff-ffffffffffff"}
    nonempty = 0
    for _ in range(iterations):
        result = get_theater({}, context)
        assert isinstance(result, dict)
        theater = result.get("theater")
        assert isinstance(theater, dict)
        rooms = theater.get("room_list")
        bookings = theater.get("idol_booking_list")
        assert isinstance(rooms, list)
        assert isinstance(bookings, list)
        if rooms:
            nonempty += 1
    print(f"theater smoke: PASS iterations={iterations} nonempty_room_results={nonempty}")


def theater_failure_guards() -> None:
    from sqlalchemy import delete
    from sqlalchemy.orm import Session
    from mltd.models.engine import engine
    from mltd.models.models import MstTheaterContact
    from mltd.services.theater import get_theater

    context = {"user_id": "ffffffff-ffff-ffff-ffff-ffffffffffff"}
    with Session(engine) as session:
        session.execute(delete(MstTheaterContact))
        session.commit()
    try:
        get_theater({}, context)
    except Exception as exc:
        print(f"empty mst_theater_contact raises: {type(exc).__name__}: {exc}")
        return
    raise AssertionError("dynamic Theater unexpectedly tolerated empty mst_theater_contact; update diagnostic")


def make_tcp_pair():
    listener = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    listener.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    listener.bind(("127.0.0.1", 0))
    listener.listen(1)
    client = socket.create_connection(listener.getsockname(), timeout=3)
    server, _ = listener.accept()
    listener.close()
    return server, client


def timeout_socket_property() -> None:
    import mltd.servers.proxy as proxy

    if not hasattr(proxy, "_tune_client_socket"):
        print("socket timeout tuning absent on this ref")
        return
    old = proxy._SOCKET_TIMEOUT
    server, client = make_tcp_pair()
    try:
        proxy._SOCKET_TIMEOUT = 1.25
        proxy._tune_client_socket(server)
        actual = server.gettimeout()
        print(f"accepted-socket timeout after tuning: {actual}")
        assert actual == 1.25
    finally:
        proxy._SOCKET_TIMEOUT = old
        server.close()
        client.close()


def tls_persistent_idle_test() -> None:
    import mltd.servers.proxy as proxy

    if not hasattr(proxy, "_SOCKET_TIMEOUT") or not hasattr(proxy, "_tune_client_socket"):
        print("persistent idle timeout test: SKIP (ref has no socket timeout tuning)")
        return

    proxy._SOCKET_TIMEOUT = 1
    proxy.config.asset_mode = "remote"
    port = 18443
    ready_r, ready_w = os.pipe()

    class Conn:
        def send(self, value):
            os.write(ready_w, b"1")
        def close(self):
            os.close(ready_w)

    thread = threading.Thread(target=proxy.start, kwargs={"port": port, "conn": Conn()}, daemon=True)
    thread.start()
    os.read(ready_r, 1)
    os.close(ready_r)

    ctx = ssl.create_default_context()
    ctx.check_hostname = False
    ctx.verify_mode = ssl.CERT_NONE
    raw = socket.create_connection(("127.0.0.1", port), timeout=3)
    tls = ctx.wrap_socket(raw, server_hostname="theaterdays-zh.appspot.com")
    tls.settimeout(3)
    try:
        tls.sendall(b"HEAD /not-an-asset HTTP/1.1\r\nHost: theaterdays-zh.appspot.com\r\nConnection: keep-alive\r\n\r\n")
        first = tls.recv(4096)
        assert b"HTTP/1.1 404" in first or b"HTTP/1.0 404" in first, first[:200]
        time.sleep(1.5)
        closed = False
        try:
            tls.sendall(b"HEAD /not-an-asset HTTP/1.1\r\nHost: theaterdays-zh.appspot.com\r\nConnection: close\r\n\r\n")
            data = tls.recv(4096)
            if not data:
                closed = True
        except (BrokenPipeError, ConnectionResetError, ssl.SSLError, OSError):
            closed = True
        print(f"persistent TLS connection closed after idle timeout: {closed}")
        assert closed, "idle keep-alive connection remained usable past configured socket timeout"
    finally:
        try:
            tls.close()
        except OSError:
            pass


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=[
        "source-matrix", "theater-smoke", "theater-failure-guards",
        "timeout-property", "tls-idle-timeout",
    ])
    parser.add_argument("--iterations", type=int, default=100)
    args = parser.parse_args()
    if args.mode == "source-matrix":
        source_matrix()
    elif args.mode == "theater-smoke":
        theater_smoke(args.iterations)
    elif args.mode == "theater-failure-guards":
        theater_failure_guards()
    elif args.mode == "timeout-property":
        timeout_socket_property()
    elif args.mode == "tls-idle-timeout":
        tls_persistent_idle_test()


if __name__ == "__main__":
    main()

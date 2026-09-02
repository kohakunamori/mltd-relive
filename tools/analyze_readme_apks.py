#!/usr/bin/env python3
import base64
import hashlib
import json
import os
import re
import struct
import sys
import zipfile
from pathlib import Path

import requests
from Crypto.Cipher import AES

APKS = {
    "zh-termux": "https://mega.nz/file/7B5VHK4T#AR3olYRjV8Y_-sxPvZltoc3YCDQi4VdsTdMrYWNHK1g",
    "zh-desktop": "https://mega.nz/file/HMgiTSbI#cy7z52H6zBOSdSX5Xok1GKQ4yT7k6K1ctjV6Heceu3I",
    "ko-termux": "https://mega.nz/file/iJohWQbC#KqauZ-10selJMon1NhIIbsiWXte14Rs0n81jGaDDR3E",
    "ko-desktop": "https://mega.nz/file/2dBgiBQY#NBgo-1rTW7g1Jtm9FLYZ61KoOP4HFoElxO75dzMyXew",
}

NETWORK_PATTERNS = [
    re.compile(rb"https?://[^\x00\s\"']{4,200}", re.I),
    re.compile(rb"(?:theaterdays|rainbowunicorn|appspot|localhost|127\.0\.0\.1|7650|7651)[^\x00\s]{0,160}", re.I),
]
CRITICAL_SUFFIXES = (
    "AndroidManifest.xml", "resources.arsc", "classes.dex", "classes2.dex",
    "libil2cpp.so", "libunity.so", "global-metadata.dat",
)


def b64url_decode(value: str) -> bytes:
    value += '=' * ((4 - len(value) % 4) % 4)
    return base64.urlsafe_b64decode(value)


def mega_file_info(link: str):
    match = re.search(r"mega\.nz/file/([^#]+)#(.+)$", link)
    if not match:
        raise ValueError(link)
    handle, key_s = match.groups()
    raw = b64url_decode(key_s)
    if len(raw) != 32:
        raise ValueError(f"unexpected MEGA key length {len(raw)}")
    ints = struct.unpack(">8I", raw)
    key = struct.pack(">4I", ints[0] ^ ints[4], ints[1] ^ ints[5], ints[2] ^ ints[6], ints[3] ^ ints[7])
    iv = struct.pack(">4I", ints[4], ints[5], 0, 0)
    resp = requests.post(
        "https://g.api.mega.co.nz/cs?id=0",
        json=[{"a": "g", "g": 1, "p": handle}], timeout=30,
    )
    resp.raise_for_status()
    payload = resp.json()[0]
    if isinstance(payload, int):
        raise RuntimeError(f"MEGA API error {payload}")
    attrs = b64url_decode(payload["at"])
    attrs += b"\0" * ((16 - len(attrs) % 16) % 16)
    dec = AES.new(key, AES.MODE_CBC, iv=b"\0" * 16).decrypt(attrs).rstrip(b"\0")
    if not dec.startswith(b"MEGA"):
        raise RuntimeError("bad MEGA attributes")
    meta = json.loads(dec[4:].decode("utf-8"))
    return payload["g"], key, iv, meta.get("n", "download.apk"), int(payload.get("s", 0))


def download_mega(link: str, dest: Path):
    url, key, iv, original_name, expected_size = mega_file_info(link)
    dest.parent.mkdir(parents=True, exist_ok=True)
    tmp = dest.with_suffix(dest.suffix + ".part")
    cipher = AES.new(key, AES.MODE_CTR, nonce=b"", initial_value=int.from_bytes(iv, "big"))
    total = 0
    digest = hashlib.sha256()
    with requests.get(url, stream=True, timeout=(30, 120)) as r:
        r.raise_for_status()
        with tmp.open("wb") as f:
            for chunk in r.iter_content(1024 * 1024):
                if not chunk:
                    continue
                plain = cipher.decrypt(chunk)
                f.write(plain)
                digest.update(plain)
                total += len(plain)
                if total and total % (100 * 1024 * 1024) < len(plain):
                    print(f"{dest.name}: {total / 1024 / 1024:.1f} MiB")
    if expected_size and total != expected_size:
        raise RuntimeError(f"{dest.name}: size mismatch {total} != {expected_size}")
    os.replace(tmp, dest)
    return {"name": original_name, "size": total, "sha256": digest.hexdigest()}


def sha256_stream(fobj):
    h = hashlib.sha256()
    for chunk in iter(lambda: fobj.read(1024 * 1024), b""):
        h.update(chunk)
    return h.hexdigest()


def zip_entry_map(apk: Path):
    with zipfile.ZipFile(apk) as z:
        return {
            i.filename: {
                "size": i.file_size,
                "compressed": i.compress_size,
                "crc": f"{i.CRC:08x}",
                "method": i.compress_type,
            }
            for i in z.infolist()
        }


def selected_hashes(apk: Path, names):
    result = {}
    with zipfile.ZipFile(apk) as z:
        for name in names:
            try:
                with z.open(name) as f:
                    result[name] = sha256_stream(f)
            except KeyError:
                pass
    return result


def critical_names(entries):
    return sorted(name for name in entries if name.endswith(CRITICAL_SUFFIXES))


def binary_diff_stats(a: bytes, b: bytes):
    common = min(len(a), len(b))
    diff_count = 0
    ranges = []
    start = None
    for i in range(common):
        if a[i] != b[i]:
            diff_count += 1
            if start is None:
                start = i
        elif start is not None:
            ranges.append((start, i - 1))
            start = None
    if start is not None:
        ranges.append((start, common - 1))
    if len(a) != len(b):
        ranges.append((common, max(len(a), len(b)) - 1))
        diff_count += abs(len(a) - len(b))
    return {
        "size_a": len(a), "size_b": len(b), "different_bytes": diff_count,
        "different_ratio": diff_count / max(1, max(len(a), len(b))),
        "range_count": len(ranges), "first_ranges": ranges[:100],
    }


def extract_network_strings(data: bytes):
    found = set()
    for pattern in NETWORK_PATTERNS:
        for match in pattern.finditer(data):
            s = match.group(0)
            if len(s) > 220:
                s = s[:220]
            try:
                found.add(s.decode("utf-8", "replace"))
            except Exception:
                pass
    # Also scan UTF-16LE strings for the same terms.
    text16 = data.decode("utf-16le", "ignore")
    for term in ("http://", "https://", "theaterdays", "rainbowunicorn", "localhost", "127.0.0.1", "7650", "7651"):
        pos = 0
        while True:
            pos = text16.lower().find(term.lower(), pos)
            if pos < 0:
                break
            found.add("UTF16:" + text16[max(0, pos - 40):pos + 180].replace("\x00", ""))
            pos += len(term)
    return sorted(found)


def analyze_apk(apk: Path):
    entries = zip_entry_map(apk)
    critical = critical_names(entries)
    report = {
        "path": str(apk),
        "size": apk.stat().st_size,
        "sha256": hashlib.sha256(apk.read_bytes()).hexdigest(),
        "entry_count": len(entries),
        "entries": entries,
        "critical_hashes": selected_hashes(apk, critical),
        "network_strings": {},
    }
    with zipfile.ZipFile(apk) as z:
        scan_names = [n for n in critical if n.endswith((".dex", ".so", "global-metadata.dat"))]
        for name in scan_names:
            with z.open(name) as f:
                data = f.read()
            strings = extract_network_strings(data)
            if strings:
                report["network_strings"][name] = strings
    return report


def pair_diff(label: str, a_path: Path, b_path: Path, a_report, b_report):
    a_entries, b_entries = a_report["entries"], b_report["entries"]
    a_names, b_names = set(a_entries), set(b_entries)
    added = sorted(b_names - a_names)
    removed = sorted(a_names - b_names)
    changed = sorted(
        n for n in a_names & b_names
        if (a_entries[n]["size"], a_entries[n]["crc"]) != (b_entries[n]["size"], b_entries[n]["crc"])
    )
    payload_changed = [n for n in changed if not n.upper().startswith("META-INF/")]
    hash_names = sorted(set(payload_changed) | set(critical_names(a_names | b_names)))
    hashes_a = selected_hashes(a_path, hash_names)
    hashes_b = selected_hashes(b_path, hash_names)
    exact_changed = [n for n in hash_names if hashes_a.get(n) != hashes_b.get(n)]

    binary_stats = {}
    with zipfile.ZipFile(a_path) as za, zipfile.ZipFile(b_path) as zb:
        for name in exact_changed:
            if not name.endswith(("classes.dex", "classes2.dex", "libil2cpp.so", "libunity.so", "global-metadata.dat", "AndroidManifest.xml", "resources.arsc")):
                continue
            try:
                da, db = za.read(name), zb.read(name)
            except KeyError:
                continue
            binary_stats[name] = binary_diff_stats(da, db)

    net_a = set(sum(a_report["network_strings"].values(), []))
    net_b = set(sum(b_report["network_strings"].values(), []))
    return {
        "label": label,
        "a": a_path.name, "b": b_path.name,
        "same_whole_apk": a_report["sha256"] == b_report["sha256"],
        "added_entries": added,
        "removed_entries": removed,
        "changed_entries": changed,
        "payload_changed_entries": payload_changed,
        "exact_changed_entries": exact_changed,
        "binary_diff_stats": binary_stats,
        "network_strings_only_a": sorted(net_a - net_b),
        "network_strings_only_b": sorted(net_b - net_a),
        "network_strings_common": sorted(net_a & net_b),
    }


def write_summary(report, out: Path):
    lines = []
    lines.append("README APK forensic comparison\n")
    for name, info in report["downloads"].items():
        ar = report["apks"][name]
        lines.append(f"[{name}] original={info['name']} size={info['size']} sha256={info['sha256']}")
        lines.append(f"  zip entries={ar['entry_count']}")
        lines.append("  critical:")
        for path, digest in ar["critical_hashes"].items():
            lines.append(f"    {digest}  {path}")
        for path, values in ar["network_strings"].items():
            lines.append(f"  network strings in {path}: {len(values)}")
            for value in values[:80]:
                lines.append(f"    {value}")
        lines.append("")

    for pair in report["pairs"]:
        lines.append(f"=== {pair['label']} ===")
        lines.append(f"same whole APK: {pair['same_whole_apk']}")
        lines.append(f"added entries: {len(pair['added_entries'])}")
        for n in pair['added_entries'][:200]: lines.append(f"  + {n}")
        lines.append(f"removed entries: {len(pair['removed_entries'])}")
        for n in pair['removed_entries'][:200]: lines.append(f"  - {n}")
        lines.append(f"changed entries (CRC/size): {len(pair['changed_entries'])}")
        for n in pair['changed_entries'][:300]: lines.append(f"  * {n}")
        lines.append(f"payload changed entries: {len(pair['payload_changed_entries'])}")
        for n in pair['payload_changed_entries'][:300]: lines.append(f"  P {n}")
        lines.append(f"exact changed entries checked: {len(pair['exact_changed_entries'])}")
        for n in pair['exact_changed_entries'][:300]: lines.append(f"  H {n}")
        lines.append("binary diff stats:")
        for n, st in pair['binary_diff_stats'].items():
            lines.append(f"  {n}: {st}")
        lines.append("network strings only in A (termux):")
        for s in pair['network_strings_only_a'][:200]: lines.append(f"  A {s}")
        lines.append("network strings only in B (desktop):")
        for s in pair['network_strings_only_b'][:200]: lines.append(f"  B {s}")
        lines.append("")
    out.write_text("\n".join(lines), encoding="utf-8")


def main():
    out = Path(sys.argv[1] if len(sys.argv) > 1 else "apk-analysis")
    apk_dir = out / "apks"
    apk_dir.mkdir(parents=True, exist_ok=True)
    downloads = {}
    reports = {}
    for name, link in APKS.items():
        dest = apk_dir / f"{name}.apk"
        if not dest.exists():
            print(f"Downloading {name}...")
            downloads[name] = download_mega(link, dest)
        else:
            downloads[name] = {
                "name": dest.name, "size": dest.stat().st_size,
                "sha256": hashlib.sha256(dest.read_bytes()).hexdigest(),
            }
        print(f"Analyzing {name}...")
        reports[name] = analyze_apk(dest)

    pairs = [
        pair_diff("Traditional Chinese: Termux vs Desktop", apk_dir / "zh-termux.apk", apk_dir / "zh-desktop.apk", reports["zh-termux"], reports["zh-desktop"]),
        pair_diff("Korean: Termux vs Desktop", apk_dir / "ko-termux.apk", apk_dir / "ko-desktop.apk", reports["ko-termux"], reports["ko-desktop"]),
        pair_diff("Termux cross-region: zh vs ko", apk_dir / "zh-termux.apk", apk_dir / "ko-termux.apk", reports["zh-termux"], reports["ko-termux"]),
        pair_diff("Desktop cross-region: zh vs ko", apk_dir / "zh-desktop.apk", apk_dir / "ko-desktop.apk", reports["zh-desktop"], reports["ko-desktop"]),
    ]
    report = {"downloads": downloads, "apks": reports, "pairs": pairs}
    (out / "report.json").write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    write_summary(report, out / "summary.txt")
    print((out / "summary.txt").read_text(encoding="utf-8"))


if __name__ == "__main__":
    main()

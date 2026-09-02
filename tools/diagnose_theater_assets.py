#!/usr/bin/env python3
import csv
from pathlib import Path

import requests
from msgpack import unpackb

REMOTE_ROOT = "https://assets.rainbowunicorn7297.com"
MANIFEST = "85822153578df611a4f852d4e02660f6f34401e4.data"


def iter_text(value):
    if isinstance(value, str):
        yield value
    elif isinstance(value, bytes):
        try:
            yield value.decode("utf-8")
        except UnicodeDecodeError:
            return
    elif isinstance(value, dict):
        for key, item in value.items():
            yield from iter_text(key)
            yield from iter_text(item)
    elif isinstance(value, (list, tuple)):
        for item in value:
            yield from iter_text(item)


csv_path = Path("standalone/mltd/models/mst_data/mst_theater_contact.csv")
with csv_path.open(encoding="utf-8", newline="") as fh:
    resource_ids = sorted({
        row["resource_id"] for row in csv.DictReader(fh)
        if row.get("resource_id")
    })

url = f"{REMOTE_ROOT}/zh-android/{MANIFEST}"
r = requests.get(url, timeout=60)
print(f"manifest {r.status_code=} bytes={len(r.content)}")
r.raise_for_status()
manifest = unpackb(r.content, raw=False)
table = manifest[0]
print(f"manifest_records={len(table)} theater_resource_ids={len(resource_ids)}")

matches = {}
for key, record in table.items():
    haystack = "\n".join(list(iter_text(key)) + list(iter_text(record)))
    for rid in resource_ids:
        if rid in haystack:
            matches.setdefault(rid, []).append((key, record))

missing = [rid for rid in resource_ids if rid not in matches]
print(f"direct_manifest_matches={len(matches)}/{len(resource_ids)}")
print(f"direct_unmatched={len(missing)}")
if missing:
    print("direct_unmatched_ids=" + ",".join(missing))

candidate_objects = set()
for rid, records in matches.items():
    for key, record in records:
        if isinstance(record, (list, tuple)) and len(record) >= 2:
            name = record[1]
            if isinstance(name, bytes):
                name = name.decode("utf-8", "replace")
            if isinstance(name, str):
                candidate_objects.add(name)

print(f"candidate_objects={len(candidate_objects)}")
failures = []
for name in sorted(candidate_objects):
    h = requests.head(
        f"{REMOTE_ROOT}/zh-android/{name}",
        allow_redirects=True,
        timeout=30,
    )
    print(f"HEAD {h.status_code} {name} len={h.headers.get('Content-Length')}")
    if h.status_code != 200:
        failures.append((name, h.status_code))
print("head_failures=" + repr(failures))

for rid in sorted(matches)[:30]:
    key, record = matches[rid][0]
    print(f"MATCH {rid}: key={key!r} record={record!r}")

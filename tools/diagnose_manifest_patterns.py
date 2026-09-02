#!/usr/bin/env python3
import requests
from msgpack import unpackb

ROOT='https://assets.rainbowunicorn7297.com'
MANIFEST='85822153578df611a4f852d4e02660f6f34401e4.data'
r=requests.get(f'{ROOT}/zh-android/{MANIFEST}', timeout=60)
r.raise_for_status()
table=unpackb(r.content, raw=False)[0]
keys=[str(k) for k in table.keys()]

patterns=['contact','fure_','card_','theater_','SR0053','har_SR','system_card','fhout_card']
for p in patterns:
    hits=[k for k in keys if p.lower() in k.lower()]
    print(f'PATTERN {p!r}: {len(hits)}')
    for k in hits[:80]:
        print(' ', k, '=>', table[k] if k in table else '')

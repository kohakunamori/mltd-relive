#!/usr/bin/env python3
import csv
from pathlib import Path
import requests
from msgpack import unpackb

ROOT='https://assets.rainbowunicorn7297.com'
MANIFEST='85822153578df611a4f852d4e02660f6f34401e4.data'

rows=[]
with Path('standalone/mltd/models/mst_data/mst_theater_contact.csv').open(encoding='utf-8', newline='') as f:
    for row in csv.DictReader(f):
        if row['resource_id']=='card_0000_contact':
            rows.append(row)
print('card_0000_contact rows=', len(rows))

r=requests.get(f'{ROOT}/zh-android/{MANIFEST}', timeout=60)
r.raise_for_status()
table=unpackb(r.content, raw=False)[0]

for row in rows[:80]:
    reaction=row['reaction_id']
    hits=[]
    for key, rec in table.items():
        if reaction in str(key) or reaction in repr(rec):
            hits.append((key,rec))
    print('reaction', reaction, 'mst_card_id', row['mst_card_id'], 'hits', len(hits))
    for key,rec in hits[:3]:
        print(' ', repr(key), repr(rec))

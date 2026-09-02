#!/usr/bin/env python3
from __future__ import annotations
import argparse,json
from pathlib import Path

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--bootstrap',type=Path,required=True); ap.add_argument('--start',required=True); ap.add_argument('--end',required=True); ap.add_argument('--out',type=Path,required=True)
    a=ap.parse_args(); lo=int(a.start,0); hi=int(a.end,0); rep=json.loads(a.bootstrap.read_text())
    calls={c['address']:c for c in rep.get('calls',[])}
    rows={}
    for b in rep.get('blocks',[]):
        if b.get('root_provenance')!='DT_INIT': continue
        for x in b.get('instructions',[]):
            if lo<=x['address']<hi: rows[x['address']]=x
    L=[f'# DT_INIT region `0x{lo:x}..0x{hi:x}`','', '```asm']
    prev=None
    for addr in sorted(rows):
        x=rows[addr]; suffix=''
        if prev is not None and addr!=prev+4: L.append(f'\n; ---- gap to 0x{addr:x} ----')
        c=calls.get(addr)
        if c:
            ts=c.get('target_symbols') or []
            near=c.get('target_nearest') or {}
            if ts: suffix=' ; -> '+','.join(ts)
            elif near: suffix=f" ; -> {near.get('name','?')}+0x{near.get('offset',0):x}"
        L.append(f"0x{addr:06x}: {x['mnemonic']:<8} {x['op_str']}{suffix}")
        prev=addr
    L += ['```','']
    a.out.parent.mkdir(parents=True,exist_ok=True); a.out.write_text('\n'.join(L)+'\n')
    print(json.dumps({'instructions':len(rows),'range':[hex(lo),hex(hi)]}))
if __name__=='__main__': main()

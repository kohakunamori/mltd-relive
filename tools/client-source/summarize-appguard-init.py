#!/usr/bin/env python3
from __future__ import annotations
import argparse,json
from pathlib import Path


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--bootstrap',type=Path,required=True);ap.add_argument('--loader-slice',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);ap.add_argument('--start',default='0x6a70');ap.add_argument('--end',default='0x7800')
    a=ap.parse_args();lo=int(a.start,0);hi=int(a.end,0)
    boot=json.loads(a.bootstrap.read_text()); sl=json.loads(a.loader_slice.read_text())
    plt={c['target']:c.get('plt_import') for c in sl.get('relevant_calls',[]) if c.get('plt_import')}
    calls={c['address']:c for c in boot.get('calls',[])}
    ins={}
    owners={}
    for b in boot.get('blocks',[]):
        if b.get('root_provenance')!='DT_INIT':continue
        for x in b.get('instructions',[]):
            if lo<=x['address']<hi:
                ins[x['address']]=x; owners[x['address']]=(b.get('owner') or {}).get('name','-')
    L=['# Annotated `DT_INIT` bootstrap region','',f'Range: `0x{lo:x}..0x{hi:x}`','', '```asm']
    prev=None
    for addr in sorted(ins):
        x=ins[addr]
        if prev is not None and addr!=prev+4:L.append(f'\n; ---- CFG gap to 0x{addr:x} ----')
        label=''
        c=calls.get(addr)
        if c:
            imp=plt.get(c.get('target'))
            ts=c.get('target_symbols') or []
            near=c.get('target_nearest') or {}
            if imp:label=f'    ; PLT -> {imp}'
            elif ts:label='    ; -> '+','.join(ts)
            elif near:label=f"    ; -> {near.get('name','?')}+0x{near.get('offset',0):x}"
        L.append(f"0x{addr:06x}: {x['mnemonic']:<8} {x['op_str']}{label}")
        prev=addr
    L += ['```','']
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'dt-init-region.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'range':[hex(lo),hex(hi)],'instructions':len(ins),'calls':sum(1 for x in ins if x in calls)},indent=2))
if __name__=='__main__':main()

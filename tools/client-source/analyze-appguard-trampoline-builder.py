#!/usr/bin/env python3
"""Analyze the exact DT_INIT builder that fills the 0x1000 RWX trampoline page.

Known exact-sample facts:
  * mmap result is moved to x20 at 0x7650;
  * x27 = x20 + w14 at 0x7eec;
  * x27 is stored into asmFunction slots 0x00..0x90.
This pass inventories every x14 update, x27-relative write, x20-relative write,
and control-flow edge in the builder region so per-slot trampoline offsets and
emitted instruction templates can be reconstructed rather than guessed.
"""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

REG = re.compile(r"\b[wx](\d+)\b")
MEM = re.compile(r"\[(x\d+|sp)(?:,\s*#([^\]]+))?\]", re.I)


def normreg(s: str) -> str:
    m=REG.fullmatch(s.strip())
    return 'x'+m.group(1) if m else s.strip()


def split_ops(s: str):
    out=[];buf=[];d=0
    for c in s:
        if c=='[':d+=1
        elif c==']':d-=1
        if c==',' and d==0:out.append(''.join(buf).strip());buf=[]
        else:buf.append(c)
    if buf:out.append(''.join(buf).strip())
    return out


def defines(ins, reg):
    m=ins['mnemonic'];ops=split_ops(ins.get('op_str',''))
    if not ops or m.startswith(('st','b','cb','tb')) or m in ('cmp','cmn','tst','ret'):return False
    if m.startswith('ldp'):return any(normreg(x)==reg for x in ops[:2])
    return normreg(ops[0])==reg


def mem_base(ins):
    mm=MEM.search(ins.get('op_str',''))
    return normreg(mm.group(1)) if mm else None


def context(flat,pc,r=7):
    idx=next((i for i,x in enumerate(flat) if int(x['address'])==pc),None)
    if idx is None:return []
    return flat[max(0,idx-r):min(len(flat),idx+r+1)]


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--bootstrap',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    boot=json.loads(a.bootstrap.read_text())
    lo,hi=0x7d80,0x89c0
    blocks=[]
    for b in boot.get('blocks',[]):
        if b.get('root_provenance')!='DT_INIT':continue
        ins=[i for i in b.get('instructions',[]) if lo<=int(i['address'])<hi]
        if ins:blocks.append({**b,'instructions':ins})
    # unique instructions by PC; same block may be present through duplicate trace paths.
    bypc={}
    for b in blocks:
        for ins in b['instructions']:bypc[int(ins['address'])]=ins
    flat=[bypc[x] for x in sorted(bypc)]

    x14_defs=[];x27_refs=[];x20_mem=[];stores=[];branches=[]
    for ins in flat:
        pc=int(ins['address']);m=ins['mnemonic'];base=mem_base(ins)
        if defines(ins,'x14'):x14_defs.append({'pc':pc,'instruction':ins,'context':context(flat,pc)})
        if 'x27' in [normreg(x) for x in REG.findall(ins.get('op_str',''))]:
            # REG.findall returns digits; fallback text check below is more reliable.
            pass
        if re.search(r'\b[wx]27\b',ins.get('op_str','')):
            x27_refs.append({'pc':pc,'instruction':ins,'context':context(flat,pc)})
        if base=='x20':x20_mem.append({'pc':pc,'instruction':ins,'context':context(flat,pc)})
        if m.startswith('st') and base in ('x27','x20'):
            stores.append({'pc':pc,'base':base,'instruction':ins,'context':context(flat,pc)})
        if m.startswith(('b','cb','tb')):
            branches.append({'pc':pc,'instruction':ins})

    # CFG edges among blocks in range.
    starts={int(b['start']) for b in blocks}
    edges=[]
    for b in blocks:
        st=int(b['start'])
        for d in b.get('successors',[]):
            d=int(d)
            if lo<=d<hi:edges.append({'from':st,'to':d})
    ed={(e['from'],e['to']):e for e in edges};edges=sorted(ed.values(),key=lambda e:(e['from'],e['to']))

    report={'range':[lo,hi],'instruction_count':len(flat),'x14_definitions':x14_defs,'x27_references':x27_refs,'x20_memory':x20_mem,'trampoline_stores':stores,'edges':edges}
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'trampoline-builder.json').write_text(json.dumps(report,indent=2)+'\n')
    L=['# AppGuard RWX trampoline builder','',f'Range: `0x{lo:x}..0x{hi:x}`',f'- unique instructions: **{len(flat)}**',f'- x14 definitions: **{len(x14_defs)}**',f'- x27 references: **{len(x27_refs)}**',f'- x20/x27 direct stores: **{len(stores)}**','', '## x14 offset-state definitions','']
    for e in x14_defs:L.append(f"- `0x{e['pc']:x}: {e['instruction']['mnemonic']} {e['instruction']['op_str']}`")
    L += ['', '## x27 references','']
    for e in x27_refs:L.append(f"- `0x{e['pc']:x}: {e['instruction']['mnemonic']} {e['instruction']['op_str']}`")
    L += ['', '## Direct stores into RWX page via x20/x27','']
    for e in stores:L.append(f"- `0x{e['pc']:x}: {e['instruction']['mnemonic']} {e['instruction']['op_str']}`")
    L += ['', '## Annotated builder region','', '```asm']
    storepcs={e['pc'] for e in stores};defpcs={e['pc'] for e in x14_defs};refpcs={e['pc'] for e in x27_refs}
    for ins in flat:
        pc=int(ins['address']);marks=[]
        if pc in defpcs:marks.append('x14-def')
        if pc in refpcs:marks.append('x27-ref')
        if pc in storepcs:marks.append('RWX-store')
        suffix=('  ; '+','.join(marks)) if marks else ''
        L.append(f"0x{pc:x}: {ins['mnemonic']} {ins['op_str']}{suffix}")
    L += ['```','', '## CFG edges inside builder range','']
    for e in edges:L.append(f"- `0x{e['from']:x} -> 0x{e['to']:x}`")
    (a.out/'trampoline-builder.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'instructions':len(flat),'x14_defs':len(x14_defs),'x27_refs':len(x27_refs),'stores':len(stores),'edges':len(edges)},indent=2))
if __name__=='__main__':main()

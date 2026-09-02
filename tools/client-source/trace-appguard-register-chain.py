#!/usr/bin/env python3
"""Recursively recover register provenance for AppGuard trampoline addresses.

Seeds are the two address expressions already proven to populate asmFunction:
  0x7eec: add x27, x20, w14, uxtw
  0xc2240: add x19, x14, w12, uxtw #2
The slicer walks backwards through normal CFG and direct-call entry edges, finds
nearest definitions of each source register, then recursively slices the source
registers of those definitions.  This exposes the code-pool bases and indices
without requiring the opaque state machine to evaluate to concrete constants.
"""
from __future__ import annotations

import argparse
import json
import re
from collections import defaultdict, deque
from pathlib import Path

REG_RE = re.compile(r"^[xw](\d+)$")


def norm(s: str) -> str:
    s=s.strip();m=REG_RE.match(s)
    return 'x'+m.group(1) if m else s


def split_ops(text: str):
    out=[];buf=[];depth=0
    for ch in text:
        if ch=='[':depth+=1
        elif ch==']':depth-=1
        if ch==',' and depth==0:
            out.append(''.join(buf).strip());buf=[]
        else:buf.append(ch)
    if buf:out.append(''.join(buf).strip())
    return out


def defined_regs(ins: dict) -> set[str]:
    m=ins.get('mnemonic','');ops=split_ops(ins.get('op_str',''))
    if not ops or m.startswith(('st','b','cb','tb')) or m in ('cmp','cmn','tst','ret'):
        return set()
    if m.startswith('ldp'):
        return {norm(x) for x in ops[:2] if REG_RE.match(x)}
    return {norm(ops[0])} if REG_RE.match(ops[0]) else set()


def source_regs(ins: dict) -> list[str]:
    m=ins.get('mnemonic','');ops=split_ops(ins.get('op_str',''))
    regs=[]
    def add_token(tok):
        for x in re.findall(r'\b[wx]\d+\b',tok):
            r=norm(x)
            if r not in regs:regs.append(r)
    # exclude destination operand for ordinary defining instructions
    start=1 if defined_regs(ins) else 0
    for tok in ops[start:]:add_token(tok)
    # stores use first operand as source and memory base(s)
    if m.startswith('st'):
        for tok in ops:add_token(tok)
    return regs


def ctx(insns,idx,r=6):return insns[max(0,idx-r):min(len(insns),idx+r+1)]


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--bootstrap',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    boot=json.loads(a.bootstrap.read_text())
    blocks={int(b['start']):b for b in boot.get('blocks',[]) if b.get('root_provenance')=='DT_INIT'}
    loc={}
    for st,b in blocks.items():
        for i,ins in enumerate(b.get('instructions',[])):loc[int(ins['address'])]=(st,i)
    preds=defaultdict(list)
    for st,b in blocks.items():
        for d in b.get('successors',[]):
            d=int(d)
            if d in blocks:preds[d].append({'block':st,'kind':'cfg','callsite':None})
    for c in boot.get('calls',[]):
        if c.get('root_provenance')!='DT_INIT' or c.get('target') is None:continue
        pc,d=int(c['address']),int(c['target'])
        if pc in loc and d in blocks:
            preds[d].append({'block':loc[pc][0],'kind':'call','callsite':pc})

    def nearest_defs(use_pc:int,reg:str,max_edges=40):
        reg=norm(reg)
        if use_pc not in loc:return []
        st,idx=loc[use_pc];insns=blocks[st].get('instructions',[])
        for j in range(idx-1,-1,-1):
            if reg in defined_regs(insns[j]):
                return [{'pc':int(insns[j]['address']),'block':st,'distance':0,'path':[],'instruction':insns[j],'context':ctx(insns,j)}]
        q=deque([(st,[])]);seen={st};found=[];best=None
        while q:
            cur,path=q.popleft();dep=len(path)
            if dep>=max_edges or (best is not None and dep>best+2):continue
            for e in preds.get(cur,[]):
                pb=int(e['block']);key=(pb,e['kind'],e.get('callsite'))
                if pb in seen:continue
                seen.add(pb);pp=path+[{'from':pb,'to':cur,**e}]
                pins=blocks[pb].get('instructions',[]);limit=len(pins)
                if e['kind']=='call' and e.get('callsite') is not None:
                    for j,ii in enumerate(pins):
                        if int(ii['address'])==int(e['callsite']):limit=j;break
                hit=None
                for j in range(limit-1,-1,-1):
                    if reg in defined_regs(pins[j]):hit=(j,pins[j]);break
                if hit:
                    j,ii=hit;d=len(pp);best=d if best is None else min(best,d)
                    found.append({'pc':int(ii['address']),'block':pb,'distance':d,'path':pp,'instruction':ii,'context':ctx(pins,j)})
                else:q.append((pb,pp))
        dd={(x['pc'],x['distance']):x for x in found}
        return sorted(dd.values(),key=lambda x:(x['distance'],x['pc']))[:12]

    seeds=[
        {'name':'asmFunction slots 0x00..0x90','use_pc':0x7eec,'registers':['x20','x14']},
        {'name':'asmFunction slots 0x98/0xa0','use_pc':0xc2240,'registers':['x14','x12']},
    ]
    nodes={};edges=[];queue=deque();
    for seed in seeds:
        for r in seed['registers']:queue.append((seed['use_pc'],norm(r),0,seed['name']))
    seen=set()
    while queue:
        use,reg,depth,root=queue.popleft();key=(use,reg,root)
        if key in seen or depth>7:continue
        seen.add(key);defs=nearest_defs(use,reg)
        nodekey=f'{root}|0x{use:x}|{reg}'
        nodes[nodekey]={'root':root,'use_pc':use,'reg':reg,'depth':depth,'definitions':defs}
        for d in defs[:4]:
            srcs=[r for r in source_regs(d['instruction']) if r!=reg]
            edges.append({'root':root,'use_pc':use,'reg':reg,'def_pc':d['pc'],'sources':srcs})
            for sr in srcs:queue.append((d['pc'],sr,depth+1,root))
    report={'seeds':seeds,'nodes':list(nodes.values()),'edges':edges}
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'asmfunction-provenance.json').write_text(json.dumps(report,indent=2)+'\n')
    L=['# AppGuard `asmFunction` address provenance','']
    for seed in seeds:
        L += [f"## {seed['name']}",'',f"Seed instruction: `0x{seed['use_pc']:x}`",'']
        related=sorted((n for n in nodes.values() if n['root']==seed['name']),key=lambda n:(n['depth'],n['use_pc'],n['reg']))
        for n in related:
            defs=n['definitions'];dt='; '.join(f"0x{d['pc']:x}: {d['instruction']['mnemonic']} {d['instruction']['op_str']} (edges={d['distance']})" for d in defs[:5]) or 'unresolved'
            L.append(f"- depth {n['depth']} use `0x{n['use_pc']:x}` `{n['reg']}` <- {dt}")
        L.append('')
    # Detail the first few levels with context.
    for n in sorted(nodes.values(),key=lambda n:(n['root'],n['depth'],n['use_pc'],n['reg'])):
        if n['depth']>3 or not n['definitions']:continue
        L += [f"### {n['root']}: `{n['reg']}` used at `0x{n['use_pc']:x}`",'']
        for d in n['definitions'][:3]:
            L += [f"Definition `0x{d['pc']:x}`:",'```asm']
            for ii in d['context']:
                mark='  ; <-- definition' if int(ii['address'])==d['pc'] else ''
                L.append(f"0x{int(ii['address']):x}: {ii['mnemonic']} {ii['op_str']}{mark}")
            L += ['```','']
    (a.out/'asmfunction-provenance.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'nodes':len(nodes),'edges':len(edges),'max_depth':max((n['depth'] for n in nodes.values()),default=0)},indent=2))
if __name__=='__main__':main()

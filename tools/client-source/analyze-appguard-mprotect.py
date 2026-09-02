#!/usr/bin/env python3
"""Slice bootstrap CFG around mprotect calls and recover x0/x1/x2 when possible."""
from __future__ import annotations

import argparse,json,re
from collections import defaultdict,deque
from pathlib import Path

REG=re.compile(r'^[xw](\d+)$')


def xr(r):
    m=REG.match(r.strip())
    return 'x'+m.group(1) if m else r.strip()

def num(s):
    try:return int(s.strip().lstrip('#'),0)
    except:return None

def ops(s):return [x.strip() for x in s.split(',')]


def apply(ins,regs):
    m=ins['mnemonic']; o=ops(ins['op_str'])
    def kill(d):
        if REG.match(d):regs.pop(xr(d),None)
    if m in ('adr','adrp') and len(o)>=2 and REG.match(o[0]):
        v=num(o[1]);
        if v is not None:regs[xr(o[0])]=v
    elif m in ('mov','movz') and len(o)>=2 and REG.match(o[0]):
        d=xr(o[0])
        if REG.match(o[1]):
            s=xr(o[1]); regs[d]=regs[s] if s in regs else None
            if regs[d] is None:regs.pop(d,None)
        else:
            v=num(o[1]);
            if v is not None:regs[d]=v
            else:kill(o[0])
    elif m=='movk' and len(o)>=2 and REG.match(o[0]):
        d=xr(o[0]); v=num(o[1]); shift=0
        if len(o)>=3 and 'lsl' in o[2]: shift=num(o[2].split('#')[-1]) or 0
        if d in regs and v is not None:
            mask=0xffff<<shift;regs[d]=(regs[d]&~mask)|((v&0xffff)<<shift)
        else:kill(o[0])
    elif m in ('add','sub') and len(o)>=3 and REG.match(o[0]) and REG.match(o[1]):
        d=xr(o[0]);s=xr(o[1]);v=num(o[2])
        if s in regs and v is not None:regs[d]=regs[s]+(v if m=='add' else -v)
        else:kill(o[0])
    elif m in ('orr','eor','and') and len(o)>=3 and REG.match(o[0]) and REG.match(o[1]):
        d=xr(o[0]);s=xr(o[1]);v=num(o[2])
        if s in regs and v is not None:
            regs[d]={'orr':regs[s]|v,'eor':regs[s]^v,'and':regs[s]&v}[m]
        else:kill(o[0])
    elif m.startswith('ldr') and o and REG.match(o[0]):kill(o[0])
    elif o and REG.match(o[0]) and m not in ('cmp','cmn','tst','cbz','cbnz','tbz','tbnz','str','stp','b','bl','ret','br','blr') and not m.startswith('b.'):
        kill(o[0])


def format_regs(r):
    return ', '.join(f'{k}=0x{v:x}' for k,v in sorted(r.items()) if k in ('x0','x1','x2')) or 'unknown'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--bootstrap',type=Path,required=True);ap.add_argument('--loader-slice',type=Path,required=True);ap.add_argument('--out',type=Path,required=True)
    a=ap.parse_args();boot=json.loads(a.bootstrap.read_text());sl=json.loads(a.loader_slice.read_text())
    mpcalls={c['address']:c for c in sl.get('key_import_calls',[]) if c.get('plt_import')=='mprotect'}
    blocks=boot['blocks'];by_start={b['start']:b for b in blocks};addr_block={}
    preds=defaultdict(list)
    for b in blocks:
        for i in b.get('instructions',[]):addr_block[i['address']]=b
        for s in b.get('successors',[]):preds[s].append(b['start'])
    results=[]
    for ca,c in sorted(mpcalls.items()):
        b=addr_block.get(ca)
        if not b:continue
        # enumerate short predecessor paths (max 3 blocks) ending at current block.
        paths=[]
        q=deque([([b['start']],b['start'])])
        while q and len(paths)<32:
            path,cur=q.popleft(); ps=preds.get(cur,[])
            if len(path)>=3 or not ps:
                paths.append(list(reversed(path)));continue
            for p in ps[:8]:q.append((path+[p],p))
        path_results=[]
        for path in paths:
            regs={};trace=[];hit=False
            for bs in path:
                bb=by_start[bs]
                for ins in bb.get('instructions',[]):
                    if ins['address']==ca:
                        trace.append({'address':ca,'text':f"{ins['mnemonic']} {ins['op_str']}",'args_before':{k:regs.get(k) for k in ('x0','x1','x2')}});hit=True;break
                    apply(ins,regs)
                    if bs==b['start'] or ins['address']>=ca-48:
                        trace.append({'address':ins['address'],'text':f"{ins['mnemonic']} {ins['op_str']}"})
                if hit:break
            args=trace[-1].get('args_before',{}) if trace and hit else {}
            path_results.append({'path':[hex(x) for x in path],'args':args,'trace':trace[-36:]})
        # consensus constants across paths
        consensus={}
        for r in ('x0','x1','x2'):
            vals={p['args'].get(r) for p in path_results if p['args'].get(r) is not None}
            if len(vals)==1:consensus[r]=next(iter(vals))
        results.append({'callsite':ca,'root':c.get('root_provenance'),'block':b['start'],'consensus':consensus,'paths':path_results})
    report={'mprotect_calls':results}
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'mprotect-slice.json').write_text(json.dumps(report,indent=2)+'\n')
    L=['# Bootstrap `mprotect` argument slices','']
    for r in results:
        L += [f"## call `0x{r['callsite']:x}` (block `0x{r['block']:x}`)",'',f"Consensus: **{format_regs(r['consensus'])}**",'']
        for idx,p in enumerate(r['paths'][:8],1):
            av={k:v for k,v in p['args'].items() if v is not None}
            L += [f"### predecessor path {idx}: {' -> '.join(p['path'])}",'',f"Arguments before BL: `{format_regs(av)}`",'','```asm']
            for t in p['trace']:L.append(f"0x{t['address']:x}: {t['text']}")
            L += ['```','']
    (a.out/'mprotect-slice.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'calls':len(results),'consensus':[{'callsite':hex(x['callsite']),**{k:hex(v) for k,v in x['consensus'].items()}} for x in results]},indent=2))
if __name__=='__main__':main()

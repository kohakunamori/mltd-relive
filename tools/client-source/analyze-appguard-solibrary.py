#!/usr/bin/env python3
"""Recursive CFG rooted at the real exported SoLibraryStart entry.

Unlike DT_INIT, SoLibraryStart is the API used by protected child modules to ask
libcompatible to restore/decompress/relocate them. This pass traces that exact
sample-specific entry and labels recovered PLT imports from loader-slice.json.
"""
from __future__ import annotations

import argparse,bisect,hashlib,json
from collections import Counter,defaultdict,deque
from pathlib import Path
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

MAX_BLOCKS=30000
MAX_INSNS=180000
MAX_DEPTH=16


def sha256(p):
    h=hashlib.sha256()
    with open(p,'rb') as f:
        for b in iter(lambda:f.read(1<<20),b''):h.update(b)
    return h.hexdigest()

class Img:
    def __init__(self,segs):self.segs=segs
    def exec(self,a):return any((s['flags']&1) and s['va']<=a<s['va']+s['filesz'] for s in self.segs)
    def read(self,a,n):
        for s in self.segs:
            if s['va']<=a<a+s['filesz'] and a+n<=s['va']+s['filesz']:
                o=a-s['va'];return s['data'][o:o+n]
        return b''
    def off(self,a):
        for s in self.segs:
            if s['va']<=a<s['va']+s['filesz']:return s['off']+a-s['va']
        return None

def load(path):
    with open(path,'rb') as f:
        e=ELFFile(f);segs=[];syms=[]
        for s in e.iter_segments():
            if str(s['p_type'])=='PT_LOAD':segs.append({'va':int(s['p_vaddr']),'off':int(s['p_offset']),'filesz':int(s['p_filesz']),'flags':int(s['p_flags']),'data':s.data()})
        for sec in e.iter_sections():
            if isinstance(sec,SymbolTableSection):
                for x in sec.iter_symbols():
                    if x.name and x['st_shndx']!='SHN_UNDEF' and int(x['st_value']):syms.append({'name':x.name,'address':int(x['st_value']),'size':int(x['st_size'])})
    return Img(segs),syms

def symhelpers(syms):
    by=defaultdict(list)
    for s in syms:by[s['address']].append(s)
    addrs=sorted(by)
    def exact(a):return sorted(x['name'] for x in by.get(a,[]))
    def near(a):
        i=bisect.bisect_right(addrs,a)-1
        if i<0:return None
        st=addrs[i];r=max(by[st],key=lambda x:x['size']);return {'name':r['name'],'start':st,'offset':a-st,'size':r['size']}
    return exact,near

def target(ins):
    for o in reversed(ins.operands):
        if o.type==ARM64_OP_IMM:return int(o.imm)
    return None

def trace(path,plt):
    img,syms=load(path);exact,near=symhelpers(syms)
    roots=[s for s in syms if s['name']=='SoLibraryStart']
    if not roots:raise SystemExit('SoLibraryStart not found')
    root=roots[0]['address']
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True
    q=deque([(root,0)]);visited=set();blocks=[];calls=[];udf=[];invalid=[];insn_count=0
    while q and len(blocks)<MAX_BLOCKS and insn_count<MAX_INSNS:
        start,depth=q.popleft()
        if start in visited or not img.exec(start) or start%4:continue
        visited.add(start);pc=start;rows=[];succ=[];term=None
        for _ in range(1024):
            raw=img.read(pc,4)
            if len(raw)!=4:term='unmapped';break
            ds=list(md.disasm(raw,pc,count=1))
            if not ds:
                invalid.append({'address':pc,'file_offset':img.off(pc),'owner':near(pc),'depth':depth});term='invalid';break
            ins=ds[0];insn_count+=1
            row={'address':pc,'file_offset':img.off(pc),'mnemonic':ins.mnemonic,'op_str':ins.op_str}
            ex=exact(pc)
            if ex:row['symbols']=ex
            rows.append(row);m=ins.mnemonic;t=target(ins)
            if m=='bl':
                imp=plt.get(hex(t)) if t is not None else None
                calls.append({'address':pc,'file_offset':img.off(pc),'target':t,'target_symbols':exact(t) if t is not None else [],'target_nearest':near(t) if t is not None else None,'plt_import':imp,'owner':near(pc),'depth':depth})
                if t is not None and img.exec(t) and not imp and depth<MAX_DEPTH:q.append((t,depth+1))
                pc+=4;continue
            if m=='b':
                if t is not None and img.exec(t):succ.append(t);q.append((t,depth))
                term='b';break
            if m.startswith('b.') or m in ('cbz','cbnz','tbz','tbnz'):
                if t is not None and img.exec(t):succ.append(t);q.append((t,depth))
                ft=pc+4
                if img.exec(ft):succ.append(ft);q.append((ft,depth))
                term=m;break
            if m in ('ret','br','blr'):
                term=m;break
            if m=='udf':
                udf.append({'address':pc,'owner':near(pc),'depth':depth});term='udf';break
            pc+=4
        blocks.append({'start':start,'owner':near(start),'depth':depth,'instructions':rows,'termination':term,'successors':sorted(set(succ))})
    imports=Counter(c['plt_import'] for c in calls if c.get('plt_import'))
    return {'sample_sha256':sha256(path),'SoLibraryStart':root,'blocks':blocks,'calls':calls,'import_call_counts':dict(imports.most_common()),'udf_sites':udf,'invalid_sites':invalid,'stats':{'blocks':len(blocks),'instructions':insn_count,'calls':len(calls),'udf':len(udf),'invalid':len(invalid)}}

def mdout(r):
    L=['# `SoLibraryStart` recursive CFG','',f"- entry: `0x{r['SoLibraryStart']:x}`",f"- blocks: **{r['stats']['blocks']}**",f"- instructions: **{r['stats']['instructions']}**",f"- direct calls: **{r['stats']['calls']}**",f"- UDF boundaries: **{r['stats']['udf']}**",f"- invalid boundaries: **{r['stats']['invalid']}**",'', '## Imported functions reached','', '| Import | Calls |','|---|---:|']
    for n,c in r['import_call_counts'].items():L.append(f'| `{n}` | {c} |')
    L += ['','## Direct calls','', '| Callsite | Depth | Owner | Target | Target label | Import |','|---:|---:|---|---:|---|---|']
    for c in r['calls'][:800]:
        own=(c.get('owner') or {}).get('name','-');names=c.get('target_symbols') or [];near=c.get('target_nearest') or {}
        label=','.join(names) if names else (near.get('name','-')+(f"+0x{near.get('offset',0):x}" if near else ''))
        L.append(f"| `0x{c['address']:x}` | {c['depth']} | `{own}` | `{hex(c['target']) if c['target'] is not None else '-'}` | `{label}` | `{c.get('plt_import') or '-'}` |")
    L += ['','## First code blocks','']
    for b in sorted(r['blocks'],key=lambda x:(x['depth'],x['start']))[:80]:
        L += [f"### block `0x{b['start']:x}` depth {b['depth']} ({b['termination']})",'', '```asm']
        for i in b['instructions'][:80]:L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
        L += ['```','']
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--loader-slice',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    sl=json.loads(a.loader_slice.read_text());plt={k:v['symbol'] for k,v in sl.get('plt_stubs',{}).items()}
    r=trace(a.libcompatible,plt);a.out.mkdir(parents=True,exist_ok=True);(a.out/'solibrary-cfg.json').write_text(json.dumps(r,indent=2)+'\n');(a.out/'solibrary-cfg.md').write_text(mdout(r))
    print(json.dumps({'entry':hex(r['SoLibraryStart']),**r['stats'],'imports':r['import_call_counts']},indent=2))
if __name__=='__main__':main()

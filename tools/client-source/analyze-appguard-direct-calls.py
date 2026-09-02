#!/usr/bin/env python3
"""Raw AArch64 BL scanner for AppGuard's section-obfuscated executable segments.

Capstone linear sweep stops when packed data/invalid instructions are embedded in an
executable PT_LOAD. AArch64 instructions are fixed-width, so this tool scans every
4-byte word for direct BL encodings and resolves targets against exported asm_*
wrapper symbols. It also disassembles each wrapper from its exact symbol address.
"""
from __future__ import annotations

import argparse
import bisect
import hashlib
import json
from collections import defaultdict
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

WEIGHTS = {
    'asm_openat': 5,
    'asm_read': 5,
    'asm_lseek': 4,
    'asm_mmap2': 6,
    'asm_mprotect': 6,
    'asm_munmap': 2,
    'asm_close': 1,
    'asm_fstatat': 2,
    'asm_readlink_64': 1,
    'asm_ptrace': -5,
    'asm_prctl': -2,
    'asm_kill': -2,
}


def sha256(p: Path) -> str:
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1<<20),b''):
            h.update(b)
    return h.hexdigest()


def symbols(elf: ELFFile):
    rows=[]
    for sec in elf.iter_sections():
        if not isinstance(sec, SymbolTableSection):
            continue
        for s in sec.iter_symbols():
            name=s.name
            if not name or s['st_shndx']=='SHN_UNDEF':
                continue
            addr=int(s['st_value'])
            if not addr:
                continue
            rows.append({'name':name,'address':addr,'size':int(s['st_size']),'type':str(s['st_info']['type'])})
    # dedupe exact name/address pairs
    d={(r['address'],r['name']):r for r in rows}
    return sorted(d.values(),key=lambda r:(r['address'],r['name']))


def exec_segments(elf: ELFFile):
    out=[]
    for seg in elf.iter_segments():
        if str(seg['p_type'])=='PT_LOAD' and (int(seg['p_flags']) & 1):
            out.append({'vaddr':int(seg['p_vaddr']),'offset':int(seg['p_offset']),'data':seg.data()})
    return out


def signext(v:int,bits:int)->int:
    sign=1<<(bits-1)
    return (v & (sign-1)) - (v & sign)


def decode_bl(word:int,pc:int):
    if (word & 0xFC000000) != 0x94000000:
        return None
    imm26=word & 0x03FFFFFF
    return pc + (signext(imm26,26) << 2)


def owner_index(funcs):
    grouped=defaultdict(list)
    for f in funcs:
        if f['type'] in ('STT_FUNC','STT_NOTYPE'):
            grouped[f['address']].append(f)
    pairs=[]
    for addr,rs in grouped.items():
        rs.sort(key=lambda x:(x['name'].startswith('asm_'),-x['size'],x['name']))
        pairs.append((addr,rs[0]))
    pairs.sort()
    addrs=[a for a,_ in pairs]
    def lookup(addr):
        i=bisect.bisect_right(addrs,addr)-1
        if i<0:return None
        start,row=pairs[i]
        return {'name':row['name'],'start':start,'offset':addr-start,'size':row['size']}
    return lookup


def bytes_at(segments,addr,n=64):
    for seg in segments:
        start=seg['vaddr']; end=start+len(seg['data'])
        if start <= addr < end:
            off=addr-start
            return seg['data'][off:off+n]
    return b''


def disasm_snippet(md,segments,addr,n=12):
    data=bytes_at(segments,addr,64)
    if not data:return []
    md.skipdata=True
    return [f"0x{i.address:x}: {i.mnemonic} {i.op_str}".rstrip() for i in md.disasm(data,addr,count=n)]


def analyze(path:Path):
    with path.open('rb') as f:
        elf=ELFFile(f)
        if str(elf['e_machine'])!='EM_AARCH64':
            return {'name':path.name,'skipped':'not AArch64'}
        funcs=symbols(elf); segs=exec_segments(elf); entry=int(elf['e_entry'])
    asm={f['address']:f['name'] for f in funcs if f['name'].startswith('asm_')}
    owner=owner_index(funcs)
    calls=[]
    by_owner=defaultdict(lambda:defaultdict(list))
    for seg in segs:
        data=seg['data']; base=seg['vaddr']
        start_align=(-base) & 3
        for i in range(start_align,len(data)-3,4):
            word=int.from_bytes(data[i:i+4],'little')
            pc=base+i
            target=decode_bl(word,pc)
            name=asm.get(target) if target is not None else None
            if not name:continue
            own=owner(pc)
            row={'address':pc,'file_offset':seg['offset']+i,'target':target,'target_symbol':name,'owner':own}
            calls.append(row)
            on=own['name'] if own else f'sub_{pc:x}'
            by_owner[on][name].append(pc)
    candidates=[]
    for on,targets in by_owner.items():
        names=set(targets)
        positive=sum(max(0,WEIGHTS.get(x,0)) for x in names)
        negative=sum(min(0,WEIGHTS.get(x,0)) for x in names)
        # Prefer functions containing the classic loader tuple rather than antidebug-only functions.
        tuple_bonus=10 if {'asm_read','asm_mmap2'} <= names else 0
        file_bonus=8 if ({'asm_openat','asm_read'} <= names or {'asm_lseek','asm_read'} <= names) else 0
        score=positive+negative+tuple_bonus+file_bonus
        if positive:
            candidates.append({'function':on,'score':score,'wrappers':sorted(names),'callsites':dict(sorted(targets.items()))})
    candidates.sort(key=lambda r:(-r['score'],-len(r['wrappers']),r['function']))
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    wrappers={}
    for addr,name in sorted(asm.items(),key=lambda x:x[1]):
        wrappers[name]={'address':addr,'instructions':disasm_snippet(md,segs,addr)}
    # Add local context around the highest-value direct callsites only.
    for row in calls:
        if WEIGHTS.get(row['target_symbol'],0) >= 4:
            row['context']=disasm_snippet(md,segs,max(row['address']-24,0),14)
    return {
        'name':path.name,'sha256':sha256(path),'size':path.stat().st_size,'entry':entry,
        'asm_wrappers':wrappers,'direct_calls':calls,'loader_candidates':candidates[:100]
    }


def markdown(reports):
    L=['# Raw AArch64 AppGuard direct-call map','',
       'This pass scans fixed-width AArch64 BL encodings across executable PT_LOAD bytes, including regions that break linear disassemblers.','']
    for r in reports:
        L += [f"## `{r['name']}`",'']
        if r.get('skipped'):
            L += [r['skipped'],'']; continue
        L += [f"- resolved direct calls into `asm_*`: **{len(r['direct_calls'])}**",
              f"- ranked loader-like caller functions: **{len(r['loader_candidates'])}**",'',
              '### Wrapper code','', '| Wrapper | Address | Code |','|---|---:|---|']
        for name,w in sorted(r['asm_wrappers'].items()):
            code='; '.join(w['instructions'][:6]).replace('|','\\|')
            L.append(f"| `{name}` | `0x{w['address']:x}` | `{code}` |")
        L += ['','### Loader candidates','', '| Score | Function | Calls |','|---:|---|---|']
        for c in r['loader_candidates'][:40]:
            L.append(f"| {c['score']} | `{c['function']}` | {', '.join('`'+x+'`' for x in c['wrappers'])} |")
        L += ['','### Direct calls','', '| Callsite | Owner | Target |','|---:|---|---|']
        for c in r['direct_calls'][:300]:
            own=c['owner']['name'] if c['owner'] else '-'
            L.append(f"| `0x{c['address']:x}` | `{own}` | `{c['target_symbol']}` |")
        L.append('')
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--native-dir',type=Path,required=True);ap.add_argument('--out',type=Path,required=True)
    a=ap.parse_args(); reports=[]
    for n in ('libcompatible.so','libstub.so'):
        p=a.native_dir/n
        if p.exists():reports.append(analyze(p))
    a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'direct-call-map.json').write_text(json.dumps(reports,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
    (a.out/'direct-call-map.md').write_text(markdown(reports),encoding='utf-8')
    print(json.dumps({r['name']:{'calls':len(r.get('direct_calls',[])),'candidates':len(r.get('loader_candidates',[]))} for r in reports},indent=2))

if __name__=='__main__':main()

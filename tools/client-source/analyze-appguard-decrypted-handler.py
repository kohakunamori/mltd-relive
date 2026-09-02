#!/usr/bin/env python3
"""Analyze the runtime-decrypted AppGuard handler table and code region.

Runs the exact Bionic bootstrap until +0x4d000..+0x52000 is stable, then:
* dumps/labels qwords around the mmap descriptor table that contains two exact
  pointers to +0x4d1d0;
* resolves libcompatible pointers to symbols/PLT imports where possible;
* disassembles the entire decrypted 0x5000-byte region instruction-by-instruction;
* records direct BL/B targets, indirect branches, references to protected helper
  addresses (+0x1cd4c/+0x1cd84), and references to the descriptor table;
* extracts a focused CFG-ish instruction window for +0x4d1d0 and +0x521fc.
"""
from __future__ import annotations

import argparse,bisect,hashlib,importlib.util,json,struct
from collections import Counter,defaultdict
from pathlib import Path

from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM,ARM64_OP_MEM,ARM64_OP_REG
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('bionic_emu',P)
bionic=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(bionic)
base=bionic.base
RUN_LIMIT=9_000_000
base.MAX_INSNS=RUN_LIMIT
DEC_LO=0x4D000;DEC_HI=0x52000
HANDLER=0x4D1D0
TAIL=0x521FC
PROTECTED=(0x1CD4C,0x1CD84)


def load_symbols(path:Path):
    syms=[];pltmap={}
    with path.open('rb') as f:
        e=ELFFile(f)
        for sec in e.iter_sections():
            if isinstance(sec,SymbolTableSection):
                for s in sec.iter_symbols():
                    if s.name and s['st_shndx']!='SHN_UNDEF' and int(s['st_value']):
                        syms.append({'name':s.name,'address':int(s['st_value']),'size':int(s['st_size'])})
        plt=e.get_section_by_name('.plt');rela=e.get_section_by_name('.rela.plt');dyn=e.get_section_by_name('.dynsym')
        if plt is not None and rela is not None and dyn is not None:
            pbase=int(plt['sh_addr'])
            for i,r in enumerate(rela.iter_relocations()):
                idx=int(r.entry.r_info_sym);name=dyn.get_symbol(idx).name if idx else ''
                if name:pltmap[pbase+32+16*i]=name
    by=defaultdict(list)
    for s in syms:by[s['address']].append(s)
    addrs=sorted(by)
    def label(rel):
        if rel in pltmap:return {'kind':'plt','name':pltmap[rel],'address':rel,'offset':0}
        if rel in by:return {'kind':'symbol','name':by[rel][0]['name'],'address':rel,'offset':0}
        i=bisect.bisect_right(addrs,rel)-1
        if i>=0:
            a=addrs[i];s=max(by[a],key=lambda x:x['size'])
            if not s['size'] or rel<a+s['size']:
                return {'kind':'nearest','name':s['name'],'address':a,'offset':rel-a}
        return None
    return label,pltmap


def qword_table(emu,label):
    lo=base.MMAP_BASE+0x1800;hi=min(emu.mmap_next,base.MMAP_BASE+0x3800)
    raw=bytes(emu.uc.mem_read(lo,hi-lo));rows=[]
    for off in range(0,len(raw)-7,8):
        v=struct.unpack_from('<Q',raw,off)[0]
        cls='integer';lab=None
        if base.BIAS<=v<base.BIAS+0x4000000:
            rel=v-base.BIAS;cls='libcompatible';lab=label(rel)
        elif base.MMAP_BASE<=v<base.MMAP_BASE+base.MMAP_SIZE:cls='mmap'
        elif base.HEAP_BASE<=v<base.HEAP_BASE+base.HEAP_SIZE:cls='heap'
        elif base.STACK_BASE<=v<base.STACK_BASE+base.STACK_SIZE:cls='stack'
        else:rel=None
        if v or 0x1000<=off<=0x1200:
            rows.append({'storage':lo+off,'mmap_offset':lo+off-base.MMAP_BASE,'value':v,'class':cls,'target_rel':rel if cls=='libcompatible' else None,'label':lab})
    return rows


def decode_runtime(emu,label,pltmap):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True
    raw=bytes(emu.uc.mem_read(base.BIAS+DEC_LO,DEC_HI-DEC_LO))
    ins=[];calls=[];branches=[];indirect=[];protected_refs=[]
    for off in range(0,len(raw)-3,4):
        rel=DEC_LO+off;ds=list(md.disasm(raw[off:off+4],rel,count=1))
        if not ds:
            ins.append({'address':rel,'mnemonic':'.word','op_str':f'0x{int.from_bytes(raw[off:off+4],"little"):08x}'})
            continue
        i=ds[0];row={'address':rel,'mnemonic':i.mnemonic,'op_str':i.op_str};ins.append(row)
        if i.mnemonic in ('bl','b') or i.mnemonic.startswith('b.') or i.mnemonic in ('cbz','cbnz','tbz','tbnz'):
            target=None
            for op in reversed(i.operands):
                if op.type==ARM64_OP_IMM:target=int(op.imm);break
            if target is not None:
                rec={'address':rel,'mnemonic':i.mnemonic,'target':target,'target_label':label(target),'target_import':pltmap.get(target)}
                (calls if i.mnemonic=='bl' else branches).append(rec)
                if any(abs(target-p)<0x100 for p in PROTECTED):protected_refs.append(rec)
        if i.mnemonic in ('br','blr','ret'):
            indirect.append({'address':rel,'mnemonic':i.mnemonic,'op_str':i.op_str})
        # raw immediates that equal/near protected addresses.
        for op in i.operands:
            if op.type==ARM64_OP_IMM:
                v=int(op.imm)
                if any(abs(v-p)<0x100 for p in PROTECTED):
                    protected_refs.append({'address':rel,'mnemonic':i.mnemonic,'target':v,'target_label':label(v),'source':'immediate'})
    return {'sha256':hashlib.sha256(raw).hexdigest(),'instructions':ins,'calls':calls,'branches':branches,'indirect':indirect,'protected_refs':protected_refs}


def window(emu,start,size=0x900):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True
    try:raw=bytes(emu.uc.mem_read(base.BIAS+start,size))
    except Exception:return []
    rows=[]
    for off in range(0,len(raw)-3,4):
        ds=list(md.disasm(raw[off:off+4],start+off,count=1))
        if ds:rows.append({'address':start+off,'mnemonic':ds[0].mnemonic,'op_str':ds[0].op_str})
        else:rows.append({'address':start+off,'mnemonic':'.word','op_str':f'0x{int.from_bytes(raw[off:off+4],"little"):08x}'})
    return rows


def render(r):
    L=['# Runtime-decrypted AppGuard handler/table analysis','',f"- bootstrap stop: `{r['runtime_stop']}`",f"- runtime instructions: **{r['runtime_instructions']}**",f"- decrypted SHA-256: `{r['decrypted']['sha256']}`",f"- direct BLs in decrypted region: **{len(r['decrypted']['calls'])}**",f"- protected-helper references: **{len(r['decrypted']['protected_refs'])}**",'', '## mmap descriptor qwords','', '| storage | mmap + | value | class | rel / label |','|---:|---:|---:|---|---|']
    for q in r['descriptor_qwords']:
        lab=q.get('label');ls='-'
        if q.get('target_rel') is not None:ls=f"0x{q['target_rel']:x}"
        if lab:ls+=f" `{lab['name']}+0x{lab['offset']:x}`"
        L.append(f"| `0x{q['storage']:x}` | `0x{q['mmap_offset']:x}` | `0x{q['value']:x}` | `{q['class']}` | {ls} |")
    L += ['', '## Direct calls from decrypted 0x5000 region','', '| callsite | target | label/import |','|---:|---:|---|']
    for c in r['decrypted']['calls']:
        lab=c.get('target_import') or ((c.get('target_label') or {}).get('name')) or '-'
        L.append(f"| `0x{c['address']:x}` | `0x{c['target']:x}` | `{lab}` |")
    L += ['', '## Protected-helper references','']
    if r['decrypted']['protected_refs']:
        for x in r['decrypted']['protected_refs'][:300]:L.append(f"- `0x{x['address']:x}` {x['mnemonic']} -> `0x{x['target']:x}`")
    else:L.append('- none')
    for title,key in [('Decrypted handler candidate +0x4d1d0','handler_window'),('Runtime code around +0x521fc','tail_window')]:
        L += ['',f'## {title}','', '```asm']
        for i in r[key]:L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
        L += ['```','']
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    label,pltmap=load_symbols(a.libcompatible)
    e=bionic.BionicEmulator(base.Image(a.libcompatible),a.out);runtime=e.run_bionic()
    r={'runtime_stop':runtime['stop'],'runtime_instructions':runtime['instructions'],'descriptor_qwords':qword_table(e,label),'decrypted':decode_runtime(e,label,pltmap),'handler_window':window(e,HANDLER,0x1000),'tail_window':window(e,TAIL,0x500)}
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'decrypted-handler.json').write_text(json.dumps(r,indent=2)+'\n');(a.out/'decrypted-handler.md').write_text(render(r))
    print(json.dumps({'stop':r['runtime_stop'],'qword_handlers':[(hex(x['mmap_offset']),hex(x['target_rel'])) for x in r['descriptor_qwords'] if x.get('target_rel') is not None and DEC_LO<=x['target_rel']<DEC_HI],'calls':[(hex(x['address']),hex(x['target']),x.get('target_import')) for x in r['decrypted']['calls']],'protected_refs':r['decrypted']['protected_refs'][:20]},indent=2))
if __name__=='__main__':main()

#!/usr/bin/env python3
"""Decode the tiny libstub DT_INIT trampoline without trusting section headers."""
from __future__ import annotations

import argparse, json, struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_MEM, ARM64_OP_REG
from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile


def load_meta(path: Path):
    raw = path.read_bytes()
    loads=[]; dyn={}
    with path.open('rb') as f:
        elf=ELFFile(f)
        for seg in elf.iter_segments():
            if str(seg['p_type'])=='PT_LOAD':
                loads.append({'va':int(seg['p_vaddr']),'off':int(seg['p_offset']),'filesz':int(seg['p_filesz']),'memsz':int(seg['p_memsz']),'flags':int(seg['p_flags'])})
            if isinstance(seg,DynamicSegment) or str(seg['p_type'])=='PT_DYNAMIC':
                try:
                    for tag in seg.iter_tags():
                        n=str(tag.entry.d_tag)
                        if hasattr(tag.entry,'d_val'):dyn[n]=int(tag.entry.d_val)
                        elif hasattr(tag.entry,'d_ptr'):dyn[n]=int(tag.entry.d_ptr)
                except Exception: pass
    return raw,loads,dyn


def map_file(loads,va):
    for s in loads:
        if s['va']<=va< s['va']+s['filesz']:
            return s['off']+va-s['va']
    return None


def decode(path:Path):
    raw,loads,dyn=load_meta(path)
    init=dyn.get('DT_INIT')
    if init is None: raise SystemExit('DT_INIT missing')
    start=max(0,init-0x30); end=min(len(raw),init+0xc0)
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True
    insns=[]
    regs={}
    events=[]
    for pc in range(start&~3,end-3,4):
        ds=list(md.disasm(raw[pc:pc+4],pc,count=1))
        if not ds:
            insns.append({'address':pc,'mnemonic':'.word','op_str':f'0x{int.from_bytes(raw[pc:pc+4],"little"):08x}','state':dict(regs)});continue
        i=ds[0]; m=i.mnemonic; ops=i.operands
        # constant tracking for the registers used by the trampoline
        if m in ('adr','adrp') and len(ops)>=2 and ops[0].type==ARM64_OP_REG and ops[1].type==ARM64_OP_IMM:
            regs[i.reg_name(ops[0].reg)]=int(ops[1].imm)
        elif m=='add' and len(ops)>=3 and ops[0].type==ARM64_OP_REG and ops[1].type==ARM64_OP_REG and ops[2].type==ARM64_OP_IMM:
            dst=i.reg_name(ops[0].reg); src=i.reg_name(ops[1].reg)
            if src in regs: regs[dst]=regs[src]+int(ops[2].imm)
            else: regs.pop(dst,None)
        elif m=='ldr' and len(ops)>=2 and ops[0].type==ARM64_OP_REG and ops[1].type==ARM64_OP_MEM:
            dst=i.reg_name(ops[0].reg); base=i.reg_name(ops[1].mem.base); disp=int(ops[1].mem.disp)
            if base in regs:
                va=regs[base]+disp; off=map_file(loads,va); val=None
                if off is not None and off+8<=len(raw): val=struct.unpack_from('<Q',raw,off)[0]
                events.append({'pc':pc,'kind':'load','dst':dst,'va':va,'file_offset':off,'raw_u64':val})
                if val is not None: regs[dst]=val
                else: regs.pop(dst,None)
            else: regs.pop(dst,None)
        elif m in ('br','blr') and ops and ops[0].type==ARM64_OP_REG:
            r=i.reg_name(ops[0].reg);events.append({'pc':pc,'kind':m,'reg':r,'target':regs.get(r),'registers':dict(regs)})
        insns.append({'address':pc,'mnemonic':m,'op_str':i.op_str,'registers':dict(regs)})
    return {'dt_init':init,'dynamic':dyn,'loads':loads,'instructions':insns,'events':events}


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libstub',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    r=decode(a.libstub);a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'stub-init.json').write_text(json.dumps(r,indent=2)+'\n')
    L=['# AppGuard `libstub.so` DT_INIT trampoline','',f"- DT_INIT: `0x{r['dt_init']:x}`",'', '## Annotated instructions','', '```asm']
    for x in r['instructions']:
        mark='  ; <-- DT_INIT' if x['address']==r['dt_init'] else ''
        state=x.get('registers') or {}; compact=', '.join(f'{k}=0x{v:x}' for k,v in sorted(state.items()) if k in ('x0','x16','x17'))
        suffix=(f'  ; {compact}' if compact else '')+mark
        L.append(f"0x{x['address']:x}: {x['mnemonic']} {x['op_str']}{suffix}")
    L += ['```','','## Memory/branch events','', '| PC | Kind | Detail |','|---:|---|---|']
    for e in r['events']:
        if e['kind']=='load':
            L.append(f"| `0x{e['pc']:x}` | load | `{e['dst']}` <- VA `0x{e['va']:x}`, file `{hex(e['file_offset']) if e['file_offset'] is not None else '-'}`, raw `{hex(e['raw_u64']) if e['raw_u64'] is not None else '-'}` |")
        else:
            L.append(f"| `0x{e['pc']:x}` | `{e['kind']}` | `{e['reg']}` -> `{hex(e['target']) if e['target'] is not None else 'runtime/unknown'}`; x0=`{hex(e['registers'].get('x0')) if e['registers'].get('x0') is not None else '-'}` |")
    (a.out/'stub-init.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'dt_init':hex(r['dt_init']),'events':r['events']},indent=2))
if __name__=='__main__':main()

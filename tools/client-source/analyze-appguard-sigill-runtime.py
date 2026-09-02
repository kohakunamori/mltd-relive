#!/usr/bin/env python3
"""Recover the likely SIGILL/lazy-decryption bridge used by AppGuard.

Evidence so far:
* SoLibraryStart directly reaches encrypted/undefined code at +0x1cd84.
* The same undefined instruction is reported by Unicorn as interrupt #1.
* DT_INIT decrypts a 0x5000-byte code region at +0x4d000..+0x52000; +0x4d1d0
  becomes a large valid AArch64 function by ~8M instructions.

This pass combines static PLT callsite discovery for signal/sigaction with a
runtime pointer scan after the decrypted region stabilizes.  It identifies
calls made with SIGILL (4), handler arguments, and any qword in libcompatible,
heap or mmap state that points into the decrypted code region.
"""
from __future__ import annotations

import argparse, collections, importlib.util, json, struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM
from elftools.elf.elffile import ELFFile

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('bionic_emu',P)
bionic=importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(bionic)
base=bionic.base

RUN_LIMIT=9_000_000
TARGET_LO=0x4D000
TARGET_HI=0x52000
base.MAX_INSNS=RUN_LIMIT


def static_signal_calls(path:Path):
    with path.open('rb') as f:
        elf=ELFFile(f)
        plt=elf.get_section_by_name('.plt'); rela=elf.get_section_by_name('.rela.plt'); dynsym=elf.get_section_by_name('.dynsym')
        pmap={}
        if plt is not None and rela is not None and dynsym is not None:
            pbase=int(plt['sh_addr'])
            for i,r in enumerate(rela.iter_relocations()):
                idx=int(r.entry.r_info_sym); name=dynsym.get_symbol(idx).name if idx else ''
                if name: pmap[pbase+32+16*i]=name
        exec_sections=[]
        for s in elf.iter_sections():
            if int(s['sh_flags']) & 0x4 and int(s['sh_size']):
                exec_sections.append((s.name,int(s['sh_addr']),int(s['sh_offset']),s.data()))
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True
    insmap={};calls=[]
    wanted={'signal','sigaction','__sigaction','bsd_signal','sigset','pthread_sigmask'}
    for sec,va,off,data in exec_sections:
        for ins in md.disasm(data,va):
            insmap[int(ins.address)]={'address':int(ins.address),'file_offset':off+int(ins.address)-va,'mnemonic':ins.mnemonic,'op_str':ins.op_str,'section':sec}
            if ins.mnemonic=='bl' and ins.operands and ins.operands[0].type==ARM64_OP_IMM:
                target=int(ins.operands[0].imm); name=pmap.get(target)
                if name in wanted:
                    calls.append({'address':int(ins.address),'target':target,'symbol':name,'section':sec})
    for c in calls:
        c['context']=[insmap[a] for a in range(c['address']-0x80,c['address']+0x44,4) if a in insmap]
    return calls


def scan_pointer_region(uc,name,lo,hi,target_lo,target_hi,max_hits=4096):
    if hi<=lo:return []
    try:data=bytes(uc.mem_read(lo,hi-lo))
    except Exception:return []
    hits=[]
    # qword-aligned scan, with absolute runtime pointers.
    for off in range(0,len(data)-7,8):
        v=struct.unpack_from('<Q',data,off)[0]
        if target_lo<=v<target_hi:
            around=[]
            for qoff in range(max(0,off-0x20),min(len(data)-7,off+0x28),8):
                around.append({'offset':qoff,'value':struct.unpack_from('<Q',data,qoff)[0]})
            hits.append({'region':name,'storage_address':lo+off,'storage_offset':off,'target':v,'target_rel':v-base.BIAS,'around':around})
            if len(hits)>=max_hits:break
    return hits


class Probe(bionic.BionicEmulator):
    def run_probe(self):
        r=self.run_bionic()
        target_abs_lo=base.BIAS+TARGET_LO;target_abs_hi=base.BIAS+TARGET_HI
        # Scan complete loaded libcompatible virtual extent.
        lo=min(base.BIAS+s['vaddr'] for s in self.image.loads)
        hi=max(base.BIAS+s['vaddr']+s['memsz'] for s in self.image.loads)
        hits=scan_pointer_region(self.uc,'libcompatible',lo,hi,target_abs_lo,target_abs_hi)
        hits+=scan_pointer_region(self.uc,'heap',base.HEAP_BASE+0x1000,self.heap_next,target_abs_lo,target_abs_hi)
        hits+=scan_pointer_region(self.uc,'mmap',base.MMAP_BASE+0x1000,self.mmap_next,target_abs_lo,target_abs_hi)
        signal_calls=[]
        for c in self.calls:
            n=c['name'].split('@',1)[0]
            if 'signal' in n or 'sigaction' in n or n in ('sigset','bsd_signal','pthread_sigmask'):
                row=dict(c)
                args=row.get('args') or []
                row['signal_number']=args[0] if args else None
                if n in ('signal','bsd_signal','sigset') and len(args)>1:
                    row['handler']=args[1]
                    row['handler_rel']=args[1]-base.BIAS if base.BIAS<=args[1]<base.BIAS+0x4000000 else None
                elif 'sigaction' in n and len(args)>1 and args[1]:
                    try:
                        raw=bytes(self.uc.mem_read(args[1],0x40))
                        qs=[struct.unpack_from('<Q',raw,i)[0] for i in range(0,0x40,8)]
                        row['act_qwords']=qs
                        candidates=[]
                        for v in qs:
                            if target_abs_lo<=v<target_abs_hi:
                                candidates.append({'absolute':v,'rel':v-base.BIAS})
                        row['target_region_candidates']=candidates
                    except Exception:pass
                signal_calls.append(row)
        return r,hits,signal_calls


def render(rep):
    L=['# AppGuard SIGILL / lazy-decryption bridge analysis','',
       f"- runtime stop: `{rep['runtime']['stop']}`",f"- runtime instructions: **{rep['runtime']['instructions']}**",
       f"- callback captured: **{rep['runtime']['callback_captured']}**",f"- static signal-family callsites: **{len(rep['static_calls'])}**",
       f"- runtime signal-family calls: **{len(rep['runtime_signal_calls'])}**",f"- pointers into decrypted `+0x{TARGET_LO:x}..+0x{TARGET_HI:x}`: **{len(rep['target_pointer_hits'])}**",'',
       '## Static signal-family PLT callsites','']
    if rep['static_calls']:
        for c in rep['static_calls']:
            L += [f"### `{c['symbol']}` at `0x{c['address']:x}`",'', '```asm']
            for i in c['context']:
                mark='  ; CALL' if i['address']==c['address'] else ''
                L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}{mark}")
            L += ['```','']
    else:L.append('- none')
    L += ['', '## Runtime signal-family calls','', '| API | signal | handler / act | args |','|---|---:|---|---|']
    for c in rep['runtime_signal_calls']:
        h='-'
        if c.get('handler') is not None:h=f"0x{c['handler']:x} (rel {hex(c['handler_rel']) if c.get('handler_rel') is not None else '-'})"
        elif c.get('act_qwords') is not None:h=' '.join(f'{x:#x}' for x in c['act_qwords'])
        L.append(f"| `{c['name']}` | {c.get('signal_number','-')} | `{h}` | `{c.get('args')}` |")
    if not rep['runtime_signal_calls']:L.append('| - | - | - | - |')
    L += ['', '## Runtime pointers into decrypted code region','', '| Region | Storage | Target | Target rel | Context qwords |','|---|---:|---:|---:|---|']
    for h in rep['target_pointer_hits'][:1000]:
        ctx=' '.join(f"+0x{x['offset']:x}=0x{x['value']:x}" for x in h['around'])
        L.append(f"| `{h['region']}` | `0x{h['storage_address']:x}` | `0x{h['target']:x}` | `0x{h['target_rel']:x}` | `{ctx}` |")
    if not rep['target_pointer_hits']:L.append('| - | - | - | - | - |')
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    static=static_signal_calls(a.libcompatible)
    e=Probe(base.Image(a.libcompatible),a.out);runtime,hits,signal_calls=e.run_probe()
    rep={'static_calls':static,'runtime':runtime,'runtime_signal_calls':signal_calls,'target_pointer_hits':hits}
    a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'sigill-bridge.json').write_text(json.dumps(rep,indent=2)+'\n')
    (a.out/'sigill-bridge.md').write_text(render(rep))
    print(json.dumps({'stop':runtime['stop'],'static_calls':[(hex(x['address']),x['symbol']) for x in static],'runtime_signal_calls':[(x['name'],x.get('signal_number'),x.get('handler_rel'),x.get('target_region_candidates')) for x in signal_calls],'pointer_hits':[(x['region'],hex(x['storage_address']),hex(x['target_rel'])) for x in hits[:40]]},indent=2))
if __name__=='__main__':main()

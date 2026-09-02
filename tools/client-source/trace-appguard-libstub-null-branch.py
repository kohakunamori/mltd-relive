#!/usr/bin/env python3
"""Trace the control transfer that sends the pre-decrypted SoLibraryStart path to PC=0.

This reuses the proven offline AppGuard range transforms, records the last stage-2
instructions/registers, and stops as soon as address zero is reached.  The goal
is to identify the exact BR/BLR/RET source and the zero-valued function-table
slot that still needs linker/runtime modelling.
"""
from __future__ import annotations

import argparse,collections,importlib.util,json
from pathlib import Path

from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
from unicorn.arm64_const import *

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-libstub-predecrypted.py'
spec=importlib.util.spec_from_file_location('predec',P)
pre=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(pre)
cross=pre.cross;base=pre.base

REGS=[
    UC_ARM64_REG_X0,UC_ARM64_REG_X1,UC_ARM64_REG_X2,UC_ARM64_REG_X3,
    UC_ARM64_REG_X4,UC_ARM64_REG_X5,UC_ARM64_REG_X6,UC_ARM64_REG_X7,
    UC_ARM64_REG_X8,UC_ARM64_REG_X9,UC_ARM64_REG_X10,UC_ARM64_REG_X11,
    UC_ARM64_REG_X12,UC_ARM64_REG_X13,UC_ARM64_REG_X14,UC_ARM64_REG_X15,
    UC_ARM64_REG_X16,UC_ARM64_REG_X17,UC_ARM64_REG_X18,UC_ARM64_REG_X19,
    UC_ARM64_REG_X20,UC_ARM64_REG_X21,UC_ARM64_REG_X22,UC_ARM64_REG_X23,
    UC_ARM64_REG_X24,UC_ARM64_REG_X25,UC_ARM64_REG_X26,UC_ARM64_REG_X27,
    UC_ARM64_REG_X28,UC_ARM64_REG_X29,UC_ARM64_REG_X30,
]

class TraceLoader(cross.CrossLoader):
    def __init__(self,compatible,stub,out):
        super().__init__(compatible,stub,out)
        self.stage_history=collections.deque(maxlen=192)
        self.zero_entry=None
    def code_hook(self,uc,address,size,user):
        if self.stage!='bootstrap':
            raw=b''
            try:raw=bytes(uc.mem_read(address,4))
            except Exception:pass
            regs=[uc.reg_read(r) for r in REGS]
            self.stage_history.append({
                'stage_instruction':self.stage2_insns+1,
                'pc':address,
                'raw':raw.hex(),
                'regs':regs,
                'sp':uc.reg_read(UC_ARM64_REG_SP),
            })
            if address==0:
                self.zero_entry={'stage_instruction':self.stage2_insns+1,'regs':regs,'sp':uc.reg_read(UC_ARM64_REG_SP)}
                self.stopped_reason='reached PC=0 before undefined instruction'
                uc.emu_stop();return
        super().code_hook(uc,address,size,user)

def decode_history(rows):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    out=[]
    for r in rows:
        m='.word';ops=''
        raw=bytes.fromhex(r['raw']) if r['raw'] else b''
        if len(raw)==4:
            ins=list(md.disasm(raw,r['pc'],count=1))
            if ins:m=ins[0].mnemonic;ops=ins[0].op_str
        out.append({**r,'mnemonic':m,'op_str':ops})
    return out

def pointer_context(emu,value):
    if not value:return None
    probes=[]
    for delta in (-0x20,-0x10,-8,0,8,0x10,0x20):
        a=(value+delta)&0xffffffffffffffff
        try:
            raw=bytes(emu.uc.mem_read(a,0x20))
            probes.append({'address':a,'delta':delta,'hex':raw.hex()})
        except Exception:pass
    return probes or None

def render(rep):
    L=['# AppGuard libstub PC=0 control-transfer trace','',f"- bootstrap stop: `{rep['bootstrap_stop']}`",f"- stage stop: `{rep['stage_stop']}`",f"- stage instructions: **{rep['stage_instructions']}**",'', '## Last stage-2 instructions','', '| # | PC | instruction | x0 | x8 | x9 | x16 | x17 | x30 |','|---:|---:|---|---:|---:|---:|---:|---:|---:|']
    for r in rep['history']:
        g=r['regs'];L.append(f"| {r['stage_instruction']} | `0x{r['pc']:x}` | `{r['mnemonic']} {r['op_str']}` | `0x{g[0]:x}` | `0x{g[8]:x}` | `0x{g[9]:x}` | `0x{g[16]:x}` | `0x{g[17]:x}` | `0x{g[30]:x}` |")
    if rep.get('suspect'):
        s=rep['suspect'];L += ['', '## Suspect transfer','',f"- PC: `0x{s['pc']:x}`",f"- instruction: `{s['mnemonic']} {s['op_str']}`",f"- raw: `{s['raw']}`",'', '### Registers','']
        for i,v in enumerate(s['regs']):L.append(f"- `x{i}` = `0x{v:x}`")
    L += ['', '## Zero-valued register pointer contexts','']
    for p in rep.get('pointer_contexts',[]):
        L.append(f"### x{p['register']} = `0x{p['value']:x}`")
        for q in p['probes']:L.append(f"- `{q['delta']:+#x}` @ `0x{q['address']:x}`: `{q['hex']}`")
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--libstub',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=TraceLoader(a.libcompatible,a.libstub,a.out);boot,_=e.bootstrap();pre_rows=[pre.decrypt_range(e,r) for r in pre.RANGES];e.map_libstub();e.apply_libstub_relocations();stage=e.run_libstub_stage();hist=decode_history(list(e.stage_history))
    suspect=None
    for r in reversed(hist):
        if r['pc']==0:continue
        if r['mnemonic'] in ('br','blr','ret'):
            suspect=r;break
    contexts=[]
    if suspect:
        for i,v in enumerate(suspect['regs']):
            if v==0:continue
            probes=pointer_context(e,v)
            if probes:contexts.append({'register':i,'value':v,'probes':probes})
    rep={'bootstrap_stop':boot['stop'],'predecrypted_ranges':pre_rows,'stage_stop':stage['stop'],'stage_instructions':stage['instructions'],'stage_pc':stage['pc'],'history':hist,'suspect':suspect,'pointer_contexts':contexts,'external_calls':stage['external_calls'],'direct_syscalls':stage['direct_syscalls']}
    (a.out/'libstub-null-branch-trace.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'libstub-null-branch-trace.md').write_text(render(rep))
    print(json.dumps({'stop':rep['stage_stop'],'insns':rep['stage_instructions'],'suspect':{k:suspect[k] for k in ('pc','mnemonic','op_str','raw')} if suspect else None,'last':[(hex(x['pc']),x['mnemonic'],x['op_str']) for x in hist[-20:]]},indent=2))
if __name__=='__main__':main()

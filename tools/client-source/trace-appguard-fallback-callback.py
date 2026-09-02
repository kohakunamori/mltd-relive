#!/usr/bin/env python3
"""Trace how fallback callback values from +0xc2a30 are consumed during JNI init.

+0xcac34 now appears to be a native-bridge detector, so a false result may be
normal on native arm64.  The remaining question is therefore whether the small
fallback values are absolute PCs, offsets requiring a base, or selectors used
by another dispatch layer.  Capture every JNI-stage BR/BLR to one of those
values and the runtime instructions immediately around the callsite.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_REG
from unicorn.arm64_const import *

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-callback-installer.py'
spec=importlib.util.spec_from_file_location('cb_installer',P)
mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base

FALLBACK={0x7250,0x3420,0x2530,0x1100,0x4580,0x7510,0x7130}
REGS={f'x{i}':globals()[f'UC_ARM64_REG_X{i}'] for i in range(31)}


class Trace(mod.E):
    def __init__(self,image,out):
        super().__init__(image,out)
        self.md=Cs(CS_ARCH_ARM64,CS_MODE_ARM); self.md.detail=True
        self.small_indirect=[]
        self.slot_reads=[]
        self.first_small_context=None

    def disasm_context(self, rva, before=0x30, after=0x20):
        start=max(0,rva-before); raw=bytes(self.uc.mem_read(base.BIAS+start,before+after))
        return [{'rva':i.address,'bytes':i.bytes.hex(),'mnemonic':i.mnemonic,'op_str':i.op_str}
                for i in self.md.disasm(raw,start)]

    def code_hook(self,uc,address,size,user):
        if getattr(self,'stage',None)=='jni' and base.BIAS <= address < base.BIAS+0x4000000:
            rva=address-base.BIAS
            try:
                ins=next(iter(self.md.disasm(bytes(uc.mem_read(address,size)),address,count=1)),None)
            except Exception:
                ins=None
            if ins and ins.mnemonic in ('blr','br') and ins.operands and ins.operands[0].type==ARM64_OP_REG:
                rn=ins.reg_name(ins.operands[0].reg); rr=REGS.get(rn)
                if rr is not None:
                    target=uc.reg_read(rr)
                    if target in FALLBACK or target < 0x100000:
                        regs={f'x{i}':uc.reg_read(REGS[f'x{i}']) for i in range(31)}
                        row={'caller_rva':rva,'mnemonic':ins.mnemonic,'op_str':ins.op_str,'target':target,
                             'source_reg':rn,'lr':uc.reg_read(UC_ARM64_REG_X30),'regs':regs,
                             'context':self.disasm_context(rva)}
                        self.small_indirect.append(row)
                        if self.first_small_context is None:self.first_small_context=row
        super().code_hook(uc,address,size,user)


def render(rep):
    L=['# Fallback callback consumption trace','',
       f"- installer gate result: `0x{rep['installer_gate_w0']:x}`",
       f"- JNI stop: `{rep['jni']['stop']}`",
       f"- small indirect branches observed: **{len(rep['small_indirect'])}**",'',
       '## Callback slots','', '| slot | value |','|---:|---:|']
    for k,v in rep['installer']['slots'].items():L.append(f'| `{k}` | `0x{v:x}` |')
    L += ['','## Small indirect branches','']
    for n,x in enumerate(rep['small_indirect']):
        L += [f"### #{n}: `+0x{x['caller_rva']:x}` -> `0x{x['target']:x}` via `{x['source_reg']}`",'', '```asm']
        for i in x['context']:
            mark='  ; <--' if i['rva']==x['caller_rva'] else ''
            L.append(f"0x{i['rva']:x}: {i['bytes']:<8} {i['mnemonic']} {i['op_str']}{mark}")
        L += ['```','', 'Registers:']
        L.append('```text')
        L.append(' '.join(f"x{i}=0x{x['regs'][f'x{i}']:x}" for i in range(31)))
        L += ['```','']
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True)
    a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=Trace(base.Image(a.libcompatible),a.out)
    boot=e.run_bootstrap();inst=e.run_installer();gate=(e.cac_exit or {}).get('w0',0)
    pre=[mod.mod.decrypt_range(e,r) if hasattr(mod,'mod') else None for r in []]
    # Same explicit predecryption used by the canonical callback-installer harness.
    pre=[mod.mod.decrypt_range(e,r) for r in mod.mod.RANGES]
    jni=e.run_jni()
    rep={'bootstrap':boot,'installer_gate_w0':gate,'installer':inst,'predecrypted_ranges':pre,'jni':jni,'small_indirect':e.small_indirect}
    (a.out/'fallback-callback-trace.json').write_text(json.dumps(rep,indent=2)+'\n')
    (a.out/'fallback-callback-trace.md').write_text(render(rep))
    print(json.dumps({'gate':gate,'jni_stop':jni['stop'],'small_indirect':[
        {'caller_rva':x['caller_rva'],'target':x['target'],'source_reg':x['source_reg']} for x in e.small_indirect]},indent=2))


if __name__=='__main__':main()

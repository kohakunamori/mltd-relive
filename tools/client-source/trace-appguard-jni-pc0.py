#!/usr/bin/env python3
"""Trace the exact control transfer that sends AppGuard JNI initialization to PC=0."""
from __future__ import annotations
import argparse, importlib.util, json
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn.arm64_const import *

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-jni-init.py'
spec=importlib.util.spec_from_file_location('jni_init',P)
mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base

REGS=[(f'x{i}',globals()[f'UC_ARM64_REG_X{i}']) for i in range(31)]

class Trace(mod.JniInitEmulator):
    def __init__(self,image,out):
        super().__init__(image,out); self.pc0_snapshot=None
    def decode_at(self,addr):
        try: raw=bytes(self.uc.mem_read(addr,4))
        except Exception:return {'address':addr,'error':'unmapped'}
        md=Cs(CS_ARCH_ARM64,CS_MODE_ARM); ins=next(iter(md.disasm(raw,addr)),None)
        return {'address':addr,'bytes':raw.hex(),'mnemonic':ins.mnemonic if ins else '.word','op_str':ins.op_str if ins else f'0x{int.from_bytes(raw,"little"):08x}'}
    def code_hook(self,uc,address,size,user):
        if self.stage!='bootstrap' and address==0 and self.pc0_snapshot is None:
            hist=list(self.hist)
            regs={n:uc.reg_read(r) for n,r in REGS}
            rows=[self.decode_at(a) for a in hist[-128:]]
            last=rows[-1] if rows else None
            self.pc0_snapshot={'history':rows,'last_instruction':last,'registers':regs,
                               'stage_instruction':self.stage_insns,'target_slot':mod.qword(uc,base.BIAS+mod.TARGET_SLOT),
                               'pointer_cell':mod.qword(uc,base.BIAS+mod.PTR_CELL)}
        super().code_hook(uc,address,size,user)

def render(rep):
    s=rep.get('pc0_snapshot') or {}; L=['# AppGuard JNI PC=0 control-transfer trace','',
      f"- JNI stop: `{rep['jni']['stop']}`",f"- JNI instructions: **{rep['jni']['instructions']}**",
      f"- source instruction: `{s.get('last_instruction')}`",f"- target callback slot: `0x{s.get('target_slot',0):x}`",'',
      '## Last instructions','', '| # | address | instruction |','|---:|---:|---|']
    for i,x in enumerate(s.get('history',[])):
        L.append(f"| {i} | `0x{x['address']:x}` | `{x.get('mnemonic')} {x.get('op_str')}` |")
    L += ['', '## Registers at PC=0','', '```json',json.dumps(s.get('registers',{}),indent=2),'```','']
    return '\n'.join(L)

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=Trace(base.Image(a.libcompatible),a.out);boot=e.run_bootstrap();pre=[mod.decrypt_range(e,r) for r in mod.RANGES];j=e.run_jni()
    rep={'bootstrap':boot,'predecrypted_ranges':pre,'jni':j,'pc0_snapshot':e.pc0_snapshot}
    (a.out/'jni-pc0-trace.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'jni-pc0-trace.md').write_text(render(rep)+'\n')
    snap=e.pc0_snapshot or {}; print(json.dumps({'stop':j['stop'],'instructions':j['instructions'],'last':snap.get('last_instruction'),
      'regs':{k:hex(v) for k,v in (snap.get('registers') or {}).items()},'history_tail':snap.get('history',[])[-24:]},indent=2))
if __name__=='__main__':main()

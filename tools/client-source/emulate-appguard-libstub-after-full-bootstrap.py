#!/usr/bin/env python3
"""Run libstub only after an extended libcompatible bootstrap.

Immediate invocation at asmFunction callback installation is proven too early.
The post-callback runtime slice shows a large code-decryption state machine that
rewrites libcompatible+0x4d1d0 into valid AArch64.  This experiment lets that
bootstrap continue with a much larger instruction budget, records the decrypted
code-region evolution, then invokes the exact libstub SoLibraryStart stage.
"""
from __future__ import annotations

import argparse, hashlib, importlib.util, json
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn import UcError, UC_HOOK_MEM_WRITE
from unicorn.arm64_const import UC_ARM64_REG_PC

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-libstub-stage.py'
spec=importlib.util.spec_from_file_location('cross_stage',P)
cross=importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(cross)
base=cross.base
bionic=cross.bionic

EXTENDED_LIMIT=30_000_000
TARGET_LO=0x4D000
TARGET_HI=0x52000
TARGET_ENTRY=0x4D1D0

# Lift the inherited DT_INIT instruction limiter before run_bionic()/run_fast().
base.MAX_INSNS=EXTENDED_LIMIT


def block_summary(uc, rel, size=0x4000):
    raw=bytes(uc.mem_read(base.BIAS+rel,size))
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    valid=0; rows=[]
    for off in range(0,min(size,0x800)-3,4):
        ds=list(md.disasm(raw[off:off+4],rel+off,count=1))
        if ds:
            valid+=1
            if len(rows)<160: rows.append({'address':rel+off,'mnemonic':ds[0].mnemonic,'op_str':ds[0].op_str})
        elif len(rows)<160:
            rows.append({'address':rel+off,'mnemonic':'.word','op_str':f'0x{int.from_bytes(raw[off:off+4],"little"):08x}'})
    return {'address':rel,'size':size,'sha256':hashlib.sha256(raw).hexdigest(),'nonzero':sum(1 for x in raw if x),'valid_words_first_0x800':valid,'head':raw[:0x200].hex(),'instructions':rows}


class ExtendedCrossLoader(cross.CrossLoader):
    def __init__(self,compatible,stub,out):
        super().__init__(compatible,stub,out)
        self.decrypt_writes=0
        self.decrypt_min=None; self.decrypt_max=None
        self.decrypt_samples=[]
        self.bootstrap_marks=[]
        self._mark_set={4_000_000,8_000_000,12_000_000,20_000_000,EXTENDED_LIMIT}

    def decrypt_write_hook(self,uc,access,address,size,value,user):
        rel=address-base.BIAS
        self.decrypt_writes+=1
        self.decrypt_min=rel if self.decrypt_min is None else min(self.decrypt_min,rel)
        self.decrypt_max=max(self.decrypt_max or rel,rel+size)
        if len(self.decrypt_samples)<4096:
            self.decrypt_samples.append({'instruction':self.insns,'pc':uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'offset':rel,'size':size,'value':value})

    def code_hook(self,uc,address,size,user):
        if self.stage=='bootstrap':
            # Bypass CrossLoader's early CALLBACK_DONE stop.  Keep all Bionic PRNG,
            # Fibonacci, external-call, opaque-edge and inherited instruction logic.
            bionic.BionicEmulator.code_hook(self,uc,address,size,user)
            if self.insns in self._mark_set:
                try:self.bootstrap_marks.append({'instruction':self.insns,'pc':address-base.BIAS,'target':block_summary(self.uc,TARGET_ENTRY)})
                except UcError:pass
            return
        cross.CrossLoader.code_hook(self,uc,address,size,user)

    def bootstrap(self):
        self.uc.hook_add(UC_HOOK_MEM_WRITE,self.decrypt_write_hook,begin=base.BIAS+TARGET_LO,end=base.BIAS+TARGET_HI-1)
        before=None
        # map_memory happens inside run_bionic, so capture source bytes from Image.
        try:
            src=self.image.read_file_va(TARGET_ENTRY,0x4000)
            before={'address':TARGET_ENTRY,'size':len(src),'sha256':hashlib.sha256(src).hexdigest(),'head':src[:0x200].hex()}
        except Exception:before=None
        result=self.run_bionic();self.stage1_result=result
        if not self.callback_captured:
            raise RuntimeError(f'extended bootstrap did not install loader callback: {result.get("stop")}')
        after=block_summary(self.uc,TARGET_ENTRY)
        self.extended_bootstrap={
            'limit':EXTENDED_LIMIT,'stop':result.get('stop'),'instructions':result.get('instructions'),
            'callback_captured':self.callback_captured,'writes':self.decrypt_writes,
            'write_range':{'start':self.decrypt_min,'end':self.decrypt_max} if self.decrypt_min is not None else None,
            'write_samples':self.decrypt_samples[:1024],'before':before,'after':after,'marks':self.bootstrap_marks,
        }
        table=result['snapshots'][-1].get('asmfunction_table') if result.get('snapshots') else None
        return result,table


def render(rep):
    e=rep['extended_bootstrap'];s=rep['libstub_stage']
    L=['# AppGuard libstub stage after extended libcompatible bootstrap','',
       f"- bootstrap stop: `{e['stop']}`",f"- bootstrap instructions: **{e['instructions']}**",
       f"- callback captured: **{e['callback_captured']}**",f"- writes into `0x{TARGET_LO:x}..0x{TARGET_HI:x}`: **{e['writes']}**",
       f"- write range: `{hex(e['write_range']['start'])+'..'+hex(e['write_range']['end']) if e.get('write_range') else '-'}`",
       f"- target `+0x{TARGET_ENTRY:x}` before SHA: `{(e.get('before') or {}).get('sha256','-')}`",
       f"- target `+0x{TARGET_ENTRY:x}` after SHA: `{e['after']['sha256']}`",
       f"- valid ARM64 words in first 0x800 bytes after: **{e['after']['valid_words_first_0x800']} / 512**",'',
       '## Decrypted target head','', '```asm']
    for i in e['after']['instructions'][:120]:L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
    L += ['```','', '## Bootstrap checkpoints','', '| Instructions | PC | Target SHA | valid/512 |','|---:|---:|---|---:|']
    for m in e['marks']:L.append(f"| {m['instruction']} | `0x{m['pc']:x}` | `{m['target']['sha256']}` | {m['target']['valid_words_first_0x800']} |")
    L += ['', '## libstub stage','',f"- stop: `{s['stop']}`",f"- instructions: **{s['instructions']}**",f"- protected libstub bytes changed: **{s['diff_bytes']}**",f"- observed libstub writes: **{s['writes_observed']}**",f"- weak SoLibraryStart probe changed: **{s['probe_before']['sha256'] != s['probe_after']['sha256']}**",'', '### External calls','']
    if s['external_calls']:
        for c in s['external_calls'][:100]:L.append(f"- `{c['name']}` args={c.get('args')} string=`{c.get('string_arg','')}`")
    else:L.append('- none')
    L += ['', '### Direct exceptions/syscalls','']
    if s['direct_syscalls']:
        for c in s['direct_syscalls'][:100]:L.append(f"- pc=`{c.get('pc'):#x}` intno={c.get('intno')} nr=`{c.get('nr')}` name=`{c.get('name')}`")
    else:L.append('- none')
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--libstub',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    e=ExtendedCrossLoader(a.libcompatible,a.libstub,a.out)
    boot,_=e.bootstrap();e.map_libstub();rel=e.apply_libstub_relocations();stage=e.run_libstub_stage()
    rep={'extended_bootstrap':e.extended_bootstrap,'bootstrap':boot,'libstub_relocations_applied':rel,'libstub_stage':stage}
    (a.out/'libstub-after-full-bootstrap.json').write_text(json.dumps(rep,indent=2)+'\n')
    (a.out/'libstub-after-full-bootstrap.md').write_text(render(rep))
    print(json.dumps({'bootstrap_stop':e.extended_bootstrap['stop'],'bootstrap_insns':e.extended_bootstrap['instructions'],'decrypt_writes':e.extended_bootstrap['writes'],'target_valid':e.extended_bootstrap['after']['valid_words_first_0x800'],'stage_stop':stage['stop'],'stage_insns':stage['instructions'],'stub_diff':stage['diff_bytes'],'stub_writes':stage['writes_observed']},indent=2))
if __name__=='__main__':main()

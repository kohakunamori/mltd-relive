#!/usr/bin/env python3
"""Execute libstub DT_INIT instead of jumping directly to SoLibraryStart.

The direct-call harness proved the argument to SoLibraryStart but may skip state
that libstub establishes immediately before its PLT call.  This harness keeps
the proven libcompatible bootstrap/offline decryption, maps and relocates the
exact official libstub, then starts at libstub's own DT_INIT with the
SoLibraryStart JUMP_SLOT preempted to libcompatible's strong definition.
"""
from __future__ import annotations

import argparse,hashlib,importlib.util,json
from pathlib import Path
from collections import deque

from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
from unicorn import UcError,UC_HOOK_MEM_WRITE
from unicorn.arm64_const import UC_ARM64_REG_PC,UC_ARM64_REG_X30

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-libstub-predecrypted.py'
spec=importlib.util.spec_from_file_location('predec',P)
pre=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(pre)
cross=pre.cross;base=pre.base

LIMIT=8_000_000

class InitLoader(cross.CrossLoader):
    def __init__(self,compatible,stub,out):
        super().__init__(compatible,stub,out)
        self.stage_history=deque(maxlen=256)
        self.sostart_entries=[]
    def code_hook(self,uc,address,size,user):
        if self.stage!='bootstrap':
            raw=b''
            try:raw=bytes(uc.mem_read(address,4))
            except Exception:pass
            self.stage_history.append({'instruction':self.stage2_insns+1,'pc':address,'raw':raw.hex(),'x0':uc.reg_read(base.UC_ARM64_REG_X0),'x30':uc.reg_read(base.UC_ARM64_REG_X30)})
            if address==base.BIAS+cross.SOLIBRARY_START:
                self.sostart_entries.append({'instruction':self.stage2_insns+1,'x0':uc.reg_read(base.UC_ARM64_REG_X0),'lr':uc.reg_read(base.UC_ARM64_REG_X30)})
        super().code_hook(uc,address,size,user)

def decode(rows):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);out=[]
    for r in rows:
        raw=bytes.fromhex(r['raw']) if r['raw'] else b'';m='.word';op=''
        if len(raw)==4:
            ins=list(md.disasm(raw,r['pc'],count=1))
            if ins:m=ins[0].mnemonic;op=ins[0].op_str
        out.append({**r,'mnemonic':m,'op_str':op})
    return out

def run_init(e):
    before=bytes(e.uc.mem_read(cross.LIBSTUB_BASE,len(e.stub_raw)))
    call_start=len(e.calls);svc_start=len(e.svc_calls)
    e.stage='libstub';e.stage2_insns=0;e.insns=0;e.stopped_reason=None
    e.uc.hook_add(UC_HOOK_MEM_WRITE,e.stub_write_hook)
    e.uc.reg_write(UC_ARM64_REG_X30,base.STOP_ADDR)
    start=cross.LIBSTUB_BASE+e.stub_image.dt_init
    try:e.uc.emu_start(start,base.STOP_ADDR,count=LIMIT+1000)
    except UcError as exc:
        if e.stopped_reason is None:e.stopped_reason=f'Unicorn error: {exc}; pc={e.uc.reg_read(UC_ARM64_REG_PC):#x}'
    after=bytes(e.uc.mem_read(cross.LIBSTUB_BASE,len(e.stub_raw)))
    diffs=[i for i,(a,b) in enumerate(zip(before,after)) if a!=b]
    return {'start':start,'dt_init':e.stub_image.dt_init,'stop':e.stopped_reason,'instructions':e.stage2_insns,'pc':e.uc.reg_read(UC_ARM64_REG_PC),'sostart_entries':e.sostart_entries,'diff_bytes':len(diffs),'diff_ranges':cross.compress_ranges(diffs),'external_calls':e.enrich_calls(e.calls[call_start:]),'direct_syscalls':e.svc_calls[svc_start:],'history':decode(list(e.stage_history))}

def render(rep):
    s=rep['libstub_dt_init']
    L=['# AppGuard libstub DT_INIT execution after libcompatible pre-decryption','',f"- bootstrap stop: `{rep['bootstrap_stop']}`",f"- libstub DT_INIT RVA: `0x{s['dt_init']:x}`",f"- stage stop: `{s['stop']}`",f"- instructions: **{s['instructions']}**",f"- SoLibraryStart entries: **{len(s['sostart_entries'])}**",f"- libstub bytes changed: **{s['diff_bytes']}**",'', '## SoLibraryStart calls reached','']
    for x in s['sostart_entries']:L.append(f"- instruction {x['instruction']}: x0=`0x{x['x0']:x}`, LR=`0x{x['lr']:x}`")
    if not s['sostart_entries']:L.append('- none')
    L += ['', '## External calls','']
    for c in s['external_calls'][:200]:L.append(f"- `{c['name']}` args=`{c.get('args')}` string=`{c.get('string_arg','')}`")
    if not s['external_calls']:L.append('- none')
    L += ['', '## Last instructions','', '| # | PC | instruction | x0 | LR |','|---:|---:|---|---:|---:|']
    for x in s['history'][-180:]:L.append(f"| {x['instruction']} | `0x{x['pc']:x}` | `{x['mnemonic']} {x['op_str']}` | `0x{x['x0']:x}` | `0x{x['x30']:x}` |")
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--libstub',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=InitLoader(a.libcompatible,a.libstub,a.out);boot,_=e.bootstrap();pre_rows=[pre.decrypt_range(e,r) for r in pre.RANGES];e.map_libstub();rels=e.apply_libstub_relocations();stage=run_init(e);rep={'bootstrap_stop':boot['stop'],'predecrypted_ranges':pre_rows,'libstub_relocations':rels,'libstub_dt_init':stage}
    (a.out/'libstub-dt-init.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'libstub-dt-init.md').write_text(render(rep))
    print(json.dumps({'bootstrap':boot['stop'],'dt_init':hex(stage['dt_init'] or 0),'stop':stage['stop'],'instructions':stage['instructions'],'sostart_entries':stage['sostart_entries'],'diff_bytes':stage['diff_bytes'],'calls':[(x['name'],x.get('string_arg')) for x in stage['external_calls'][:40]],'last':[(hex(x['pc']),x['mnemonic'],x['op_str']) for x in stage['history'][-20:]]},indent=2))
if __name__=='__main__':main()

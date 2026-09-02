#!/usr/bin/env python3
"""Execute libcompatible DT_INIT_ARRAY constructors after bootstrap/decryption.

The loader harness historically executed only DT_INIT. Android's linker then
invokes DT_INIT_ARRAY before initializing dependents such as libstub. The null
SoLibraryStart callback slot at +0x1eb858 is never written by DT_INIT across
30M instructions, so this pass tests the missing constructor stage directly.
"""
from __future__ import annotations

import argparse,importlib.util,json,struct
from pathlib import Path
from collections import deque

from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
from unicorn import UcError,UC_HOOK_MEM_WRITE
from unicorn.arm64_const import UC_ARM64_REG_PC,UC_ARM64_REG_X0,UC_ARM64_REG_X1,UC_ARM64_REG_X2,UC_ARM64_REG_X30

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-libstub-predecrypted.py'
spec=importlib.util.spec_from_file_location('predec',P)
pre=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(pre)
cross=pre.cross;base=pre.base

TARGET_SLOT=0x1EB858
PTR_CELL=0x1E5CF0
CTOR_LIMIT=4_000_000

class InitArrayLoader(cross.CrossLoader):
    def __init__(self,compatible,out):
        # CrossLoader normally also requires libstub. Initialize only its
        # libcompatible/Bionic base because this experiment stops before libstub.
        cross.bionic.BionicEmulator.__init__(self,base.Image(compatible),out)
        self.stage='bootstrap';self.stage2_insns=0;self.stage2_writes=0;self.stage2_write_pages={};self.stage2_write_samples=[]
        self.stub_raw=b'';self.stub_image=None;self.stub_map_size=0;self.slot_writes=[];self.ctor_history=deque(maxlen=128);self.current_ctor=None
    def code_hook(self,uc,address,size,user):
        if self.stage=='bootstrap':
            cross.bionic.BionicEmulator.code_hook(self,uc,address,size,user)
            rel=address-base.BIAS
            if rel==cross.CALLBACK_DONE and self.callback_captured:
                self.stopped_reason='libcompatible loader callback ready';uc.emu_stop()
            return
        self.stage2_insns+=1
        raw=b''
        try:raw=bytes(uc.mem_read(address,4))
        except Exception:pass
        self.ctor_history.append({'instruction':self.stage2_insns,'pc':address,'raw':raw.hex(),'x0':uc.reg_read(UC_ARM64_REG_X0),'lr':uc.reg_read(UC_ARM64_REG_X30)})
        cross.bionic.BionicEmulator.code_hook(self,uc,address,size,user)
        if self.stage2_insns>=CTOR_LIMIT:
            self.stopped_reason=f'constructor instruction limit {CTOR_LIMIT}';uc.emu_stop()
    def slot_write_hook(self,uc,access,address,size,value,user):
        rel=address-base.BIAS
        if TARGET_SLOT<=rel<TARGET_SLOT+8:
            self.slot_writes.append({'constructor':self.current_ctor,'instruction':self.stage2_insns,'pc':uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'offset':rel,'size':size,'value':value})
    def bootstrap(self):
        r=self.run_bionic()
        if not self.callback_captured:raise RuntimeError(f'bootstrap failed: {r.get("stop")}')
        return r

def runtime_qword(e,rva):return struct.unpack('<Q',bytes(e.uc.mem_read(base.BIAS+rva,8)))[0]

def init_array_entries(e):
    d=e.image.dynamic;va=d.get('DT_INIT_ARRAY');sz=d.get('DT_INIT_ARRAYSZ',0)
    if va is None:return {'va':None,'size':0,'entries':[]}
    entries=[]
    for off in range(0,sz,8):
        v=runtime_qword(e,va+off)
        entries.append({'index':off//8,'slot_rva':va+off,'value':v,'rva':v-base.BIAS if base.BIAS<=v<base.BIAS+0x10000000 else None})
    return {'va':va,'size':sz,'entries':entries}

def decode(rows):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);out=[]
    for r in rows:
        raw=bytes.fromhex(r['raw']) if r['raw'] else b'';m='.word';op=''
        if len(raw)==4:
            x=list(md.disasm(raw,r['pc'],count=1))
            if x:m=x[0].mnemonic;op=x[0].op_str
        out.append({**r,'mnemonic':m,'op_str':op})
    return out

def call_ctor(e,row):
    if not row['value']:return {'entry':row,'stop':'null entry','instructions':0,'slot_before':runtime_qword(e,TARGET_SLOT),'slot_after':runtime_qword(e,TARGET_SLOT),'history':[]}
    before=runtime_qword(e,TARGET_SLOT);e.stage='ctor';e.stage2_insns=0;e.stopped_reason=None;e.current_ctor=row['index'];e.ctor_history.clear()
    e.uc.reg_write(UC_ARM64_REG_X0,0);e.uc.reg_write(UC_ARM64_REG_X1,0);e.uc.reg_write(UC_ARM64_REG_X2,0);e.uc.reg_write(UC_ARM64_REG_X30,base.STOP_ADDR)
    try:e.uc.emu_start(row['value'],base.STOP_ADDR,count=CTOR_LIMIT+1000)
    except UcError as exc:
        if e.stopped_reason is None:e.stopped_reason=f'Unicorn error: {exc}; pc={e.uc.reg_read(UC_ARM64_REG_PC):#x}'
    after=runtime_qword(e,TARGET_SLOT)
    return {'entry':row,'stop':e.stopped_reason,'instructions':e.stage2_insns,'slot_before':before,'slot_after':after,'pc':e.uc.reg_read(UC_ARM64_REG_PC),'history':decode(list(e.ctor_history))}

def render(rep):
    L=['# AppGuard libcompatible DT_INIT_ARRAY execution','',f"- bootstrap stop: `{rep['bootstrap_stop']}`",f"- DT_INIT_ARRAY: `{hex(rep['init_array']['va']) if rep['init_array']['va'] is not None else '-'}`",f"- DT_INIT_ARRAYSZ: **{rep['init_array']['size']}**",f"- entries: **{len(rep['init_array']['entries'])}**",f"- target slot before constructors: `0x{rep['slot_initial']:x}`",f"- target slot after constructors: `0x{rep['slot_final']:x}`",'', '## Constructor entries','', '| # | array slot | target | RVA | stop | instructions | slot before | slot after |','|---:|---:|---:|---:|---|---:|---:|---:|']
    for r in rep['constructors']:
        e=r['entry'];L.append(f"| {e['index']} | `0x{e['slot_rva']:x}` | `0x{e['value']:x}` | `{hex(e['rva']) if e['rva'] is not None else '-'}` | `{r['stop']}` | {r['instructions']} | `0x{r['slot_before']:x}` | `0x{r['slot_after']:x}` |")
    L += ['', '## Writes to +0x1eb858','']
    for w in rep['slot_writes']:L.append(f"- ctor {w['constructor']} instruction {w['instruction']} PC `0x{w['pc']:x}` -> `0x{w['value']:x}` ({w['size']} bytes)")
    if not rep['slot_writes']:L.append('- none')
    for r in rep['constructors']:
        if r['slot_after']!=r['slot_before'] or r['stop'] not in ('DT_INIT returned',None):
            L += ['',f"## Constructor {r['entry']['index']} tail",'', '```asm']
            for x in r['history'][-80:]:L.append(f"0x{x['pc']:x}: {x['mnemonic']} {x['op_str']}")
            L += ['```']
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=InitArrayLoader(a.libcompatible,a.out);boot=e.bootstrap();pre_rows=[pre.decrypt_range(e,r) for r in pre.RANGES]
    e.uc.hook_add(UC_HOOK_MEM_WRITE,e.slot_write_hook,begin=base.BIAS+TARGET_SLOT,end=base.BIAS+TARGET_SLOT+7)
    arr=init_array_entries(e);initial=runtime_qword(e,TARGET_SLOT);ctors=[]
    for row in arr['entries']:
        ctors.append(call_ctor(e,row))
        if ctors[-1]['slot_after']!=0:break
    rep={'bootstrap_stop':boot['stop'],'predecrypted_ranges':pre_rows,'init_array':arr,'slot_initial':initial,'constructors':ctors,'slot_final':runtime_qword(e,TARGET_SLOT),'slot_writes':e.slot_writes}
    (a.out/'init-array-execution.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'init-array-execution.md').write_text(render(rep))
    print(json.dumps({'bootstrap':boot['stop'],'init_array':arr,'slot_initial':hex(initial),'slot_final':hex(rep['slot_final']),'constructors':[(x['entry']['index'],hex(x['entry']['value']),x['stop'],x['instructions'],hex(x['slot_after'])) for x in ctors],'slot_writes':e.slot_writes},indent=2))
if __name__=='__main__':main()

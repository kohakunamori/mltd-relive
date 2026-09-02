#!/usr/bin/env python3
"""Execute libcompatible+0xc2a30, then run the real AppGuard JNI initializer."""
from __future__ import annotations
import argparse, importlib.util, json, struct
from pathlib import Path
from unicorn import UcError, UC_HOOK_MEM_WRITE
from unicorn.arm64_const import UC_ARM64_REG_X30, UC_ARM64_REG_PC

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-jni-init.py'
spec=importlib.util.spec_from_file_location('jni_init',P)
mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base
INSTALLER=0xC2A30
CLUSTER_LO=0x1EB800;CLUSTER_HI=0x1EB900
SLOTS=[0x1EB838,0x1EB840,0x1EB848,0x1EB850,0x1EB858,0x1EB860,0x1EB868]

def q(uc,rva):return struct.unpack('<Q',bytes(uc.mem_read(base.BIAS+rva,8)))[0]

class E(mod.JniInitEmulator):
    def __init__(self,image,out):super().__init__(image,out);self.installer_writes=[]
    def write_cluster(self,uc,access,address,size,value,user):
        self.installer_writes.append({'stage':self.stage,'pc':uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'address':address-base.BIAS,'size':size,'value':value})
    def run_installer(self):
        self.stage='installer';self.stage_insns=0;self.stopped_reason=None;self.hist.clear()
        self.uc.reg_write(UC_ARM64_REG_X30,base.STOP_ADDR)
        try:self.uc.emu_start(base.BIAS+INSTALLER,base.STOP_ADDR,count=2_000_000)
        except UcError as exc:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        return {'stop':self.stopped_reason,'instructions':self.stage_insns,'pc':self.uc.reg_read(UC_ARM64_REG_PC),
                'slots':{f'0x{x:x}':q(self.uc,x) for x in SLOTS},'writes':list(self.installer_writes),'external_calls':self.calls[-128:]}

def render(rep):
    i=rep['installer'];j=rep['jni'];L=['# AppGuard callback-installer execution','',
      f"- bootstrap: `{rep['bootstrap'].get('stop')}`",f"- installer: `+0x{INSTALLER:x}`",f"- installer stop: `{i['stop']}`",
      f"- installer instructions: **{i['instructions']}**",f"- JNI stop: `{j['stop']}`",f"- JNI instructions: **{j['instructions']}**",
      f"- JNI target slot `1eb858`: `0x{j['target_slot_value']:x}`",'', '## Slots after installer','', '| slot | value |','|---:|---:|']
    for k,v in i['slots'].items():L.append(f"| `{k}` | `0x{v:x}` |")
    L += ['','## Installer writes','', '| PC | slot | value | size |','|---:|---:|---:|---:|']
    for w in i['writes']:L.append(f"| `+0x{w['pc']:x}` | `+0x{w['address']:x}` | `0x{w['value']:x}` | {w['size']} |")
    L += ['','## JNI calls reached after installation','', '| # | index | API | details |','|---:|---:|---|---|']
    for n,c in enumerate(j['jni_calls']):
        m=c.get('method') or {};d=c.get('class_name') or c.get('text') or ('%s %s'%(c.get('method_name',''),c.get('method_signature',''))).strip() or ('%s %s'%(m.get('name',''),m.get('signature',''))).strip()
        L.append(f"| {n} | {c['index']} | `{c.get('name','')}` | `{d}` |")
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=E(base.Image(a.libcompatible),a.out);e.uc.hook_add(UC_HOOK_MEM_WRITE,e.write_cluster,begin=base.BIAS+CLUSTER_LO,end=base.BIAS+CLUSTER_HI-1)
    boot=e.run_bootstrap();inst=e.run_installer();pre=[mod.decrypt_range(e,r) for r in mod.RANGES];jni=e.run_jni()
    rep={'bootstrap':boot,'installer':inst,'predecrypted_ranges':pre,'jni':jni}
    (a.out/'callback-installer-emulation.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'callback-installer-emulation.md').write_text(render(rep))
    print(json.dumps({'installer_stop':inst['stop'],'slots':{k:hex(v) for k,v in inst['slots'].items()},'writes':inst['writes'],
      'jni_stop':jni['stop'],'jni_instructions':jni['instructions'],'jni_slot':hex(jni['target_slot_value']),
      'jni_tail':[{k:v for k,v in x.items() if k not in ('args','pc')} for x in jni['jni_calls'][-40:]]},indent=2))
if __name__=='__main__':main()

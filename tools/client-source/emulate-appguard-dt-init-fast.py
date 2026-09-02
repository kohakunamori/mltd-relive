#!/usr/bin/env python3
"""Continue DT_INIT by replacing one proven recursive Fibonacci helper exactly."""
from __future__ import annotations
import argparse,importlib.util,json
from pathlib import Path
from unicorn import UcError,UC_HOOK_CODE,UC_HOOK_INTR,UC_HOOK_MEM_INVALID
from unicorn.arm64_const import UC_ARM64_REG_W0,UC_ARM64_REG_W1,UC_ARM64_REG_X30,UC_ARM64_REG_PC

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-svc.py'
spec=importlib.util.spec_from_file_location('svc_emu',P); mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base

FIB_HELPER=0x171254
LOADER_CALLBACK_WRITE_DONE=0xc279c


def fib32(n:int)->int:
    a,b=0,1
    for _ in range(n & 0xffffffff): a,b=b&0xffffffff,(a+b)&0xffffffff
    return a & 0xffffffff

class FastEmulator(mod.SvcBootstrapEmulator):
    def __init__(self,image,out):
        super().__init__(image,out); self.fib_shortcuts=[]; self.callback_captured=False
    def code_hook(self,uc,address,size,user):
        rel=address-base.BIAS
        if rel==FIB_HELPER:
            n=uc.reg_read(UC_ARM64_REG_W1); result=fib32(n); lr=uc.reg_read(UC_ARM64_REG_X30)
            self.fib_shortcuts.append({'n':n,'result':result,'lr':lr,'callsite_rel':lr-base.BIAS-4 if base.BIAS<=lr<base.BIAS+0x4000000 else None})
            uc.reg_write(UC_ARM64_REG_W0,result); uc.reg_write(UC_ARM64_REG_PC,lr); return
        super().code_hook(uc,address,size,user)
        if rel==LOADER_CALLBACK_WRITE_DONE and not self.callback_captured:
            self.callback_captured=True; self.snapshot('loader-callback-installed',address)
    def run_fast(self):
        self.out.mkdir(parents=True,exist_ok=True); self.map_memory(); relocs=self.apply_relocations(); self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE,self.code_hook); self.uc.hook_add(UC_HOOK_INTR,self.syscall_hook); self.uc.hook_add(UC_HOOK_MEM_INVALID,self.invalid_hook)
        try:self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=base.MAX_INSNS+1000)
        except UcError as exc:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        if not self.callback_captured:
            try:self.snapshot('final-state',self.uc.reg_read(UC_ARM64_REG_PC))
            except Exception:pass
        return {'stop':self.stopped_reason,'instructions':self.insns,'fib_shortcuts':self.fib_shortcuts,'callback_captured':self.callback_captured,'direct_syscalls':self.svc_calls,'invalid_memory':self.invalid_memory,'snapshots':self.snapshots,'relocations':len(relocs),'external_calls':self.calls}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    em=FastEmulator(base.Image(a.libcompatible),a.out);r=em.run_fast();a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'dt-init-fast.json').write_text(json.dumps(r,indent=2)+'\n')
    L=['# AppGuard DT_INIT after exact Fibonacci shortcut','',f"- stop: `{r['stop']}`",f"- instructions: **{r['instructions']}**",f"- Fibonacci calls shortcut: **{len(r['fib_shortcuts'])}**",f"- loader callback captured: **{r['callback_captured']}**",'', '## Fibonacci shortcut calls','', '| n | result | caller |','|---:|---:|---:|']
    for x in r['fib_shortcuts']:L.append(f"| {x['n']} | `{x['result']:#x}` | `{hex(x['callsite_rel']) if x['callsite_rel'] is not None else '-'}` |")
    L += ['', '## Snapshots','', '| label | +0x98 | +0xa0 |','|---|---:|---:|']
    for s in r['snapshots']:
        t=s.get('asmfunction_table') or [0]*21
        L.append(f"| `{s['label']}` | `{t[19]:#x}` | `{t[20]:#x}` |")
    (a.out/'dt-init-fast.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'stop':r['stop'],'fib':r['fib_shortcuts'],'callback':r['callback_captured'],'snapshots':[(s['label'],(s.get('asmfunction_table') or [0]*21)[19:21]) for s in r['snapshots']]},indent=2))
if __name__=='__main__':main()

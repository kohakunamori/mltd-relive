#!/usr/bin/env python3
from __future__ import annotations
import argparse,importlib.util,json
from collections import Counter,deque
from pathlib import Path
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
from unicorn import UcError,UC_HOOK_CODE,UC_HOOK_INTR,UC_HOOK_MEM_INVALID
from unicorn.arm64_const import UC_ARM64_REG_PC

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-fast.py'
spec=importlib.util.spec_from_file_location('fast_emu',P); mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base
LIMIT=300_000

class P(mod.FastEmulator):
    def __init__(self,image,out):
        super().__init__(image,out); self.started=False; self.n=0; self.hits=Counter(); self.last=deque(maxlen=256)
    def code_hook(self,uc,address,size,user):
        super().code_hook(uc,address,size,user)
        rel=address-base.BIAS
        if rel==0x892c:self.started=True
        if self.started:
            self.n+=1;self.hits[rel]+=1;self.last.append(rel)
            if self.n>=LIMIT:
                self.stopped_reason=f'after-fib profile limit {LIMIT}';uc.emu_stop()
    def run_profile(self):
        self.out.mkdir(parents=True,exist_ok=True);self.map_memory();self.apply_relocations();self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE,self.code_hook);self.uc.hook_add(UC_HOOK_INTR,self.syscall_hook);self.uc.hook_add(UC_HOOK_MEM_INVALID,self.invalid_hook)
        try:self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=base.MAX_INSNS+1000)
        except UcError as e:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {e}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        top=self.hits.most_common(50);md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);regions=[];seen=set()
        for rel,h in top:
            st=rel&~0x3f
            if st in seen:continue
            seen.add(st)
            try:raw=bytes(self.uc.mem_read(base.BIAS+st,0x100))
            except UcError:continue
            rr=[{'pc':i.address-base.BIAS,'mnemonic':i.mnemonic,'op_str':i.op_str} for i in md.disasm(raw,base.BIAS+st)]
            regions.append({'start':st,'hits':sum(self.hits[x['pc']] for x in rr),'insns':rr})
        return {'stop':self.stopped_reason,'started':self.started,'sampled':self.n,'top':[{'pc':x,'hits':n} for x,n in top],'last':list(self.last),'regions':regions,'fib_shortcuts':self.fib_shortcuts,'snapshots':self.snapshots,'invalid_memory':self.invalid_memory,'direct_syscalls':self.svc_calls}

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    e=P(base.Image(a.libcompatible),a.out);r=e.run_profile();a.out.mkdir(parents=True,exist_ok=True);(a.out/'post-fib-profile.json').write_text(json.dumps(r,indent=2)+'\n')
    topmap={x['pc']:x['hits'] for x in r['top']};L=['# AppGuard execution profile after Fibonacci shortcut','',f"- sampled: **{r['sampled']}**",f"- stop: `{r['stop']}`",'', '## Hot PCs','', '| PC | hits |','|---:|---:|']
    for x in r['top']:L.append(f"| `0x{x['pc']:x}` | {x['hits']} |")
    L += ['','## Hot regions','']
    for reg in r['regions']:
        L += [f"### `0x{reg['start']:x}`",'', '```asm']
        for i in reg['insns']:L.append(f"0x{i['pc']:x}: {i['mnemonic']} {i['op_str']}"+('  ; HOT' if i['pc'] in topmap else ''))
        L += ['```','']
    L += ['## Last PCs','', '`'+' '.join(f"0x{x:x}" for x in r['last'])+'`','']
    (a.out/'post-fib-profile.md').write_text('\n'.join(L)+'\n');print(json.dumps({'stop':r['stop'],'top':r['top'][:12]},indent=2))
if __name__=='__main__':main()

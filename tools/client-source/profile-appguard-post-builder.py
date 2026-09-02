#!/usr/bin/env python3
from __future__ import annotations

import argparse
import importlib.util
import json
from collections import Counter, deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn import UcError, UC_HOOK_CODE, UC_HOOK_INTR, UC_HOOK_MEM_INVALID
from unicorn.arm64_const import UC_ARM64_REG_PC

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-svc.py'
spec=importlib.util.spec_from_file_location('svc_emu',P); mod=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(mod)
base=mod.base

POST_LIMIT=200_000

class Profiler(mod.SvcBootstrapEmulator):
    def __init__(self,image,out):
        super().__init__(image,out)
        self.post_started=False; self.post_count=0
        self.post_hits=Counter(); self.post_last=deque(maxlen=256)
    def code_hook(self,uc,address,size,user):
        super().code_hook(uc,address,size,user)
        rel=address-base.BIAS
        if rel==0x892c: self.post_started=True
        if self.post_started:
            self.post_count+=1; self.post_hits[rel]+=1; self.post_last.append(rel)
            if self.post_count>=POST_LIMIT:
                self.stopped_reason=f'post-builder profile limit {POST_LIMIT}'
                uc.emu_stop()
    def run_profile(self):
        self.out.mkdir(parents=True,exist_ok=True); self.map_memory(); relocs=self.apply_relocations(); self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE,self.code_hook); self.uc.hook_add(UC_HOOK_INTR,self.syscall_hook); self.uc.hook_add(UC_HOOK_MEM_INVALID,self.invalid_hook)
        try: self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=base.MAX_INSNS+1000)
        except UcError as exc:
            if self.stopped_reason is None: self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        top=self.post_hits.most_common(40)
        md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
        dis=[]
        seen=set()
        for rel,n in top:
            center=rel & ~0x3f
            if center in seen: continue
            seen.add(center)
            try: raw=bytes(self.uc.mem_read(base.BIAS+center,0x100))
            except UcError: continue
            rows=[]
            for i in md.disasm(raw,base.BIAS+center): rows.append({'pc':i.address-base.BIAS,'mnemonic':i.mnemonic,'op_str':i.op_str})
            dis.append({'region_start':center,'hot_hits':sum(self.post_hits.get(x['pc'],0) for x in rows),'instructions':rows})
        return {'stop':self.stopped_reason,'post_started':self.post_started,'post_count':self.post_count,'top_pcs':[{'pc':p,'hits':n} for p,n in top],'last_pcs':list(self.post_last),'regions':dis,'direct_syscalls':self.svc_calls,'invalid_memory':self.invalid_memory,'relocations':len(relocs),'snapshots':self.snapshots}

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--libcompatible',type=Path,required=True); ap.add_argument('--out',type=Path,required=True); a=ap.parse_args()
    em=Profiler(base.Image(a.libcompatible),a.out); rep=em.run_profile(); a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'post-builder-profile.json').write_text(json.dumps(rep,indent=2)+'\n')
    L=['# AppGuard post-builder execution profile','',f"- post-builder reached: **{rep['post_started']}**",f"- post-builder instructions sampled: **{rep['post_count']}**",f"- stop: `{rep['stop']}`",'', '## Hot PCs','', '| PC | Hits |','|---:|---:|']
    for x in rep['top_pcs']:L.append(f"| `0x{x['pc']:x}` | {x['hits']} |")
    L += ['', '## Hot-region disassembly','']
    for r in rep['regions']:
        L += [f"### `0x{r['region_start']:x}` (aggregate hot hits {r['hot_hits']})",'', '```asm']
        for i in r['instructions']:
            mark='  ; HOT' if dict((x['pc'],x['hits']) for x in rep['top_pcs']).get(i['pc']) else ''
            L.append(f"0x{i['pc']:x}: {i['mnemonic']} {i['op_str']}{mark}")
        L += ['```','']
    L += ['## Last PCs','', '`'+' '.join(f"0x{x:x}" for x in rep['last_pcs'])+'`','']
    (a.out/'post-builder-profile.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'stop':rep['stop'],'top':rep['top_pcs'][:10]},indent=2))
if __name__=='__main__':main()

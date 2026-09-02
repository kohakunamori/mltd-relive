#!/usr/bin/env python3
"""Run the AppGuard DT_INIT harness with Android/Bionic rand()/srand() semantics.

Android 11's bionic rand() delegates to random(), whose default TYPE_3 state is
the NetBSD random.c table equivalent to initstate(1, ..., 128).  AppGuard uses
rand() while building an internal 19-entry permutation/table, so a generic
zero-return stub cannot preserve its control flow.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-fast.py'
spec=importlib.util.spec_from_file_location('fast_emu',P)
mod=importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(mod)
base=mod.base

DEFAULT_STATE=[
    0x991539b1,0x16a5bce3,0x6774a4cd,0x3e01511e,0x4e508aaa,0x61048c05,
    0xf5500617,0x846b7115,0x6a19892c,0x896a97af,0xdb48f936,0x14898454,
    0x37ffd106,0xb58bff9c,0x59e17104,0xcf918a49,0x09378c83,0x52c7a471,
    0x8d293ea9,0x1f4fc301,0xc3db71be,0x39b44e1c,0xf8a44ef9,0x4c8b80b1,
    0x19edc328,0x87bf4bdd,0xc9b240e5,0xe9ee4b1b,0x4382aee7,0x535b6b41,
    0xf3bec5da,
]

class BionicRandom:
    def __init__(self):
        self.state=DEFAULT_STATE.copy()
        self.f=3
        self.r=0
    def random(self)->int:
        v=(self.state[self.f]+self.state[self.r]) & 0xffffffff
        self.state[self.f]=v
        out=(v>>1)&0x7fffffff
        self.f+=1
        if self.f>=31:
            self.f=0
            self.r+=1
        else:
            self.r+=1
            if self.r>=31:self.r=0
        return out
    def srand(self,seed:int):
        # NetBSD/Bionic srandom_unlocked TYPE_3 initialization.
        st=[seed & 0xffffffff]
        for _ in range(1,31):
            x=st[-1]
            # Source uses signed int for x1. Seed is normally small; preserve the
            # documented Park-Miller recurrence in the positive 31-bit domain.
            x &= 0x7fffffff
            if x==0:x=1
            hi=x//127773;lo=x%127773
            t=16807*lo-2836*hi
            if t<=0:t+=0x7fffffff
            st.append(t & 0xffffffff)
        self.state=st;self.f=3;self.r=0
        for _ in range(310):self.random()

class BionicEmulator(mod.FastEmulator):
    def __init__(self,image,out):
        super().__init__(image,out)
        self.bionic_rand=BionicRandom()
        self.rand_calls=[]
    def emulate_external(self,name,address):
        n=name.split('@',1)[0]
        if n in ('rand','random'):
            value=self.bionic_rand.random()
            self.rand_calls.append({'name':n,'value':value})
            self.stub_return(value)
            return
        if n in ('srand','srandom'):
            seed=self.uc.reg_read(base.UC_ARM64_REG_X0) & 0xffffffff
            self.bionic_rand.srand(seed)
            self.rand_calls.append({'name':n,'seed':seed})
            self.stub_return(0)
            return
        super().emulate_external(name,address)
    def run_bionic(self):
        r=self.run_fast()
        r['rand_calls']=self.rand_calls
        return r

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    e=BionicEmulator(base.Image(a.libcompatible),a.out);r=e.run_bionic();a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'dt-init-bionic.json').write_text(json.dumps(r,indent=2)+'\n')
    L=['# AppGuard DT_INIT with Android/Bionic rand semantics','',f"- stop: `{r['stop']}`",f"- instructions: **{r['instructions']}**",f"- rand/random calls: **{sum(1 for x in r['rand_calls'] if x['name'] in ('rand','random'))}**",f"- srand/srandom calls: **{sum(1 for x in r['rand_calls'] if x['name'] in ('srand','srandom'))}**",f"- loader callback captured: **{r['callback_captured']}**",'', '## First PRNG calls','', '| # | API | value/seed |','|---:|---|---:|']
    for i,x in enumerate(r['rand_calls'][:64]):L.append(f"| {i} | `{x['name']}` | `{x.get('value',x.get('seed')):#x}` |")
    L += ['', '## Runtime table snapshots','', '| checkpoint | +0x98 | +0xa0 |','|---|---:|---:|']
    for s in r['snapshots']:
        t=s.get('asmfunction_table') or [0]*21
        L.append(f"| `{s['label']}` | `{t[19]:#x}` | `{t[20]:#x}` |")
    (a.out/'dt-init-bionic.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'stop':r['stop'],'callback':r['callback_captured'],'rand_calls':len(r['rand_calls']),'snapshots':[(s['label'],(s.get('asmfunction_table') or [0]*21)[19:21]) for s in r['snapshots']]},indent=2))
if __name__=='__main__':main()

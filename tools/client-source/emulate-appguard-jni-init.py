#!/usr/bin/env python3
"""Execute the real AppGuardProxyApplication native initializer.

Sequence:
1. Run the exact libcompatible DT_INIT bootstrap until the proven runtime
   trampoline/callback table is installed.
2. Apply the two independently recovered 16-byte repeating-XOR transforms to
   the protected libcompatible ranges.  Both direct JNI helpers used by the
   real wrapper (0x1c0a0 and 0x38894) lie in the first recovered range.
3. Build a minimal JNIEnv function table and call the JNINativeMethod recovered
   from the official registration table:

     0x1338e4 _Z20CD898AC19EEF3BD64A91P7_JNIEnvP8_jobjectS2_

The harness watches libcompatible+0x1eb858, the NULL callback slot that blocks
SoLibraryStart in the standalone loader experiment. JNI behavior is added only
when the exact official path reaches it; opaque Java objects are nonzero handles,
not an attempt to emulate Android wholesale.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import struct
from collections import deque
from pathlib import Path

from unicorn import UcError, UC_HOOK_MEM_WRITE
from unicorn.arm64_const import *

HERE=Path(__file__).resolve().parent
BP=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('appguard_bionic',BP)
bionic=importlib.util.module_from_spec(spec); assert spec and spec.loader; spec.loader.exec_module(bionic)
base=bionic.base

JNI_ENTRY=0x1338E4
CALLBACK_DONE=bionic.mod.LOADER_CALLBACK_WRITE_DONE
PTR_CELL=0x1E5CF0
TARGET_SLOT=0x1EB858
STAGE_LIMIT=5_000_000
RANGES=[
    {'start':0x1B660,'end':0x4D1D0,'key_source':0x7080C,'name':'SoLibrary/JNI helper range'},
    {'start':0x4D1D0,'end':0x521FC,'key_source':0x1712A8,'name':'runtime loader range'},
]

JNI_NAMES={
    6:'FindClass',21:'NewGlobalRef',22:'DeleteGlobalRef',23:'DeleteLocalRef',24:'IsSameObject',25:'NewLocalRef',
    31:'GetObjectClass',33:'GetMethodID',113:'GetStaticMethodID',
    163:'NewString',164:'GetStringLength',165:'GetStringChars',166:'ReleaseStringChars',
    167:'NewStringUTF',168:'GetStringUTFLength',169:'GetStringUTFChars',170:'ReleaseStringUTFChars',
}


def qword(uc,addr):
    return struct.unpack('<Q',bytes(uc.mem_read(addr,8)))[0]


def decrypt_range(emu,row):
    start,end=row['start'],row['end']; size=end-start; full=size&~0xf
    key=bytes(emu.uc.mem_read(base.BIAS+row['key_source'],16))
    before=bytes(emu.uc.mem_read(base.BIAS+start,size)); after=bytearray(before)
    for i in range(full): after[i]^=key[i&15]
    emu.uc.mem_write(base.BIAS+start,bytes(after))
    return {**row,'key16':key.hex(),'xor_bytes':full,'remainder':size-full,
            'before_sha256':hashlib.sha256(before).hexdigest(),'after_sha256':hashlib.sha256(after).hexdigest()}


class JniInitEmulator(bionic.BionicEmulator):
    def __init__(self,image,out):
        super().__init__(image,out)
        self.stage='bootstrap'; self.stage_insns=0; self.hist=deque(maxlen=128)
        self.slot_writes=[]; self.ptr_writes=[]; self.jni_calls=[]; self.jni_stub_meta={}
        self.jni_env=0; self.jni_table=0; self.fake_context=0; self.fake_this=0
        self.fake_class=0; self.fake_method=0
        self.jni_strings={}; self.jni_string_buffers=[]

    def new_handle(self,size=0x40):
        return self.alloc_heap(size,True)

    def code_hook(self,uc,address,size,user):
        if self.stage=='bootstrap':
            super().code_hook(uc,address,size,user)
            rel=address-base.BIAS
            if rel==CALLBACK_DONE and self.callback_captured:
                self.stopped_reason='bootstrap callback table ready'
                uc.emu_stop()
            return
        self.stage_insns+=1
        self.hist.append(address)
        if self.stage_insns>STAGE_LIMIT:
            self.stopped_reason=f'JNI stage instruction limit {STAGE_LIMIT}'
            uc.emu_stop(); return
        if address==base.STOP_ADDR:
            self.stopped_reason='JNI wrapper returned'
            uc.emu_stop(); return
        super().code_hook(uc,address,size,user)

    def watch_write(self,uc,access,address,size,value,user):
        rel=address-base.BIAS
        row={'pc':uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'address':rel,'size':size,'value':value,
             'stage_instruction':self.stage_insns,'history':[x-base.BIAS for x in self.hist]}
        if TARGET_SLOT<=rel<TARGET_SLOT+8:self.slot_writes.append(row)
        if PTR_CELL<=rel<PTR_CELL+8:self.ptr_writes.append(row)

    def make_utf8_string(self, raw:bytes):
        h=self.new_handle(); self.jni_strings[h]={'utf8':bytes(raw),'utf16':raw.decode('utf-8','replace').encode('utf-16le')}; return h

    def make_utf16_string(self, raw:bytes):
        h=self.new_handle(); text=raw.decode('utf-16le','replace'); self.jni_strings[h]={'utf8':text.encode('utf-8'),'utf16':bytes(raw)}; return h

    def string_info(self,h:int):
        return self.jni_strings.get(h,{'utf8':b'','utf16':b''})

    def emulate_external(self,name,address):
        if name.startswith('jni_'):
            idx=int(name.split('_',2)[1]); xs=[self.uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(8)]
            row={'index':idx,'name':self.jni_stub_meta.get(address,{}).get('name',''), 'args':xs,'pc':address}
            ret=0
            try:
                if idx==6:
                    row['class_name']=self.cstring(xs[1],1024).decode('utf-8','replace'); ret=self.fake_class
                elif idx in (33,113):
                    row['method_name']=self.cstring(xs[2],1024).decode('utf-8','replace')
                    row['method_signature']=self.cstring(xs[3],1024).decode('utf-8','replace'); ret=self.fake_method
                elif idx==21: ret=xs[1]                           # NewGlobalRef
                elif idx in (22,23): ret=0                        # Delete*Ref
                elif idx==24: ret=1 if xs[1]==xs[2] else 0       # IsSameObject
                elif idx==25: ret=xs[1]                           # NewLocalRef
                elif idx==31: ret=self.fake_class                 # GetObjectClass
                elif idx==163:                                   # NewString(jchar*, jsize)
                    raw=bytes(self.uc.mem_read(xs[1],xs[2]*2)) if xs[1] and xs[2] else b''
                    ret=self.make_utf16_string(raw); row['text']=self.string_info(ret)['utf8'].decode('utf-8','replace')
                elif idx==164: ret=len(self.string_info(xs[1])['utf16'])//2
                elif idx==165:                                   # GetStringChars
                    raw=self.string_info(xs[1])['utf16']; p=self.alloc_heap(len(raw)+2,False); self.uc.mem_write(p,raw+b'\0\0')
                    if xs[2]: self.uc.mem_write(xs[2],b'\x01')
                    self.jni_string_buffers.append(p); ret=p
                elif idx==166: ret=0                              # ReleaseStringChars
                elif idx==167:                                   # NewStringUTF
                    raw=self.cstring(xs[1],65536); ret=self.make_utf8_string(raw); row['text']=raw.decode('utf-8','replace')
                elif idx==168: ret=len(self.string_info(xs[1])['utf8'])
                elif idx==169:                                   # GetStringUTFChars
                    raw=self.string_info(xs[1])['utf8']; p=self.alloc_heap(len(raw)+1,False); self.uc.mem_write(p,raw+b'\0')
                    if xs[2]: self.uc.mem_write(xs[2],b'\x01')
                    self.jni_string_buffers.append(p); ret=p
                elif idx==170: ret=0                              # ReleaseStringUTFChars
                elif idx in (94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112):
                    ret=self.fake_method
            except Exception as exc:
                row['model_error']=repr(exc); self.jni_calls.append(row)
                self.stopped_reason=f'JNI model {idx} failed: {exc}'; self.uc.emu_stop(); return
            self.jni_calls.append(row); self.stub_return(ret); return
        super().emulate_external(name,address)

    def setup_jni(self):
        self.jni_table=self.alloc_heap(0x1000,True); self.jni_env=self.alloc_heap(8,True)
        self.fake_context=self.new_handle(0x100); self.fake_this=self.new_handle(0x100)
        self.fake_class=self.new_handle(0x100); self.fake_method=self.new_handle(0x40)
        for idx in range(256):
            addr=self.alloc_stub(f'jni_{idx}_{JNI_NAMES.get(idx,"generic")}')
            self.jni_stub_meta[addr]={'index':idx,'name':JNI_NAMES.get(idx,'generic')}
            self.uc.mem_write(self.jni_table+idx*8,struct.pack('<Q',addr))
        self.uc.mem_write(self.jni_env,struct.pack('<Q',self.jni_table))

    def run_bootstrap(self):
        rep=self.run_bionic()
        if not self.callback_captured: raise RuntimeError(f'bootstrap failed before callback table: {rep.get("stop")}')
        return rep

    def run_jni(self):
        self.setup_jni(); self.stage='jni'; self.stage_insns=0; self.insns=0; self.stopped_reason=None; self.hist.clear()
        self.uc.hook_add(UC_HOOK_MEM_WRITE,self.watch_write,begin=base.BIAS+PTR_CELL,end=base.BIAS+TARGET_SLOT+7)
        self.uc.reg_write(UC_ARM64_REG_X0,self.jni_env); self.uc.reg_write(UC_ARM64_REG_X1,self.fake_this)
        self.uc.reg_write(UC_ARM64_REG_X2,self.fake_context); self.uc.reg_write(UC_ARM64_REG_X30,base.STOP_ADDR)
        try:self.uc.emu_start(base.BIAS+JNI_ENTRY,base.STOP_ADDR,count=STAGE_LIMIT+1000)
        except UcError as exc:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        return {'stop':self.stopped_reason,'instructions':self.stage_insns,'pc':self.uc.reg_read(UC_ARM64_REG_PC),
                'target_slot_value':qword(self.uc,base.BIAS+TARGET_SLOT),'pointer_cell_value':qword(self.uc,base.BIAS+PTR_CELL),
                'slot_writes':self.slot_writes,'ptr_writes':self.ptr_writes,'jni_calls':self.jni_calls,
                'external_calls':self.calls[-256:],'direct_syscalls':getattr(self,'svc_calls',[])[-128:],
                'invalid_memory':self.invalid_memory[-64:]}


def render(rep):
    j=rep['jni']; L=['# AppGuard `AppGuardProxyApplication` JNI initializer emulation','',
       f"- bootstrap stop: `{rep['bootstrap'].get('stop')}`",f"- callback table captured: **{rep['bootstrap'].get('callback_captured')}**",
       f"- JNI entry: `libcompatible+0x{JNI_ENTRY:x}`",f"- JNI stop: `{j['stop']}`",f"- JNI instructions: **{j['instructions']}**",
       f"- callback slot final: `0x{j['target_slot_value']:x}`",f"- callback-slot writes: **{len(j['slot_writes'])}**",'',
       '## Pre-decrypted ranges','', '| Range | Key source | Key | XOR bytes |','|---|---:|---|---:|']
    for r in rep['predecrypted_ranges']: L.append(f"| `0x{r['start']:x}..0x{r['end']:x}` | `0x{r['key_source']:x}` | `{r['key16']}` | {r['xor_bytes']} |")
    L += ['', '## JNI calls reached','', '| # | index | API | details |','|---:|---:|---|---|']
    for i,c in enumerate(j['jni_calls']):
        d=c.get('class_name') or c.get('text') or ('%s %s'%(c.get('method_name',''),c.get('method_signature',''))).strip()
        L.append(f"| {i} | {c['index']} | `{c.get('name','')}` | `{d}` |")
    L += ['', '## Writes to callback slot','']
    if j['slot_writes']:
        for w in j['slot_writes']: L.append(f"- PC `+0x{w['pc']:x}` wrote `0x{w['value']:x}` size={w['size']} at stage insn {w['stage_instruction']}")
    else:L.append('- none')
    if j['invalid_memory']: L += ['', '## Last invalid memory events','', '```json',json.dumps(j['invalid_memory'],indent=2),'```']
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--libcompatible',type=Path,required=True); ap.add_argument('--out',type=Path,required=True); a=ap.parse_args(); a.out.mkdir(parents=True,exist_ok=True)
    e=JniInitEmulator(base.Image(a.libcompatible),a.out); boot=e.run_bootstrap(); pre=[decrypt_range(e,r) for r in RANGES]; j=e.run_jni()
    rep={'bootstrap':boot,'predecrypted_ranges':pre,'jni':j}
    (a.out/'jni-init-emulation.json').write_text(json.dumps(rep,indent=2)+'\n'); (a.out/'jni-init-emulation.md').write_text(render(rep))
    print(json.dumps({'bootstrap':boot.get('stop'),'jni_stop':j['stop'],'jni_pc':hex(j['pc']),'slot':hex(j['target_slot_value']),
                      'slot_writes':j['slot_writes'],'jni_calls':[{k:v for k,v in x.items() if k not in ('args','pc')} for x in j['jni_calls']],
                      'invalid_tail':j['invalid_memory'][-8:]},indent=2))

if __name__=='__main__': main()

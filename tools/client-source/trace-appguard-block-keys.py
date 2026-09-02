#!/usr/bin/env python3
"""Capture AppGuard's per-block XOR key stream during runtime code decryption.

The decrypted 0x4d1d0..0x521fc descriptor is processed byte-wise by the flattened
0xfxxx loop. At +0xf614 a key byte has just been loaded from [x23 + block_index +
8], and +0xf624 stores ciphertext XOR key back to [x28 + offset].  Capturing
state at +0xf618 therefore exposes the exact key schedule without guessing.
"""
from __future__ import annotations

import argparse,collections,hashlib,importlib.util,json,struct
from pathlib import Path

from unicorn import UC_HOOK_CODE,UC_HOOK_MEM_WRITE,UcError
from unicorn.arm64_const import UC_ARM64_REG_X19,UC_ARM64_REG_X23,UC_ARM64_REG_X24,UC_ARM64_REG_X28,UC_ARM64_REG_PC

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('bionic_emu',P)
bionic=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(bionic)
base=bionic.base
RUN_LIMIT=9_000_000;base.MAX_INSNS=RUN_LIMIT
CAPTURE_PC=0xF618
TARGET_START=0x4D1D0
TARGET_END=0x521FC
TARGET_SIZE=TARGET_END-TARGET_START


def q32(uc,a):return struct.unpack('<I',bytes(uc.mem_read(a,4)))[0]

class Trace(bionic.BionicEmulator):
    def __init__(self,image,out):
        super().__init__(image,out)
        self.byte_rows=[];self.key_states=[];self.last_key=None;self.context_writes=[];self.ctx_ptr=None
        self.first_source=None
    def code_hook(self,uc,address,size,user):
        super().code_hook(uc,address,size,user)
        rel=address-base.BIAS
        if rel!=CAPTURE_PC:return
        x28=uc.reg_read(UC_ARM64_REG_X28);x23=uc.reg_read(UC_ARM64_REG_X23);off=uc.reg_read(UC_ARM64_REG_X19)&0xffffffffffffffff;key=uc.reg_read(UC_ARM64_REG_X24)&0xff
        if x28!=base.BIAS+TARGET_START:return
        self.ctx_ptr=x23
        if off>=TARGET_SIZE:return
        try:src=bytes(uc.mem_read(x28+off,1))[0];k16=bytes(uc.mem_read(x23+8,16));ctx_head=bytes(uc.mem_read(x23,0x38))
        except UcError:return
        if self.first_source is None:
            try:self.first_source=bytes(uc.mem_read(x28,TARGET_SIZE))
            except UcError:pass
        row={'sequence':len(self.byte_rows),'offset':off,'cipher_byte':src,'key_byte':key,'plain_byte':src^key,'key16':k16.hex(),'context_head':ctx_head.hex(),'instruction':self.insns}
        self.byte_rows.append(row)
        if k16!=self.last_key:
            self.key_states.append({'sequence':len(self.byte_rows)-1,'offset':off,'instruction':self.insns,'key16':k16.hex(),'context_head':ctx_head.hex()})
            self.last_key=k16
    def write_hook(self,uc,access,address,size,value,user):
        if self.ctx_ptr is None:return
        if self.ctx_ptr+8<=address<self.ctx_ptr+24 and len(self.context_writes)<20000:
            self.context_writes.append({'instruction':self.insns,'pc':uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'address':address,'context_offset':address-self.ctx_ptr,'size':size,'value':value})
    def run_trace(self):
        self.map_memory();rel=self.apply_relocations();self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE,self.code_hook);self.uc.hook_add(base.UC_HOOK_INTR,self.syscall_hook);self.uc.hook_add(base.UC_HOOK_MEM_INVALID,self.invalid_hook)
        self.uc.hook_add(UC_HOOK_MEM_WRITE,self.write_hook,begin=base.STACK_BASE,end=base.STACK_BASE+base.STACK_SIZE-1)
        try:self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=RUN_LIMIT+1000)
        except UcError as exc:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        final=bytes(self.uc.mem_read(base.BIAS+TARGET_START,TARGET_SIZE))
        recovered=bytearray(self.first_source or b'')
        for r in self.byte_rows:
            if r['offset']<len(recovered):recovered[r['offset']]=r['plain_byte']
        return {'stop':self.stopped_reason,'instructions':self.insns,'target':{'start':TARGET_START,'end':TARGET_END,'size':TARGET_SIZE},'captured_bytes':len(self.byte_rows),'unique_offsets':len(set(x['offset'] for x in self.byte_rows)),'key_state_changes':self.key_states,'context_key_writes':self.context_writes,'byte_rows':self.byte_rows,'first_source_sha256':hashlib.sha256(self.first_source).hexdigest() if self.first_source else None,'recovered_sha256':hashlib.sha256(recovered).hexdigest() if recovered else None,'final_sha256':hashlib.sha256(final).hexdigest(),'recovered_matches_final':bytes(recovered)==final if recovered else False,'relocations':len(rel)}

def render(r):
    L=['# AppGuard per-block XOR key trace','',f"- stop: `{r['stop']}`",f"- target: `0x{r['target']['start']:x}..0x{r['target']['end']:x}` ({r['target']['size']} bytes)",f"- captured byte operations: **{r['captured_bytes']}**",f"- unique target offsets: **{r['unique_offsets']}**",f"- key-state changes: **{len(r['key_state_changes'])}**",f"- source SHA-256: `{r['first_source_sha256']}`",f"- reconstructed SHA-256: `{r['recovered_sha256']}`",f"- final runtime SHA-256: `{r['final_sha256']}`",f"- reconstructed == final: **{r['recovered_matches_final']}**",'', '## Key-state transitions','', '| # | sequence | target offset | instruction | key16 | context head |','|---:|---:|---:|---:|---|---|']
    for i,k in enumerate(r['key_state_changes'][:4000]):L.append(f"| {i} | {k['sequence']} | `0x{k['offset']:x}` | {k['instruction']} | `{k['key16']}` | `{k['context_head']}` |")
    L += ['', '## Writes that refresh context key bytes','', '| instruction | PC | ctx + | size | value |','|---:|---:|---:|---:|---:|']
    for w in r['context_key_writes'][:4000]:L.append(f"| {w['instruction']} | `0x{w['pc']:x}` | `0x{w['context_offset']:x}` | {w['size']} | `0x{w['value']:x}` |")
    L += ['', '## First byte operations','', '| seq | offset | cipher | key | plain | key16 |','|---:|---:|---:|---:|---:|---|']
    for x in r['byte_rows'][:256]:L.append(f"| {x['sequence']} | `0x{x['offset']:x}` | `0x{x['cipher_byte']:02x}` | `0x{x['key_byte']:02x}` | `0x{x['plain_byte']:02x}` | `{x['key16']}` |")
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=Trace(base.Image(a.libcompatible),a.out);r=e.run_trace();(a.out/'block-key-trace.json').write_text(json.dumps(r,indent=2)+'\n');(a.out/'block-key-trace.md').write_text(render(r))
    print(json.dumps({'stop':r['stop'],'captured':r['captured_bytes'],'unique_offsets':r['unique_offsets'],'key_changes':len(r['key_state_changes']),'matches':r['recovered_matches_final'],'first_keys':r['key_state_changes'][:12],'key_write_pcs':collections.Counter(x['pc'] for x in r['context_key_writes']).most_common(20)},indent=2))
if __name__=='__main__':main()

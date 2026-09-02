#!/usr/bin/env python3
"""Map every AppGuard protected range to its repeating 16-byte XOR key.

The flattened decryptor copies two qwords from x8 into x23+8/+0x10 at
0xf0a4..0xf0b0, then applies that 16-byte value cyclically at 0xf618/0xf624.
This pass records the pre-copy x8 source, target x28, all observed decryptor
ranges, and correlates them with 0x20-byte mmap descriptors of the form
[start, end, end-start, descriptor_word].
"""
from __future__ import annotations

import argparse,collections,hashlib,importlib.util,json,struct
from pathlib import Path
from unicorn import UC_HOOK_CODE,UC_HOOK_INTR,UC_HOOK_MEM_INVALID,UcError
from unicorn.arm64_const import *

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('bionic_emu',P)
bionic=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(bionic)
base=bionic.base
RUN_LIMIT=12_000_000;base.MAX_INSNS=RUN_LIMIT
KEY_COPY_PC=0xF0A4
BYTE_PC=0xF618


def read16(uc,a):
    try:return bytes(uc.mem_read(a,16))
    except UcError:return None


def classify_ptr(v):
    if base.BIAS<=v<base.BIAS+0x4000000:return 'libcompatible',v-base.BIAS
    if base.MMAP_BASE<=v<base.MMAP_BASE+base.MMAP_SIZE:return 'mmap',v-base.MMAP_BASE
    if base.HEAP_BASE<=v<base.HEAP_BASE+base.HEAP_SIZE:return 'heap',v-base.HEAP_BASE
    if base.STACK_BASE<=v<base.STACK_BASE+base.STACK_SIZE:return 'stack',v-base.STACK_BASE
    return 'other',None


def descriptors(emu):
    lo=base.MMAP_BASE+0x1000;hi=min(emu.mmap_next,base.MMAP_BASE+0x10000)
    raw=bytes(emu.uc.mem_read(lo,hi-lo));rows=[]
    for off in range(0,len(raw)-31,8):
        q=struct.unpack_from('<QQQQ',raw,off)
        if base.BIAS<=q[0]<base.BIAS+0x4000000 and base.BIAS<q[1]<=base.BIAS+0x4000000 and q[1]>q[0] and q[1]-q[0]==q[2]:
            rows.append({'storage':lo+off,'mmap_offset':lo+off-base.MMAP_BASE,'start':q[0]-base.BIAS,'end':q[1]-base.BIAS,'size':q[2],'word3':q[3]})
    # remove overlapping detections caused by 8-byte sliding; proper records are 0x20 aligned relative to one another.
    if not rows:return []
    # choose phase with most records spaced on 0x20 boundaries.
    phases=collections.Counter(r['mmap_offset']&0x1f for r in rows);phase=phases.most_common(1)[0][0]
    rows=[r for r in rows if (r['mmap_offset']&0x1f)==phase]
    return rows


class Mapper(bionic.BionicEmulator):
    def __init__(self,image,out):
        super().__init__(image,out);self.key_copies=[];self.ranges={};self.last_copy=None
    def code_hook(self,uc,address,size,user):
        super().code_hook(uc,address,size,user);rel=address-base.BIAS
        if rel==KEY_COPY_PC:
            src=uc.reg_read(UC_ARM64_REG_X8);target=uc.reg_read(UC_ARM64_REG_X28);ctx=uc.reg_read(UC_ARM64_REG_X23);key=read16(uc,src)
            sk,so=classify_ptr(src);tk,to=classify_ptr(target)
            row={'instruction':self.insns,'source':src,'source_class':sk,'source_offset':so,'target':target,'target_class':tk,'target_rel':to if tk=='libcompatible' else None,'context':ctx,'key16':key.hex() if key else None}
            self.key_copies.append(row);self.last_copy=row
        elif rel==BYTE_PC:
            target=uc.reg_read(UC_ARM64_REG_X28);off=uc.reg_read(UC_ARM64_REG_X19)&0xffffffffffffffff;key=uc.reg_read(UC_ARM64_REG_X24)&0xff
            tk,to=classify_ptr(target)
            if tk!='libcompatible':return
            r=self.ranges.setdefault(to,{'target_rel':to,'first_instruction':self.insns,'last_instruction':self.insns,'operations':0,'min_offset':None,'max_offset':None,'keys':collections.Counter(),'key_sources':collections.Counter()})
            r['last_instruction']=self.insns;r['operations']+=1;r['min_offset']=off if r['min_offset'] is None else min(r['min_offset'],off);r['max_offset']=off if r['max_offset'] is None else max(r['max_offset'],off);r['keys'][key]+=1
            if self.last_copy and self.last_copy.get('target_rel')==to and self.last_copy.get('key16'):
                r['key16']=self.last_copy['key16'];r['key_source']=self.last_copy['source'];r['key_source_class']=self.last_copy['source_class'];r['key_source_offset']=self.last_copy['source_offset']
    def run_map(self):
        self.map_memory();rel=self.apply_relocations();self.setup_registers();self.uc.hook_add(UC_HOOK_CODE,self.code_hook);self.uc.hook_add(UC_HOOK_INTR,self.syscall_hook);self.uc.hook_add(UC_HOOK_MEM_INVALID,self.invalid_hook)
        try:self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=RUN_LIMIT+1000)
        except UcError as exc:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        ds=descriptors(self);by_start={d['start']:d for d in ds};out=[]
        for start,r in sorted(self.ranges.items()):
            rr={k:(dict(v) if isinstance(v,collections.Counter) else v) for k,v in r.items()};rr['descriptor']=by_start.get(start);out.append(rr)
        return {'stop':self.stopped_reason,'instructions':self.insns,'descriptors':ds,'key_copies':self.key_copies,'decrypt_ranges':out,'relocations':len(rel)}


def render(r):
    L=['# AppGuard protected-range XOR map','',f"- stop: `{r['stop']}`",f"- instructions: **{r['instructions']}**",f"- parsed descriptors: **{len(r['descriptors'])}**",f"- observed key copies: **{len(r['key_copies'])}**",f"- observed decrypted ranges: **{len(r['decrypt_ranges'])}**",'', '## Observed decrypt ranges','', '| start | descriptor end | size | ops | offset span | key16 | key source | descriptor word3 |','|---:|---:|---:|---:|---|---|---|---:|']
    for x in r['decrypt_ranges']:
        d=x.get('descriptor') or {};src=f"{x.get('key_source_class','-')}:{hex(x.get('key_source_offset')) if x.get('key_source_offset') is not None else hex(x.get('key_source',0))}"
        L.append(f"| `0x{x['target_rel']:x}` | `{hex(d.get('end')) if d.get('end') is not None else '-'}` | `{hex(d.get('size')) if d.get('size') is not None else '-'}` | {x['operations']} | `{hex(x['min_offset']) if x['min_offset'] is not None else '-'}..{hex(x['max_offset']) if x['max_offset'] is not None else '-'}` | `{x.get('key16','-')}` | `{src}` | `{hex(d.get('word3')) if d.get('word3') is not None else '-'}` |")
    L += ['', '## Descriptor table','', '| mmap + | start | end | size | word3 | observed key |','|---:|---:|---:|---:|---:|---|']
    km={x['target_rel']:x.get('key16') for x in r['decrypt_ranges']}
    for d in r['descriptors']:
        L.append(f"| `0x{d['mmap_offset']:x}` | `0x{d['start']:x}` | `0x{d['end']:x}` | `0x{d['size']:x}` | `0x{d['word3']:016x}` | `{km.get(d['start'],'-')}` |")
    L += ['', '## Raw key-copy events','', '| instruction | target | source | source class | key16 |','|---:|---:|---:|---|---|']
    for x in r['key_copies'][:2000]:L.append(f"| {x['instruction']} | `{hex(x['target_rel']) if x.get('target_rel') is not None else hex(x['target'])}` | `0x{x['source']:x}` | `{x['source_class']}:{hex(x['source_offset']) if x.get('source_offset') is not None else '-'}` | `{x.get('key16')}` |")
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=Mapper(base.Image(a.libcompatible),a.out);r=e.run_map();(a.out/'xor-range-map.json').write_text(json.dumps(r,indent=2)+'\n');(a.out/'xor-range-map.md').write_text(render(r));print(json.dumps({'stop':r['stop'],'descriptor_count':len(r['descriptors']),'ranges':[{k:x.get(k) for k in ('target_rel','operations','key16','key_source_class','key_source_offset','descriptor')} for x in r['decrypt_ranges']],'key_copies':r['key_copies'][:20]},indent=2))
if __name__=='__main__':main()

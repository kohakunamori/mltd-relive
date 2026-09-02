#!/usr/bin/env python3
"""Recover provenance of the null function slot used by SoLibraryStart.

After offline decryption, SoLibraryStart reaches:
  +0xc0d78  adrp x8, +0x1e5000
  +0xc0d7c  ldr  x8, [x8,#0xcf0]   -> +0x1eb858
  +0xc0d84  ldr  x8, [x8]         -> NULL in the minimal harness
  +0xc0d88  blr  x8

This pass correlates ELF relocations/symbols, runtime writes during an extended
DT_INIT, the nearby BSS pointer table, and static xrefs from the two proven
offline-decrypted ranges.
"""
from __future__ import annotations

import argparse,hashlib,importlib.util,json,struct
from pathlib import Path
from collections import deque

from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM,CS_OP_IMM,CS_OP_MEM,CS_OP_REG
from unicorn import UC_HOOK_CODE,UC_HOOK_MEM_WRITE,UC_HOOK_INTR,UC_HOOK_MEM_INVALID,UcError
from unicorn.arm64_const import *

HERE=Path(__file__).resolve().parent
BP=HERE/'emulate-appguard-dt-init-bionic.py'
spec=importlib.util.spec_from_file_location('bionic',BP)
bionic=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(bionic)
base=bionic.base
RUN_LIMIT=30_000_000;base.MAX_INSNS=RUN_LIMIT
PTR_CELL=0x1E5CF0
TARGET_SLOT=0x1EB858
WATCH_LO=0x1EB800
WATCH_HI=0x1EB900
RANGES=[(0x1B660,0x4D1D0,0x7080C),(0x4D1D0,0x521FC,0x1712A8)]

def decrypt_loaded(uc,start,end,keysrc):
    size=end-start;full=size&~0xf
    key=bytes(uc.mem_read(base.BIAS+keysrc,16));raw=bytearray(uc.mem_read(base.BIAS+start,size))
    for i in range(full):raw[i]^=key[i&15]
    return bytes(raw),key

def nearest_symbol(image,addr):
    best=None
    empty=0
    for i in range(0,4096):
        s=image.dynsym(i)
        if not s.get('name') and not s.get('value'):
            empty+=1
            if empty>128 and i>512:break
            continue
        empty=0
        v=s.get('value',0)
        if v<=addr and (best is None or v>best['value']):best=s
    if not best:return None
    return {'name':best.get('name'),'value':best.get('value'),'size':best.get('size'),'offset':addr-best.get('value',0),'type':best.get('type')}

class Trace(bionic.BionicEmulator):
    def __init__(self,image,out):
        super().__init__(image,out);self.slot_writes=[];self.ptr_writes=[];self.checkpoints=[];self.hist=deque(maxlen=64)
    def code_hook(self,uc,address,size,user):
        super().code_hook(uc,address,size,user)
        self.hist.append(address-base.BIAS)
        if self.insns in (2_000_000,4_000_000,8_000_000,12_000_000,20_000_000,30_000_000):self.snap_slot(f'insn-{self.insns}')
    def write_hook(self,uc,access,address,size,value,user):
        rel=address-base.BIAS
        row={'instruction':self.insns,'pc':uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'address':rel,'size':size,'value':value,'history':list(self.hist)}
        if TARGET_SLOT<=rel<TARGET_SLOT+8:self.slot_writes.append(row)
        if PTR_CELL<=rel<PTR_CELL+8:self.ptr_writes.append(row)
    def snap_slot(self,label):
        try:ptr=struct.unpack('<Q',bytes(self.uc.mem_read(base.BIAS+PTR_CELL,8)))[0]
        except Exception:ptr=None
        try:slot=struct.unpack('<Q',bytes(self.uc.mem_read(base.BIAS+TARGET_SLOT,8)))[0]
        except Exception:slot=None
        try:near=bytes(self.uc.mem_read(base.BIAS+WATCH_LO,WATCH_HI-WATCH_LO))
        except Exception:near=b''
        self.checkpoints.append({'label':label,'instruction':self.insns,'pc':self.uc.reg_read(UC_ARM64_REG_PC)-base.BIAS,'ptr_cell':ptr,'target_slot':slot,'near_qwords':[struct.unpack_from('<Q',near,i)[0] for i in range(0,len(near)-7,8)]})
    def run_trace(self):
        self.map_memory();relocs=self.apply_relocations();self.setup_registers();self.snap_slot('after-relocations')
        self.uc.hook_add(UC_HOOK_CODE,self.code_hook);self.uc.hook_add(UC_HOOK_INTR,self.syscall_hook);self.uc.hook_add(UC_HOOK_MEM_INVALID,self.invalid_hook)
        self.uc.hook_add(UC_HOOK_MEM_WRITE,self.write_hook,begin=base.BIAS+PTR_CELL,end=base.BIAS+TARGET_SLOT+7)
        try:self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=RUN_LIMIT+1000)
        except UcError as exc:
            if self.stopped_reason is None:self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        self.snap_slot('final')
        return relocs

def reloc_info(image):
    rows=[]
    for r in image.relas():
        if r['offset'] in (PTR_CELL,TARGET_SLOT) or abs(r['offset']-PTR_CELL)<0x40 or abs(r['offset']-TARGET_SLOT)<0x40:
            rows.append(r)
    return rows

def scan_xrefs(uc,image):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True;rows=[]
    for start,end,keysrc in RANGES:
        data,key=decrypt_loaded(uc,start,end,keysrc)
        pages={}
        for ins in md.disasm(data,start):
            if ins.mnemonic=='adrp' and len(ins.operands)>=2 and ins.operands[0].type==CS_OP_REG and ins.operands[1].type==CS_OP_IMM:
                pages[ins.operands[0].reg]=ins.operands[1].imm
            for op in ins.operands:
                if op.type!=CS_OP_MEM:continue
                b=op.mem.base
                if b not in pages:continue
                addr=pages[b]+op.mem.disp
                if abs(addr-PTR_CELL)<0x80 or abs(addr-TARGET_SLOT)<0x80:
                    rows.append({'pc':ins.address,'mnemonic':ins.mnemonic,'op_str':ins.op_str,'address':addr,'range_start':start})
    return rows

def render(rep):
    L=['# SoLibraryStart null-slot provenance','',f"- run stop: `{rep['stop']}`",f"- instructions: **{rep['instructions']}**",f"- pointer cell: `+0x{PTR_CELL:x}`",f"- target slot: `+0x{TARGET_SLOT:x}`",'', '## ELF relocations near the cells','']
    if rep['relocations']:
        for r in rep['relocations']:L.append(f"- `+0x{r['offset']:x}` type={r['type']} addend=`0x{r['addend'] & ((1<<64)-1):x}` symbol=`{r['symbol'].get('name')}` value=`0x{r['symbol'].get('value',0):x}`")
    else:L.append('- none')
    L += ['', '## Runtime slot checkpoints','', '| checkpoint | instruction | PC | [ptr cell] | [target slot] |','|---|---:|---:|---:|---:|']
    for s in rep['checkpoints']:L.append(f"| `{s['label']}` | {s['instruction']} | `0x{s['pc']:x}` | `{hex(s['ptr_cell']) if s['ptr_cell'] is not None else '-'}` | `{hex(s['target_slot']) if s['target_slot'] is not None else '-'}` |")
    L += ['', '## Writes to target slot','']
    for w in rep['slot_writes']:L.append(f"- insn {w['instruction']} PC `0x{w['pc']:x}` value `0x{w['value']:x}` size {w['size']}")
    if not rep['slot_writes']:L.append('- none')
    L += ['', '## Writes to pointer cell','']
    for w in rep['ptr_writes']:L.append(f"- insn {w['instruction']} PC `0x{w['pc']:x}` value `0x{w['value']:x}` size {w['size']}")
    if not rep['ptr_writes']:L.append('- none')
    L += ['', '## Decrypted-code xrefs near the cells','', '| PC | instruction | resolved address |','|---:|---|---:|']
    for x in rep['xrefs']:L.append(f"| `0x{x['pc']:x}` | `{x['mnemonic']} {x['op_str']}` | `0x{x['address']:x}` |")
    if not rep['xrefs']:L.append('| - | - | - |')
    L += ['', '## Nearest dynamic symbols','',f"- pointer cell: `{rep['ptr_symbol']}`",f"- target slot: `{rep['slot_symbol']}`",'']
    return '\n'.join(L)

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    image=base.Image(a.libcompatible);e=Trace(image,a.out);e.run_trace();rep={'stop':e.stopped_reason,'instructions':e.insns,'relocations':reloc_info(image),'checkpoints':e.checkpoints,'slot_writes':e.slot_writes,'ptr_writes':e.ptr_writes,'xrefs':scan_xrefs(e.uc,image),'ptr_symbol':nearest_symbol(image,PTR_CELL),'slot_symbol':nearest_symbol(image,TARGET_SLOT)}
    (a.out/'sostart-slot-provenance.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'sostart-slot-provenance.md').write_text(render(rep)+'\n')
    print(json.dumps({'stop':rep['stop'],'insns':rep['instructions'],'checkpoints':[(x['label'],hex(x['ptr_cell'] or 0),hex(x['target_slot'] or 0)) for x in rep['checkpoints']],'slot_writes':rep['slot_writes'],'ptr_writes':rep['ptr_writes'],'xrefs':rep['xrefs'][:20]},indent=2))
if __name__=='__main__':main()

#!/usr/bin/env python3
from __future__ import annotations
import argparse, json, struct
from pathlib import Path
from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_MEM

class Img:
    def __init__(self,p):
        self.segs=[]; self.dyn={}
        with p.open('rb') as f:
            e=ELFFile(f)
            for s in e.iter_segments():
                if str(s['p_type'])=='PT_LOAD':self.segs.append((int(s['p_vaddr']),int(s['p_filesz']),s.data()))
                if isinstance(s,DynamicSegment) or str(s['p_type'])=='PT_DYNAMIC':
                    try:
                        for t in s.iter_tags():
                            v=getattr(t.entry,'d_val',None)
                            if v is None:v=getattr(t.entry,'d_ptr',None)
                            if v is not None:self.dyn[str(t.entry.d_tag)]=int(v)
                    except:pass
    def read(self,a,n):
        for v,z,d in self.segs:
            if v<=a and a+n<=v+z:return d[a-v:a-v+n]
        return b''
    def cstr(self,a):return self.read(a,512).split(b'\0',1)[0].decode('utf-8','replace')

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--lib',type=Path,required=True);ap.add_argument('--plt',action='append',required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    I=Img(a.lib);d=I.dyn;rels={};jr=d['DT_JMPREL'];sz=d['DT_PLTRELSZ'];sym=d['DT_SYMTAB'];st=d['DT_STRTAB'];se=d.get('DT_SYMENT',24)
    for o in range(0,sz,24):
        ro,ri,ra=struct.unpack('<QQq',I.read(jr+o,24));si=ri>>32;sr=I.read(sym+si*se,24);sn=struct.unpack_from('<I',sr)[0];rels[ro]={'symbol':I.cstr(st+sn),'sym_index':si,'rela_va':jr+o,'got':ro}
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True;res=[]
    for q in a.plt:
        pc=int(q,0);ins=list(md.disasm(I.read(pc,16),pc,count=4));got=None
        if len(ins)==4 and ins[0].mnemonic=='adrp' and ins[1].mnemonic=='ldr':got=int(ins[0].operands[1].imm)+int(ins[1].operands[1].mem.disp)
        res.append({'plt':pc,'got':got,'relocation':rels.get(got),'instructions':[f'{x.mnemonic} {x.op_str}' for x in ins]})
    a.out.parent.mkdir(parents=True,exist_ok=True);a.out.write_text(json.dumps(res,indent=2)+'\n')
    for r in res:print(f"PLT {r['plt']:#x} GOT {r['got']:#x} -> {(r['relocation'] or {}).get('symbol')}")
if __name__=='__main__':main()

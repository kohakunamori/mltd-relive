#!/usr/bin/env python3
"""Static ELF provenance for libcompatible's SoLibraryStart callback slot."""
from __future__ import annotations

import argparse,importlib.util,json,struct
from pathlib import Path
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM,CS_OP_IMM,CS_OP_MEM,CS_OP_REG

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-dt-init.py'
spec=importlib.util.spec_from_file_location('baseemu',P)
base=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(base)
PTR_CELL=0x1E5CF0;TARGET_SLOT=0x1EB858
RANGES=[(0x1B660,0x4D1D0,0x7080C),(0x4D1D0,0x521FC,0x1712A8)]

def dynsym_count(img):
    h=img.dynamic.get('DT_HASH')
    if h is not None:
        b=img.read_file_va(h,8)
        if len(b)==8:return struct.unpack('<II',b)[1]
    return 4096

def symbols(img):
    return [img.dynsym(i) for i in range(dynsym_count(img))]

def dec_range(img,start,end,keysrc):
    raw=bytearray(img.read_file_va(start,end-start));key=img.read_file_va(keysrc,16);full=len(raw)&~0xf
    for i in range(full):raw[i]^=key[i&15]
    return bytes(raw),key

def static_xrefs(img):
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);md.detail=True;out=[]
    for start,end,keysrc in RANGES:
        data,key=dec_range(img,start,end,keysrc);pages={}
        for ins in md.disasm(data,start):
            if ins.mnemonic=='adrp' and len(ins.operands)>=2 and ins.operands[0].type==CS_OP_REG and ins.operands[1].type==CS_OP_IMM:
                pages[ins.operands[0].reg]=ins.operands[1].imm
                continue
            for op in ins.operands:
                if op.type!=CS_OP_MEM or op.mem.base not in pages:continue
                addr=pages[op.mem.base]+op.mem.disp
                if abs(addr-PTR_CELL)<=0x100 or abs(addr-TARGET_SLOT)<=0x100:
                    out.append({'pc':ins.address,'mnemonic':ins.mnemonic,'op_str':ins.op_str,'resolved':addr,'range_start':start})
    return out

def render(r):
    L=['# Static provenance of SoLibraryStart callback slot','',f"- pointer cell: `+0x{PTR_CELL:x}`",f"- target slot: `+0x{TARGET_SLOT:x}`",f"- dynsym count: **{r['dynsym_count']}**",'', '## Relocations near pointer cell / target slot','', '| relocation RVA | destination | type | addend | symbol | symbol value |','|---:|---:|---:|---:|---|---:|']
    for x in r['near_relocations']:L.append(f"| `0x{x['rela_va']:x}` | `0x{x['offset']:x}` | {x['type']} | `0x{x['addend'] & ((1<<64)-1):x}` | `{x['symbol'].get('name')}` | `0x{x['symbol'].get('value',0):x}` |")
    if not r['near_relocations']:L.append('| - | - | - | - | - | - |')
    L += ['', '## Relocations whose addend/symbol points to target slot','']
    for x in r['target_relocations']:L.append(f"- dest `+0x{x['offset']:x}`, type {x['type']}, addend `0x{x['addend'] & ((1<<64)-1):x}`, symbol `{x['symbol'].get('name')}` value `0x{x['symbol'].get('value',0):x}`")
    if not r['target_relocations']:L.append('- none')
    L += ['', '## Dynamic symbols around BSS slot','', '| index | name | value | size | type | bind | shndx |','|---:|---|---:|---:|---:|---:|---:|']
    for s in r['near_symbols']:L.append(f"| {s['index']} | `{s['name']}` | `0x{s['value']:x}` | {s['size']} | {s['type']} | {s['bind']} | {s['shndx']} |")
    if not r['near_symbols']:L.append('| - | - | - | - | - | - | - |')
    L += ['', '## Named exports/imports related to loading / callbacks','']
    for s in r['interesting_symbols']:L.append(f"- `{s['name']}` value=`0x{s['value']:x}` size={s['size']} bind={s['bind']} shndx={s['shndx']}")
    L += ['', '## Decrypted-code references near cells','', '| PC | instruction | resolved address |','|---:|---|---:|']
    for x in r['xrefs']:L.append(f"| `0x{x['pc']:x}` | `{x['mnemonic']} {x['op_str']}` | `0x{x['resolved']:x}` |")
    if not r['xrefs']:L.append('| - | - | - |')
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    img=base.Image(a.libcompatible);syms=symbols(img);rels=img.relas()
    nearrels=[x for x in rels if min(abs(x['offset']-PTR_CELL),abs(x['offset']-TARGET_SLOT))<0x100]
    targetrels=[x for x in rels if x['addend']==TARGET_SLOT or x['symbol'].get('value')==TARGET_SLOT or x['offset']==PTR_CELL or x['offset']==TARGET_SLOT]
    nearsyms=[s for s in syms if TARGET_SLOT-0x1000<=s['value']<=TARGET_SLOT+0x1000 or PTR_CELL-0x1000<=s['value']<=PTR_CELL+0x1000]
    words=('load','open','sym','library','callback','init','start','engine','stub','compatible','hook','so')
    interesting=[s for s in syms if s['name'] and any(w in s['name'].lower() for w in words)]
    rep={'dynsym_count':len(syms),'dynamic':img.dynamic,'near_relocations':nearrels,'target_relocations':targetrels,'near_symbols':nearsyms,'interesting_symbols':interesting,'xrefs':static_xrefs(img)}
    (a.out/'null-slot-static.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'null-slot-static.md').write_text(render(rep))
    print(json.dumps({'dynsym_count':len(syms),'near_relocations':nearrels,'target_relocations':targetrels,'near_symbols':nearsyms,'interesting_symbols':[x['name'] for x in interesting],'xrefs':rep['xrefs']},indent=2))
if __name__=='__main__':main()

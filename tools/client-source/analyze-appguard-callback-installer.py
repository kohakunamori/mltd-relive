#!/usr/bin/env python3
"""Focused disassembly around the callback-cluster fan-in at libcompatible+0xc2ab4."""
from __future__ import annotations
import argparse, json, re
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from elftools.elf.elffile import ELFFile

START=0xC2980
END=0xC2D80
TARGET=0xC2AB4

def va_bytes(path,va,n):
    with path.open('rb') as f:
        elf=ELFFile(f)
        for s in elf.iter_segments():
            if str(s['p_type'])=='PT_LOAD':
                sv=int(s['p_vaddr']);fs=int(s['p_filesz'])
                if sv<=va and va+n<=sv+fs:
                    off=int(s['p_offset'])+(va-sv);f.seek(off);return f.read(n)
    raise ValueError('VA not file-backed')

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--lib',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    raw=va_bytes(a.lib,START,END-START);md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    rows=[{'address':i.address,'mnemonic':i.mnemonic,'op_str':i.op_str,'bytes':bytes(i.bytes).hex()} for i in md.disasm(raw,START)]
    calls=[];indirect=[];stores=[]
    for r in rows:
        if r['mnemonic']=='bl':
            m=re.search(r'0x([0-9a-fA-F]+)',r['op_str']);calls.append({'pc':r['address'],'target':int(m.group(1),16) if m else None})
        if r['mnemonic'] in ('blr','br'):indirect.append(r)
        if r['mnemonic'].startswith('str') or r['mnemonic'].startswith('stp'):stores.append(r)
    rep={'range':[START,END],'fan_in':TARGET,'instructions':rows,'direct_calls':calls,'indirect_branches':indirect,'stores':stores}
    (a.out/'callback-installer.json').write_text(json.dumps(rep,indent=2)+'\n')
    L=['# AppGuard callback installer candidate','',f'- disassembly: `+0x{START:x}..+0x{END:x}`',f'- callback-cell fan-in begins near `+0x{TARGET:x}`','', '```asm']
    for r in rows:L.append(f"0x{r['address']:x}: {r['mnemonic']} {r['op_str']}")
    L += ['```','','## Direct calls','']
    for x in calls:L.append(f"- `+0x{x['pc']:x}` -> `{('0x%x'%x['target']) if x['target'] is not None else '?'}`")
    L += ['','## Indirect branches','']
    for x in indirect:L.append(f"- `+0x{x['address']:x}`: `{x['mnemonic']} {x['op_str']}`")
    (a.out/'callback-installer.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'calls':calls,'indirect':indirect,'stores':stores[-40:]},indent=2))
if __name__=='__main__':main()

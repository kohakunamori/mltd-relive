#!/usr/bin/env python3
"""Focused analysis of the callback installer at libcompatible+0xc2a30."""
from __future__ import annotations
import argparse, json, re, struct
from pathlib import Path
from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from elftools.elf.elffile import ELFFile

START=0xC2980; END=0xC2D80; INSTALLER=0xC2A30; FAN_IN=0xC2AB4

def loads(path):
    with path.open('rb') as f:
        elf=ELFFile(f); return [dict(vaddr=int(s['p_vaddr']),offset=int(s['p_offset']),filesz=int(s['p_filesz']),flags=int(s['p_flags'])) for s in elf.iter_segments() if str(s['p_type'])=='PT_LOAD']

def va_bytes(path,va,n):
    for s in loads(path):
        if s['vaddr']<=va and va+n<=s['vaddr']+s['filesz']:
            with path.open('rb') as f:f.seek(s['offset']+(va-s['vaddr']));return f.read(n)
    raise ValueError('VA not file-backed')

def signext(v,bits): return v-(1<<bits) if v&(1<<(bits-1)) else v

def scan_bl_callers(path,target):
    out=[]
    with path.open('rb') as f:data=f.read()
    for s in loads(path):
        if not (s['flags']&1):continue
        raw=data[s['offset']:s['offset']+s['filesz']]
        for o in range(0,len(raw)-3,4):
            w=struct.unpack_from('<I',raw,o)[0]
            if (w&0xFC000000)!=0x94000000:continue
            pc=s['vaddr']+o; imm=signext(w&0x03ffffff,26)<<2; dst=(pc+imm)&0xffffffffffffffff
            if dst==target:out.append(pc)
    return out

def disasm_context(path,pc,before=0x80,after=0xc0):
    st=max(0,pc-before);raw=va_bytes(path,st,before+after);md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    return [{'address':i.address,'mnemonic':i.mnemonic,'op_str':i.op_str,'bytes':bytes(i.bytes).hex()} for i in md.disasm(raw,st)]

def raw_u64_occurrences(path,value):
    b=path.read_bytes();pat=struct.pack('<Q',value);out=[];p=0
    while True:
        p=b.find(pat,p)
        if p<0:break
        for s in loads(path):
            if s['offset']<=p<s['offset']+s['filesz']:
                out.append({'file_offset':p,'va':s['vaddr']+(p-s['offset'])});break
        p+=1
    return out

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--lib',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    raw=va_bytes(a.lib,START,END-START);md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    rows=[{'address':i.address,'mnemonic':i.mnemonic,'op_str':i.op_str,'bytes':bytes(i.bytes).hex()} for i in md.disasm(raw,START)]
    calls=[];indirect=[];stores=[]
    for r in rows:
        if r['mnemonic']=='bl':
            m=re.search(r'0x([0-9a-fA-F]+)',r['op_str']);calls.append({'pc':r['address'],'target':int(m.group(1),16) if m else None})
        if r['mnemonic'] in ('blr','br'):indirect.append(r)
        if r['mnemonic'].startswith(('str','stp')):stores.append(r)
    callers=scan_bl_callers(a.lib,INSTALLER);contexts=[{'callsite':x,'instructions':disasm_context(a.lib,x)} for x in callers]
    ptrs=raw_u64_occurrences(a.lib,INSTALLER)
    rep={'range':[START,END],'installer':INSTALLER,'fan_in':FAN_IN,'instructions':rows,'direct_calls':calls,'indirect_branches':indirect,'stores':stores,
         'direct_installer_callers':callers,'caller_contexts':contexts,'raw_u64_installer_occurrences':ptrs}
    (a.out/'callback-installer.json').write_text(json.dumps(rep,indent=2)+'\n')
    L=['# AppGuard callback installer','',f'- installer: `+0x{INSTALLER:x}`',f'- callback-cell fan-in: `+0x{FAN_IN:x}`',
       f'- direct `BL` callers in executable PT_LOAD: **{len(callers)}**',f'- raw 64-bit occurrences of installer VA: **{len(ptrs)}**','',
       '## Installer body','', '```asm']
    for r in rows:L.append(f"0x{r['address']:x}: {r['mnemonic']} {r['op_str']}")
    L += ['```','','## Direct callers','']
    for c in contexts:
        L += [f"### callsite `+0x{c['callsite']:x}`",'', '```asm']
        for x in c['instructions']:
            mark='  ; <-- installer call' if x['address']==c['callsite'] else ''
            L.append(f"0x{x['address']:x}: {x['mnemonic']} {x['op_str']}{mark}")
        L += ['```','']
    if not contexts:L.append('- none')
    L += ['','## Data occurrences of installer VA','']
    for x in ptrs:L.append(f"- VA `+0x{x['va']:x}` / file `0x{x['file_offset']:x}`")
    if not ptrs:L.append('- none')
    (a.out/'callback-installer.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'installer':hex(INSTALLER),'callers':[hex(x) for x in callers],'raw_u64':ptrs},indent=2))
if __name__=='__main__':main()

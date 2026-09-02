#!/usr/bin/env python3
"""Recover AppGuard JNINativeMethod registrations from ARM64 libcompatible.so.

The sample has a deliberately malformed/minimal section table, so this parser
uses ELF64 program headers + PT_DYNAMIC only.  It resolves RELA-backed
{name, signature, fnPtr} triples, including ABS64 function relocations, then
emits a compact disassembly/call map for the native method backing
AppGuardProxyApplication.IiIiiIiIiI(Context).
"""
from __future__ import annotations

import argparse
import json
import re
import struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM

PT_LOAD=1; PT_DYNAMIC=2
DT_NULL=0; DT_HASH=4; DT_STRTAB=5; DT_SYMTAB=6; DT_RELA=7; DT_RELASZ=8
DT_RELAENT=9; DT_STRSZ=10; DT_SYMENT=11
R_AARCH64_ABS64=257; R_AARCH64_RELATIVE=1027


def u16(b,o): return struct.unpack_from('<H',b,o)[0]
def u32(b,o): return struct.unpack_from('<I',b,o)[0]
def u64(b,o): return struct.unpack_from('<Q',b,o)[0]
def s64(b,o): return struct.unpack_from('<q',b,o)[0]


def parse_elf(data: bytes):
    if data[:4]!=b'\x7fELF' or data[4]!=2 or data[5]!=1:
        raise ValueError('expected ELF64 little-endian')
    phoff=u64(data,0x20); phentsz=u16(data,0x36); phnum=u16(data,0x38)
    ph=[]
    for i in range(phnum):
        o=phoff+i*phentsz
        p_type,p_flags=struct.unpack_from('<II',data,o)
        p_offset,p_vaddr,p_paddr,p_filesz,p_memsz,p_align=struct.unpack_from('<QQQQQQ',data,o+8)
        ph.append(dict(type=p_type,flags=p_flags,offset=p_offset,vaddr=p_vaddr,
                       filesz=p_filesz,memsz=p_memsz,align=p_align))
    loads=[p for p in ph if p['type']==PT_LOAD]
    def va2off(va:int):
        for p in loads:
            if p['vaddr']<=va<p['vaddr']+p['filesz']:
                return p['offset']+(va-p['vaddr'])
        return None
    def off2va(off:int):
        for p in loads:
            if p['offset']<=off<p['offset']+p['filesz']:
                return p['vaddr']+(off-p['offset'])
        return None
    dynseg=next((p for p in ph if p['type']==PT_DYNAMIC),None)
    if not dynseg: raise ValueError('no PT_DYNAMIC')
    dyn={}
    for o in range(dynseg['offset'],dynseg['offset']+dynseg['filesz'],16):
        tag=s64(data,o); val=u64(data,o+8)
        if tag==DT_NULL: break
        dyn[tag]=val
    rela_off=va2off(dyn[DT_RELA]); rela_sz=dyn[DT_RELASZ]; rela_ent=dyn.get(DT_RELAENT,24)
    relas=[]
    for o in range(rela_off,rela_off+rela_sz,rela_ent):
        r_offset=u64(data,o); r_info=u64(data,o+8); r_addend=s64(data,o+16)
        relas.append(dict(offset=r_offset,sym=r_info>>32,type=r_info&0xffffffff,
                          addend=r_addend,rela_file_offset=o))
    hash_off=va2off(dyn[DT_HASH]); nchain=u32(data,hash_off+4)
    strtab_off=va2off(dyn[DT_STRTAB]); strsz=dyn[DT_STRSZ]
    symtab_off=va2off(dyn[DT_SYMTAB]); syment=dyn.get(DT_SYMENT,24)
    strtab=data[strtab_off:strtab_off+strsz]; symbols=[]
    for i in range(nchain):
        o=symtab_off+i*syment; st_name=u32(data,o); st_info=data[o+4]; st_other=data[o+5]
        st_shndx=u16(data,o+6); st_value=u64(data,o+8); st_size=u64(data,o+16)
        end=strtab.find(b'\0',st_name)
        name=strtab[st_name:end if end>=0 else None].decode('utf-8','replace') if st_name<len(strtab) else ''
        symbols.append(dict(index=i,name=name,value=st_value,size=st_size,info=st_info,other=st_other,shndx=st_shndx))
    return dict(program_headers=ph,dynamic=dyn,relas=relas,symbols=symbols,va2off=va2off,off2va=off2va)


def find_cstrings(data:bytes,needle:bytes):
    out=[]; start=0
    while True:
        p=data.find(needle,start)
        if p<0: break
        q=p+len(needle)
        if (p==0 or data[p-1]==0) and q<len(data) and data[q]==0: out.append(p)
        start=p+1
    return out


def disassemble(data:bytes, va2off, va:int, size:int):
    off=va2off(va)
    if off is None: return []
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    rows=[]
    for ins in md.disasm(data[off:off+size],va):
        rows.append(dict(address=ins.address,mnemonic=ins.mnemonic,op_str=ins.op_str,bytes=bytes(ins.bytes).hex()))
    return rows


def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--lib',type=Path,required=True); ap.add_argument('--out',type=Path,required=True)
    a=ap.parse_args(); data=a.lib.read_bytes(); elf=parse_elf(data); va2off=elf['va2off']; off2va=elf['off2va']
    syms=elf['symbols']; by_target={r['offset']:r for r in elf['relas']}; by_addend={}
    for r in elf['relas']: by_addend.setdefault(r['addend'],[]).append(r)

    method=b'IiIiiIiIiI'; sig=b'(Landroid/content/Context;)V'
    name_vas=[off2va(x) for x in find_cstrings(data,method)]
    sig_vas=[off2va(x) for x in find_cstrings(data,sig)]
    name_vas=[x for x in name_vas if x is not None]; sig_vas=[x for x in sig_vas if x is not None]

    candidates=[]
    for nv in name_vas:
        for nr in by_addend.get(nv,[]):
            base=nr['offset']; sr=by_target.get(base+8); fr=by_target.get(base+16)
            if not sr or sr['addend'] not in sig_vas or not fr: continue
            fn=None; fsym=None
            if fr['type']==R_AARCH64_RELATIVE:
                fn=fr['addend']
            elif fr['sym'] and fr['sym']<len(syms):
                fsym=syms[fr['sym']]; fn=fsym['value']+fr['addend']
            size=(fsym or {}).get('size') or 0x300
            rows=disassemble(data,va2off,fn,min(max(size,0x100),0x1000)) if isinstance(fn,int) and fn else []
            calls=[]
            for ins in rows:
                if ins['mnemonic']=='bl':
                    m=re.fullmatch(r'#?0x([0-9a-fA-F]+)',ins['op_str'].strip())
                    if m:
                        target=int(m.group(1),16)
                        exact=next((s for s in syms if s.get('value')==target and s.get('name')),None)
                        calls.append(dict(callsite=ins['address'],target=target,symbol=exact))
            candidates.append(dict(table_va=base,name_va=nv,signature_va=sr['addend'],function_va=fn,
                                   function_symbol=fsym,name_relocation=nr,signature_relocation=sr,
                                   function_relocation=fr,disassembly=rows,direct_calls=calls))

    exports=[s for s in syms if s.get('name')=='IiIiiIiIiI']
    callback_slot=0x1eb858
    callback_refs=by_addend.get(callback_slot,[])
    report=dict(library=str(a.lib),method=method.decode(),signature=sig.decode(),method_string_vas=name_vas,
                signature_string_vas=sig_vas,dynamic_exports_named_IiIiiIiIiI=exports,
                jni_native_method_candidates=candidates,callback_slot=callback_slot,
                relocations_with_addend_callback_slot=callback_refs,rela_count=len(elf['relas']))
    a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'jni-registration.json').write_text(json.dumps(report,indent=2)+'\n')

    L=['# AppGuard JNI registration recovery','',f'- method: `{method.decode()}`',f'- signature: `{sig.decode()}`',
       f'- JNINativeMethod candidates: **{len(candidates)}**','']
    for i,c in enumerate(candidates,1):
        fs=c.get('function_symbol') or {}; L += [f'## Candidate {i}','',f'- table VA: `0x{c["table_va"]:x}`',
          f'- native function VA: `0x{c["function_va"]:x}`',f'- relocation symbol: `{fs.get("name","")}` (index {fs.get("index")}, size {fs.get("size")})',
          f'- direct BL calls: **{len(c["direct_calls"])}**','', '```asm']
        for ins in c['disassembly']:
            L.append(f'0x{ins["address"]:x}: {ins["mnemonic"]} {ins["op_str"]}')
        L += ['```','']
        if c['direct_calls']:
            L += ['### Direct calls','']
            for x in c['direct_calls']:
                sn=(x.get('symbol') or {}).get('name') or ''
                L.append(f'- `0x{x["callsite"]:x}` -> `0x{x["target"]:x}` {sn}')
            L.append('')
    L += ['## Same-name dynamic exports','']+[f'- `0x{s["value"]:x}` size={s["size"]} index={s["index"]}' for s in exports]
    L += ['', '## Callback-slot relocation evidence','',f'- slot: `0x{callback_slot:x}`',f'- pointers to slot via RELA addend: **{len(callback_refs)}**','']
    for r in callback_refs: L.append(f'- relocation target `0x{r["offset"]:x}` -> addend `0x{r["addend"]:x}` type={r["type"]}')
    (a.out/'jni-registration.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({
        'candidates':[{'table_va':c['table_va'],'function_va':c['function_va'],'function_symbol':c['function_symbol'],'direct_calls':c['direct_calls']} for c in candidates],
        'callback_refs':callback_refs
    },indent=2))

if __name__=='__main__': main()

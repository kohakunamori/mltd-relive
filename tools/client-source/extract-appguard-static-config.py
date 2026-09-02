#!/usr/bin/env python3
"""Extract the static source copied into AppGuard's 0x1070 runtime config.

Exact MLTD 2.1.000 DT_INIT proves:
  * global 0x1e56a0 is loaded into x22,
  * calloc(1, 0x1070) creates the runtime config,
  * 0x1070 bytes are copied from (x22 & ~1) into that buffer,
  * config+0x70 contains the trampoline descriptor count,
  * descriptors start at config+0x74 and are 12 bytes each,
  * config+0x70 is also used as the template-code reference base.

This tool resolves the global through PT_DYNAMIC relocations, extracts the
file-backed 0x1070 source block when possible, parses descriptors, reconstructs
all generated trampoline blobs in descriptor order, and disassembles them as
AArch64.  It also resolves global 0x1e59e0, which feeds asmFunction +0x98/+0xa0.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile

GLOBALS = {
    'runtime_config_source': 0x1e56a0,
    'asmfunction_tail_code_pool': 0x1e59e0,
}
RELOC_NAMES = {
    257:'R_AARCH64_ABS64',258:'R_AARCH64_ABS32',259:'R_AARCH64_ABS16',
    1024:'R_AARCH64_COPY',1025:'R_AARCH64_GLOB_DAT',1026:'R_AARCH64_JUMP_SLOT',
    1027:'R_AARCH64_RELATIVE',1032:'R_AARCH64_IRELATIVE',
}


def sha256(p: Path) -> str:
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1<<20),b''):h.update(b)
    return h.hexdigest()


class Image:
    def __init__(self,segs):self.segs=segs
    def read(self,va,n):
        for s in self.segs:
            if s['vaddr']<=va and va+n<=s['vaddr']+s['filesz']:
                o=va-s['vaddr'];return s['data'][o:o+n]
        return b''
    def fileoff(self,va):
        for s in self.segs:
            if s['vaddr']<=va<s['vaddr']+s['filesz']:
                return s['offset']+va-s['vaddr']
        return None
    def filebacked(self,va,n=1):return len(self.read(va,n))==n
    def u64(self,va):
        b=self.read(va,8);return struct.unpack('<Q',b)[0] if len(b)==8 else None


def load(path: Path):
    with path.open('rb') as f:
        e=ELFFile(f);segs=[];dyn={}
        for s in e.iter_segments():
            if str(s['p_type'])=='PT_LOAD':
                segs.append({'vaddr':int(s['p_vaddr']),'offset':int(s['p_offset']),'filesz':int(s['p_filesz']),'memsz':int(s['p_memsz']),'flags':int(s['p_flags']),'data':s.data()})
            if isinstance(s,DynamicSegment) or str(s['p_type'])=='PT_DYNAMIC':
                try:
                    for t in s.iter_tags():
                        k=str(t.entry.d_tag);v=getattr(t.entry,'d_val',None)
                        if v is None:v=getattr(t.entry,'d_ptr',None)
                        if v is not None:dyn[k]=int(v)
                except Exception:pass
    return Image(segs),dyn


def cstr(img,va,limit=256):
    b=img.read(va,limit)
    if not b:return None
    try:return b.split(b'\0',1)[0].decode('utf-8')
    except:return None


def sym(img,dyn,idx):
    st=dyn.get('DT_SYMTAB');ss=dyn.get('DT_SYMENT',24);strings=dyn.get('DT_STRTAB')
    if st is None or strings is None:return {'index':idx,'name':None,'value':None}
    b=img.read(st+idx*ss,24)
    if len(b)<24:return {'index':idx,'name':None,'value':None}
    no=struct.unpack_from('<I',b,0)[0];value=struct.unpack_from('<Q',b,8)[0]
    return {'index':idx,'name':cstr(img,strings+no),'value':value}


def relas(img,dyn,base_tag,size_tag,kind):
    base=dyn.get(base_tag);size=dyn.get(size_tag);ent=dyn.get('DT_RELAENT',24)
    if base is None or size is None:return []
    out=[]
    for off in range(0,size,ent):
        b=img.read(base+off,24)
        if len(b)<24:break
        ro,ri,ra=struct.unpack('<QQq',b);idx=ri>>32;rt=ri&0xffffffff;s=sym(img,dyn,idx)
        out.append({'table':kind,'rela_va':base+off,'offset':ro,'type':rt,'type_name':RELOC_NAMES.get(rt,f'R_AARCH64_{rt}'),'addend':ra,'symbol':s})
    return out


def resolve(r):
    rt=r['type'];sv=r['symbol'].get('value');a=r['addend']
    if rt in (1027,1032):return a
    if rt in (257,1025,1026) and sv is not None:return sv+a
    return None


def inspect_global(img, rel_by_off, name, va):
    rows=rel_by_off.get(va,[]);raw=img.u64(va);resolved=[]
    for r in rows:
        p=resolve(r);resolved.append({'relocation':r,'pointer':p,'file_offset':img.fileoff(p) if p is not None else None,'file_backed':img.filebacked(p,1) if p is not None else False})
    if not rows and raw:
        resolved.append({'relocation':None,'pointer':raw,'file_offset':img.fileoff(raw),'file_backed':img.filebacked(raw,1)})
    return {'name':name,'slot':va,'slot_file_offset':img.fileoff(va),'raw_u64':raw,'relocations':rows,'resolved':resolved}


def disasm_blob(md,blob,base):
    rows=[]
    for i in md.disasm(blob,base):
        rows.append({'address':i.address,'mnemonic':i.mnemonic,'op_str':i.op_str,'bytes':i.bytes.hex()})
    return rows


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    img,dyn=load(a.libcompatible)
    rs=relas(img,dyn,'DT_RELA','DT_RELASZ','RELA')+relas(img,dyn,'DT_JMPREL','DT_PLTRELSZ','JMPREL')
    by={}
    for r in rs:by.setdefault(r['offset'],[]).append(r)
    globals_report=[inspect_global(img,by,n,v) for n,v in GLOBALS.items()]

    config_report={'available':False}
    g=next(x for x in globals_report if x['name']=='runtime_config_source')
    candidates=[x['pointer'] for x in g['resolved'] if x.get('pointer') is not None]
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
    for ptr in candidates:
        base=ptr & ~1
        raw=img.read(base,0x1070)
        if len(raw)!=0x1070:continue
        count=struct.unpack_from('<I',raw,0x70)[0]
        # Guard against false resolution. Exact builder should have a small descriptor count.
        descriptors=[];running=0;valid=count<=128 and 0x74+count*12<=len(raw)
        if valid:
            for i in range(count):
                off=0x74+i*12
                ident,src,size=struct.unpack_from('<III',raw,off)
                src_rel_base=0x70+src
                blob=raw[src_rel_base:src_rel_base+size] if src_rel_base+size<=len(raw) else b''
                desc={
                    'index':i,'id':ident,'src_offset':src,'size':size,
                    'running_offset':running,'aligned_size':(size+3)&~3,
                    'source_offset_in_config':src_rel_base,
                    'blob_hex':blob.hex(),
                    'blob_complete':len(blob)==size,
                    'disassembly':disasm_blob(md,blob,running) if blob else [],
                }
                descriptors.append(desc);running+=(size+3)&~3
        config_report={
            'available':True,'source_pointer_raw':ptr,'source_base':base,'file_offset':img.fileoff(base),
            'sha256':hashlib.sha256(raw).hexdigest(),'size':len(raw),'descriptor_count':count,
            'descriptor_table_end':0x74+count*12 if valid else None,'total_generated_bytes':running if valid else None,
            'descriptors':descriptors if valid else [],'hex_head':raw[:0x100].hex(),
        }
        break

    tail_pool={}
    tg=next(x for x in globals_report if x['name']=='asmfunction_tail_code_pool')
    for rr in tg['resolved']:
        p=rr.get('pointer')
        if p is not None:
            tail_pool={'pointer':p,'file_offset':img.fileoff(p),'file_backed':img.filebacked(p,1),'nearby_hex':img.read(p,0x100).hex() if img.filebacked(p,1) else ''}
            break

    report={'sample_sha256':sha256(a.libcompatible),'dynamic_relocations':len(rs),'globals':globals_report,'config':config_report,'tail_code_pool':tail_pool}
    a.out.mkdir(parents=True,exist_ok=True);(a.out/'static-config.json').write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n')
    L=['# AppGuard static trampoline-config extraction','',f"- sample: `{report['sample_sha256']}`",f"- relocations parsed: **{len(rs)}**",'','## Key globals','', '| Name | Slot | Relocation | Resolved pointer | File offset |','|---|---:|---|---:|---:|']
    for gr in globals_report:
        if gr['resolved']:
            for rr in gr['resolved']:
                r=rr.get('relocation');rt=(f"{r['type_name']}:{r['symbol'].get('name') or '-'} add={r['addend']:#x}" if r else '-')
                p=rr.get('pointer');fo=rr.get('file_offset')
                L.append(f"| `{gr['name']}` | `0x{gr['slot']:x}` | {rt} | `{hex(p) if p is not None else '-'}` | `{hex(fo) if fo is not None else '-'}` |")
        else:L.append(f"| `{gr['name']}` | `0x{gr['slot']:x}` | - | - | - |")
    L += ['','## Extracted 0x1070 config','']
    c=config_report
    if not c.get('available'):
        L.append('The relocation did not resolve to a file-backed 0x1070 source block.')
    else:
        L += [f"- source VA: `0x{c['source_base']:x}`",f"- file offset: `{hex(c['file_offset']) if c['file_offset'] is not None else '-'}`",f"- SHA-256: `{c['sha256']}`",f"- descriptor count @ +0x70: **{c['descriptor_count']}**",f"- generated RWX bytes: **{c['total_generated_bytes']}**",'', '| # | id | src_off | size | dest_off | blob | AArch64 |','|---:|---:|---:|---:|---:|---|---|']
        for d in c['descriptors']:
            asm='; '.join(f"{x['mnemonic']} {x['op_str']}".strip() for x in d['disassembly'])
            blob=d['blob_hex']
            if len(blob)>64:blob=blob[:64]+'…'
            L.append(f"| {d['index']} | `{d['id']}` | `0x{d['src_offset']:x}` | `{d['size']}` | `0x{d['running_offset']:x}` | `{blob}` | `{asm}` |")
    L += ['','## Tail (+0x98/+0xa0) code-pool global','']
    if tail_pool:L += [f"- pointer: `0x{tail_pool['pointer']:x}`",f"- file offset: `{hex(tail_pool['file_offset']) if tail_pool['file_offset'] is not None else '-'}`",f"- file-backed: **{tail_pool['file_backed']}**"]
    else:L.append('No static pointer resolved.')
    (a.out/'static-config.md').write_text('\n'.join(L)+'\n')
    # Persist raw config only when it was exact/file-backed and under the small expected size.
    if c.get('available'):
        (a.out/'static-config-0x1070.bin').write_bytes(img.read(c['source_base'],0x1070))
    print(json.dumps({'globals':[(g['name'],[(x.get('pointer')) for x in g['resolved']]) for g in globals_report],'config_available':c.get('available'),'descriptor_count':c.get('descriptor_count'),'generated_bytes':c.get('total_generated_bytes')},indent=2))

if __name__=='__main__':main()

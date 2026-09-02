#!/usr/bin/env python3
"""Recover the AppGuard loader slice around SoLibraryStart.

This consumes bootstrap-cfg.json and the exact libcompatible.so. It reconstructs
AArch64 PLT stubs from dynamic JMPREL/GOT data even though AppGuard has removed
normal section names, labels bootstrap calls to libc/zlib/libdl, and performs
block-local ADR/ADRP+ADD string-reference recovery for the SoLibraryStart code
family. The output is intentionally concise enough to review in Git.
"""
from __future__ import annotations

import argparse
import bisect
import hashlib
import json
import re
import struct
from collections import defaultdict
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_MEM, ARM64_OP_REG
from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

KEY_IMPORTS = re.compile(
    r'^(?:memcpy|memmove|memset|memcmp|malloc|calloc|realloc|free|inflate|inflateInit_|inflateEnd|'
    r'dlopen|dlsym|dlclose|mprotect|mmap|munmap|open|openat|read|pread|lseek|close|fopen|fread|fseek|'
    r'pthread_create|pthread_join|ptrace|prctl|__android_log_print)$'
)
KEY_STRINGS = re.compile(
    r'(?:libengine(?:-hlp)?\.so|libstub\.so|libcompatible\.so|libil2cpp\.so|global-metadata\.dat|'
    r'/proc/self/maps|dlopen|dlsym|mprotect|mmap|decrypt|encrypt|inflate|lz4)', re.I
)


def sha256(p: Path) -> str:
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1<<20),b''):
            h.update(b)
    return h.hexdigest()


class Image:
    def __init__(self,segs): self.segs=segs
    def va_to_file(self,va):
        for s in self.segs:
            if s['vaddr'] <= va < s['vaddr']+s['filesz']:
                return s['offset']+(va-s['vaddr'])
        return None
    def read(self,va,n):
        for s in self.segs:
            if s['vaddr'] <= va and va+n <= s['vaddr']+s['filesz']:
                o=va-s['vaddr']; return s['data'][o:o+n]
        return b''
    def exec_ranges(self):
        return [(s['vaddr'],s['vaddr']+s['filesz']) for s in self.segs if s['flags']&1]


def load_elf(path:Path):
    with path.open('rb') as f:
        elf=ELFFile(f)
        segs=[]; dyn={}
        for seg in elf.iter_segments():
            if str(seg['p_type'])=='PT_LOAD':
                segs.append({'vaddr':int(seg['p_vaddr']),'offset':int(seg['p_offset']),'filesz':int(seg['p_filesz']),'memsz':int(seg['p_memsz']),'flags':int(seg['p_flags']),'data':seg.data()})
            if isinstance(seg,DynamicSegment) or str(seg['p_type'])=='PT_DYNAMIC':
                try:
                    for tag in seg.iter_tags():
                        key=str(tag.entry.d_tag)
                        val=getattr(tag.entry,'d_val',None)
                        if val is None: val=getattr(tag.entry,'d_ptr',None)
                        dyn[key]=int(val) if val is not None else None
                except Exception: pass
        symbols=[]
        for sec in elf.iter_sections():
            if isinstance(sec,SymbolTableSection):
                for idx,s in enumerate(sec.iter_symbols()):
                    if s.name:
                        symbols.append({'index':idx,'name':s.name,'address':int(s['st_value']),'size':int(s['st_size']),'undef':s['st_shndx']=='SHN_UNDEF'})
    return Image(segs),dyn,symbols


def cstring(image:Image,va:int,limit=512):
    data=image.read(va,limit)
    if not data:return None
    data=data.split(b'\0',1)[0]
    try:return data.decode('utf-8')
    except Exception:
        try:return data.decode('ascii')
        except Exception:return None


def parse_jmprel(image:Image,dyn:dict):
    jmprel=dyn.get('DT_JMPREL'); size=dyn.get('DT_PLTRELSZ'); symtab=dyn.get('DT_SYMTAB'); strtab=dyn.get('DT_STRTAB'); syment=dyn.get('DT_SYMENT',24) or 24
    if None in (jmprel,size,symtab,strtab): return {}
    out={}
    for off in range(0,size,24):
        raw=image.read(jmprel+off,24)
        if len(raw)!=24:break
        r_offset,r_info,r_addend=struct.unpack('<QQq',raw)
        symidx=r_info>>32
        symraw=image.read(symtab+symidx*syment,24)
        if len(symraw)<24:continue
        st_name=struct.unpack_from('<I',symraw,0)[0]
        name=cstring(image,strtab+st_name)
        if name: out[r_offset]={'symbol':name,'sym_index':symidx,'rela_va':jmprel+off}
    return out


def scan_plt(image:Image,relocs:dict):
    """Recognize canonical AArch64 adrp/ldr/add/br PLT entries and map GOT slot to JMPREL."""
    md=Cs(CS_ARCH_ARM64,CS_MODE_ARM); md.detail=True
    stubs={}
    for lo,hi in image.exec_ranges():
        # scan 4-byte aligned windows; PLT entries are normally 16 bytes.
        for va in range((lo+3)&~3,hi-16,4):
            raw=image.read(va,16)
            if len(raw)!=16:continue
            ins=list(md.disasm(raw,va,count=4))
            if len(ins)!=4:continue
            a,b,c,d=ins
            if a.mnemonic!='adrp' or b.mnemonic!='ldr' or c.mnemonic!='add' or d.mnemonic!='br':continue
            if len(a.operands)<2 or a.operands[1].type!=ARM64_OP_IMM:continue
            if len(b.operands)<2 or b.operands[1].type!=ARM64_OP_MEM:continue
            base=int(a.operands[1].imm)
            got=base+int(b.operands[1].mem.disp)
            rr=relocs.get(got)
            if rr:
                stubs[va]={**rr,'got':got,'instructions':[f'{x.mnemonic} {x.op_str}' for x in ins]}
    return stubs


def symbol_helpers(symbols):
    defs=[s for s in symbols if not s['undef'] and s['address']]
    defs.sort(key=lambda s:(s['address'],s['name']))
    addrs=sorted(set(s['address'] for s in defs))
    by=defaultdict(list)
    for s in defs:by[s['address']].append(s)
    def exact(a):return sorted((x['name'] for x in by.get(a,[])))
    def nearest(a):
        i=bisect.bisect_right(addrs,a)-1
        if i<0:return None
        start=addrs[i]; rows=by[start]; row=max(rows,key=lambda x:x['size'])
        return {'name':row['name'],'start':start,'offset':a-start,'size':row['size']}
    return exact,nearest


def printable_strings(image:Image):
    rows=[]
    for s in image.segs:
        data=s['data']; start=None; buf=bytearray()
        for i,b in enumerate(data):
            if 0x20<=b<=0x7e:
                if start is None:start=i
                buf.append(b)
            else:
                if start is not None and len(buf)>=5:
                    text=buf.decode('ascii','replace')
                    rows.append({'address':s['vaddr']+start,'file_offset':s['offset']+start,'text':text})
                start=None;buf.clear()
        if start is not None and len(buf)>=5:
            rows.append({'address':s['vaddr']+start,'file_offset':s['offset']+start,'text':buf.decode('ascii','replace')})
    return rows


def parse_int(x):
    try:return int(x,0)
    except:return None


def split_ops(opstr):
    # Enough for ADRP/ADR/MOV/ADD emitted by Capstone.
    return [x.strip() for x in opstr.split(',')]


def block_string_xrefs(blocks,strings):
    by_addr={x['address']:x for x in strings}
    key_targets={x['address']:x for x in strings if KEY_STRINGS.search(x['text'])}
    refs=[]
    for block in blocks:
        regs={}
        for ins in block.get('instructions',[]):
            m=ins['mnemonic']; ops=split_ops(ins['op_str']); a=ins['address']
            if m in ('adr','adrp') and len(ops)>=2 and ops[0].startswith('x'):
                val=parse_int(ops[1].lstrip('#'))
                if val is not None: regs[ops[0]]=val
            elif m in ('mov','movz') and len(ops)>=2 and ops[0].startswith(('x','w')):
                dst='x'+ops[0][1:] if ops[0].startswith('w') else ops[0]
                src=ops[1]
                if src.startswith('#'):
                    val=parse_int(src[1:]);
                    if val is not None:regs[dst]=val
                else:
                    src='x'+src[1:] if src.startswith('w') else src
                    if src in regs:regs[dst]=regs[src]
                    else:regs.pop(dst,None)
            elif m=='add' and len(ops)>=3:
                dst='x'+ops[0][1:] if ops[0].startswith('w') else ops[0]
                src='x'+ops[1][1:] if ops[1].startswith('w') else ops[1]
                imm=parse_int(ops[2].lstrip('#')) if ops[2].startswith('#') else None
                if src in regs and imm is not None:
                    regs[dst]=regs[src]+imm
                    target=key_targets.get(regs[dst])
                    if target:
                        refs.append({'instruction':a,'owner':block.get('owner'),'root':block.get('root_provenance'),'target':target})
                else:regs.pop(dst,None)
            # Record direct ADR to key string too.
            for r,v in list(regs.items()):
                target=key_targets.get(v)
                if target and not any(x['instruction']==a and x['target']['address']==v for x in refs):
                    refs.append({'instruction':a,'owner':block.get('owner'),'root':block.get('root_provenance'),'target':target})
    # dedupe
    d={(x['instruction'],x['target']['address']):x for x in refs}
    return sorted(d.values(),key=lambda x:(x['instruction'],x['target']['address']))


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--bootstrap-json',type=Path,required=True);ap.add_argument('--out',type=Path,required=True)
    args=ap.parse_args()
    image,dyn,symbols=load_elf(args.libcompatible)
    exact,nearest=symbol_helpers(symbols)
    relocs=parse_jmprel(image,dyn); plt=scan_plt(image,relocs)
    boot=json.loads(args.bootstrap_json.read_text(encoding='utf-8'))
    strings=printable_strings(image)
    xrefs=block_string_xrefs(boot.get('blocks',[]),strings)

    solib=[s for s in symbols if s['name']=='SoLibraryStart' and not s['undef']]
    anchor=solib[0] if solib else None

    calls=[]
    for c in boot.get('calls',[]):
        target=c.get('target')
        p=plt.get(target) if target is not None else None
        owner=c.get('owner') or {}
        near=c.get('target_nearest') or {}
        relevant=(owner.get('name')=='SoLibraryStart' or near.get('name')=='SoLibraryStart' or p is not None and KEY_IMPORTS.search(p['symbol']))
        if relevant:
            calls.append({**c,'plt_import':p['symbol'] if p else None})

    key_import_calls=[c for c in calls if c.get('plt_import') and KEY_IMPORTS.search(c['plt_import'])]
    key_xrefs=[x for x in xrefs if KEY_STRINGS.search(x['target']['text'])]
    occurrences=[x for x in strings if KEY_STRINGS.search(x['text'])]

    report={
        'sample_sha256':sha256(args.libcompatible),
        'SoLibraryStart':anchor,
        'dynamic_tags':{k:dyn.get(k) for k in ('DT_INIT','DT_JMPREL','DT_PLTRELSZ','DT_SYMTAB','DT_STRTAB','DT_SYMENT','DT_PLTGOT')},
        'jmprel_count':len(relocs),'recovered_plt_stub_count':len(plt),
        'key_string_occurrences':occurrences,
        'key_string_xrefs_from_bootstrap':key_xrefs,
        'relevant_calls':calls,
        'key_import_calls':key_import_calls,
        'plt_stubs':{hex(k):v for k,v in sorted(plt.items())},
    }
    args.out.mkdir(parents=True,exist_ok=True)
    (args.out/'loader-slice.json').write_text(json.dumps(report,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')

    L=['# AppGuard `SoLibraryStart` loader slice','']
    if anchor:L += [f"- `SoLibraryStart`: `0x{anchor['address']:x}` (symbol size `{anchor['size']}` bytes)"]
    L += [f"- JMPREL entries: **{len(relocs)}**",f"- canonical AArch64 PLT stubs recovered: **{len(plt)}**",f"- key import calls reached by bootstrap: **{len(key_import_calls)}**",f"- key loader-string xrefs reached by bootstrap: **{len(key_xrefs)}**",'']
    L += ['## Key strings present in `libcompatible.so`','', '| VA | File offset | String |','|---:|---:|---|']
    for x in occurrences[:120]:L.append(f"| `0x{x['address']:x}` | `0x{x['file_offset']:x}` | `{x['text'].replace('|','\\|')}` |")
    L += ['','## Bootstrap references to key strings','']
    if key_xrefs:
        L += ['| Instruction | Owner | Target | String |','|---:|---|---:|---|']
        for x in key_xrefs[:200]:
            owner=(x.get('owner') or {}).get('name','-')
            t=x['target'];L.append(f"| `0x{x['instruction']:x}` | `{owner}` | `0x{t['address']:x}` | `{t['text'].replace('|','\\|')}` |")
    else:L.append('No block-local ADR/ADRP+ADD references resolved; pointer tables or runtime string decryption may be used.')
    L += ['','## Recovered key imported calls','']
    if key_import_calls:
        L += ['| Callsite | Owner | Import | Root |','|---:|---|---|---|']
        for c in key_import_calls[:240]:
            owner=(c.get('owner') or {}).get('name','-');L.append(f"| `0x{c['address']:x}` | `{owner}` | `{c['plt_import']}` | `{c.get('root_provenance','-')}` |")
    else:L.append('No key imported calls were resolved from the current bootstrap CFG.')
    L += ['','## Calls associated with `SoLibraryStart` symbol family','', '| Callsite | Owner | Target | Nearest target | PLT import |','|---:|---|---:|---|---|']
    for c in calls[:300]:
        owner=(c.get('owner') or {}).get('name','-'); near=c.get('target_nearest') or {}; nl=(near.get('name','-')+ (f"+0x{near.get('offset',0):x}" if near else ''))
        L.append(f"| `0x{c['address']:x}` | `{owner}` | `{hex(c['target']) if c.get('target') is not None else '-'}` | `{nl}` | `{c.get('plt_import') or '-'}` |")
    (args.out/'loader-slice.md').write_text('\n'.join(L)+'\n',encoding='utf-8')
    print(json.dumps({'SoLibraryStart':anchor,'jmprel':len(relocs),'plt':len(plt),'key_import_calls':len(key_import_calls),'key_string_xrefs':len(key_xrefs),'key_strings':len(occurrences)},indent=2))

if __name__=='__main__':main()

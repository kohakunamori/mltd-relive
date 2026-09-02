#!/usr/bin/env python3
"""Recover AppGuard JNINativeMethod registrations from the exact ARM64 libcompatible.so.

This parser intentionally relies only on ELF64 program headers + PT_DYNAMIC so it
continues to work on AppGuard's deliberately malformed/minimal section table.
It resolves RELA addends for {name, signature, fnPtr} triples and reports the
native function backing AppGuardProxyApplication.IiIiiIiIiI(Context).
"""
from __future__ import annotations

import argparse
import json
import struct
from pathlib import Path

PT_LOAD = 1
PT_DYNAMIC = 2
DT_NULL = 0
DT_HASH = 4
DT_STRTAB = 5
DT_SYMTAB = 6
DT_RELA = 7
DT_RELASZ = 8
DT_RELAENT = 9
DT_STRSZ = 10
DT_SYMENT = 11
R_AARCH64_RELATIVE = 1027


def u16(b, o): return struct.unpack_from('<H', b, o)[0]
def u32(b, o): return struct.unpack_from('<I', b, o)[0]
def u64(b, o): return struct.unpack_from('<Q', b, o)[0]
def s64(b, o): return struct.unpack_from('<q', b, o)[0]


def parse_elf(data: bytes):
    if data[:4] != b'\x7fELF' or data[4] != 2 or data[5] != 1:
        raise ValueError('expected ELF64 little-endian')
    phoff = u64(data, 0x20)
    phentsz = u16(data, 0x36)
    phnum = u16(data, 0x38)
    ph = []
    for i in range(phnum):
        o = phoff + i * phentsz
        p_type, p_flags = struct.unpack_from('<II', data, o)
        p_offset, p_vaddr, p_paddr, p_filesz, p_memsz, p_align = struct.unpack_from('<QQQQQQ', data, o + 8)
        ph.append(dict(type=p_type, flags=p_flags, offset=p_offset, vaddr=p_vaddr,
                       filesz=p_filesz, memsz=p_memsz, align=p_align))

    loads = [p for p in ph if p['type'] == PT_LOAD]
    def va2off(va: int):
        for p in loads:
            if p['vaddr'] <= va < p['vaddr'] + p['filesz']:
                return p['offset'] + (va - p['vaddr'])
        return None

    dynseg = next((p for p in ph if p['type'] == PT_DYNAMIC), None)
    if not dynseg:
        raise ValueError('no PT_DYNAMIC')
    dyn = {}
    for o in range(dynseg['offset'], dynseg['offset'] + dynseg['filesz'], 16):
        tag = s64(data, o); val = u64(data, o + 8)
        if tag == DT_NULL: break
        dyn[tag] = val

    rela_va = dyn[DT_RELA]
    rela_off = va2off(rela_va)
    rela_sz = dyn[DT_RELASZ]
    rela_ent = dyn.get(DT_RELAENT, 24)
    relas = []
    for o in range(rela_off, rela_off + rela_sz, rela_ent):
        r_offset = u64(data, o)
        r_info = u64(data, o + 8)
        r_addend = s64(data, o + 16)
        relas.append(dict(offset=r_offset, sym=r_info >> 32, type=r_info & 0xffffffff,
                          addend=r_addend, rela_file_offset=o))

    # Dynamic symbol table count comes from SysV hash nchain.
    symbols = []
    try:
        hash_off = va2off(dyn[DT_HASH])
        nchain = u32(data, hash_off + 4)
        strtab_off = va2off(dyn[DT_STRTAB])
        strsz = dyn[DT_STRSZ]
        symtab_off = va2off(dyn[DT_SYMTAB])
        syment = dyn.get(DT_SYMENT, 24)
        strtab = data[strtab_off:strtab_off + strsz]
        for i in range(nchain):
            o = symtab_off + i * syment
            st_name = u32(data, o)
            st_info = data[o + 4]
            st_other = data[o + 5]
            st_shndx = u16(data, o + 6)
            st_value = u64(data, o + 8)
            st_size = u64(data, o + 16)
            end = strtab.find(b'\0', st_name)
            name = strtab[st_name:end if end >= 0 else None].decode('utf-8', 'replace') if st_name < len(strtab) else ''
            symbols.append(dict(index=i, name=name, value=st_value, size=st_size,
                                info=st_info, other=st_other, shndx=st_shndx))
    except Exception as exc:
        symbols = [dict(error=str(exc))]

    return dict(program_headers=ph, dynamic=dyn, relas=relas, symbols=symbols, va2off=va2off)


def find_cstrings(data: bytes, needle: bytes):
    out=[]; start=0
    while True:
        p=data.find(needle, start)
        if p < 0: break
        # Require a C-string boundary where practical.
        before_ok = p == 0 or data[p-1] == 0
        after = p + len(needle)
        after_ok = after < len(data) and data[after] == 0
        if before_ok and after_ok: out.append(p)
        start=p+1
    return out


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--lib', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args=ap.parse_args()
    data=args.lib.read_bytes()
    elf=parse_elf(data)
    va2off=elf['va2off']

    method=b'IiIiiIiIiI'
    sig=b'(Landroid/content/Context;)V'
    class_needles=[
        b'com/inca/security/Proxy/AppGuardProxyApplication',
        b'Lcom/inca/security/Proxy/AppGuardProxyApplication;',
        b'AppGuardProxyApplication',
    ]
    name_vas=find_cstrings(data, method)
    sig_vas=find_cstrings(data, sig)
    class_vas={n.decode(): find_cstrings(data,n) for n in class_needles}

    # In this sample first RX LOAD has vaddr==file offset. Generalize anyway.
    def fileoff_to_va(off: int):
        for p in elf['program_headers']:
            if p['type']==PT_LOAD and p['offset'] <= off < p['offset']+p['filesz']:
                return p['vaddr'] + (off-p['offset'])
        return None
    name_vas=[fileoff_to_va(x) for x in name_vas]
    sig_vas=[fileoff_to_va(x) for x in sig_vas]
    class_vas={k:[fileoff_to_va(x) for x in v] for k,v in class_vas.items()}

    by_target={r['offset']:r for r in elf['relas']}
    by_addend={}
    for r in elf['relas']:
        by_addend.setdefault(r['addend'],[]).append(r)

    candidates=[]
    for nv in name_vas:
        for nr in by_addend.get(nv,[]):
            base=nr['offset']
            sr=by_target.get(base+8)
            fr=by_target.get(base+16)
            if not sr or sr['addend'] not in sig_vas:
                continue
            fn = fr['addend'] if fr else None
            fn_off=va2off(fn) if isinstance(fn,int) and fn >= 0 else None
            code=data[fn_off:fn_off+64].hex() if fn_off is not None else None
            candidates.append(dict(
                table_va=base,
                name_va=nv,
                signature_va=sr['addend'],
                function_va=fn,
                name_relocation=nr,
                signature_relocation=sr,
                function_relocation=fr,
                function_first_64_hex=code,
            ))

    exports=[s for s in elf['symbols'] if s.get('name')=='IiIiiIiIiI']

    # Find all relocations pointing to the callback slot itself and all data
    # relocations in its immediate neighborhood. This makes a later function
    # xref comparison straightforward.
    callback_slot=0x1eb858
    callback_refs=by_addend.get(callback_slot,[])
    callback_near=[r for r in elf['relas'] if callback_slot-0x100 <= r['offset'] <= callback_slot+0x100]

    report={
        'library': str(args.lib),
        'method': method.decode(),
        'signature': sig.decode(),
        'method_string_vas': name_vas,
        'signature_string_vas': sig_vas,
        'class_string_vas': class_vas,
        'dynamic_exports_named_IiIiiIiIiI': exports,
        'jni_native_method_candidates': candidates,
        'callback_slot': callback_slot,
        'relocations_with_addend_callback_slot': callback_refs,
        'relocations_targeting_callback_neighborhood': callback_near,
        'rela_count': len(elf['relas']),
    }
    args.out.mkdir(parents=True,exist_ok=True)
    (args.out/'jni-registration.json').write_text(json.dumps(report,indent=2)+'\n')

    L=['# AppGuard JNI registration recovery','',
       f'- method: `{method.decode()}`', f'- signature: `{sig.decode()}`',
       f'- method strings: {", ".join(f"`0x{x:x}`" for x in name_vas) or "none"}',
       f'- signature strings: {", ".join(f"`0x{x:x}`" for x in sig_vas) or "none"}',
       f'- JNINativeMethod candidates: **{len(candidates)}**','']
    for i,c in enumerate(candidates,1):
        L += [f'## Candidate {i}','',
              f'- table VA: `0x{c["table_va"]:x}`',
              f'- name VA: `0x{c["name_va"]:x}`',
              f'- signature VA: `0x{c["signature_va"]:x}`',
              f'- function VA: `{("0x%x"%c["function_va"]) if isinstance(c["function_va"],int) else "unresolved"}`',
              f'- first 64 bytes: `{c["function_first_64_hex"]}`','']
    L += ['## Same-name dynamic exports','']
    for s in exports:
        L.append(f'- `0x{s["value"]:x}` size={s["size"]} symbol-index={s["index"]}')
    L += ['', '## Callback slot evidence','',
          f'- target callback slot: `0x{callback_slot:x}`',
          f'- relocations whose addend points to slot: **{len(callback_refs)}**',
          f'- relocations targeting ±0x100 around slot: **{len(callback_near)}**','']
    (args.out/'jni-registration.md').write_text('\n'.join(L)+'\n')
    print(json.dumps(report,indent=2))

if __name__=='__main__':
    main()

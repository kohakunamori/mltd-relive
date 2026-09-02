#!/usr/bin/env python3
"""Recover libstub -> libcompatible loader bridge despite corrupted section headers.

The exact MLTD AppGuard libstub keeps a valid PT_DYNAMIC table but intentionally
makes section-driven tooling misleading.  Parse DT_* structures directly, then
force-disassemble the raw weak/preemptible SoLibraryStart body and scan the raw
file for calls/PLT-like stubs without trusting section membership.
"""
from __future__ import annotations

import argparse, json, struct
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_MEM, ARM64_OP_REG
from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile

TARGET_NAMES = {'SoLibraryStart', 'SoLibraryEnd', 'GetAsmFunction'}


def va_to_file(loads, va: int):
    for s in loads:
        if s['va'] <= va < s['va'] + s['filesz']:
            return s['off'] + va - s['va']
    return None


def parse_dynamic(path: Path):
    raw = path.read_bytes()
    with path.open('rb') as f:
        elf = ELFFile(f)
        loads = []
        dynamic = {}
        needed = []
        for seg in elf.iter_segments():
            if str(seg['p_type']) == 'PT_LOAD':
                loads.append({'va': int(seg['p_vaddr']), 'off': int(seg['p_offset']), 'filesz': int(seg['p_filesz']), 'memsz': int(seg['p_memsz']), 'flags': int(seg['p_flags'])})
            if isinstance(seg, DynamicSegment) or str(seg['p_type']) == 'PT_DYNAMIC':
                try:
                    for tag in seg.iter_tags():
                        name = str(tag.entry.d_tag)
                        if name == 'DT_NEEDED':
                            needed.append(tag.needed)
                        elif hasattr(tag.entry, 'd_val'):
                            dynamic[name] = int(tag.entry.d_val)
                        elif hasattr(tag.entry, 'd_ptr'):
                            dynamic[name] = int(tag.entry.d_ptr)
                except Exception:
                    pass

    symtab = dynamic.get('DT_SYMTAB')
    strtab = dynamic.get('DT_STRTAB')
    syment = dynamic.get('DT_SYMENT', 24)
    jmprel = dynamic.get('DT_JMPREL')
    pltrelsz = dynamic.get('DT_PLTRELSZ', 0)
    if symtab is None or strtab is None:
        raise SystemExit('DT_SYMTAB/DT_STRTAB missing')
    symoff = va_to_file(loads, symtab)
    stroff = va_to_file(loads, strtab)
    if symoff is None or stroff is None:
        raise SystemExit('dynamic sym/str table not file-backed')

    def sym(index: int):
        off = symoff + index * syment
        st_name, st_info, st_other, st_shndx, st_value, st_size = struct.unpack_from('<IBBHQQ', raw, off)
        noff = stroff + st_name
        end = raw.find(b'\0', noff)
        name = raw[noff:end].decode('utf-8', errors='replace') if end >= 0 else ''
        return {'index': index, 'name': name, 'value': st_value, 'size': st_size, 'shndx': st_shndx, 'info': st_info}

    relocs = []
    if jmprel is not None and pltrelsz:
        roff = va_to_file(loads, jmprel)
        if roff is not None:
            for off in range(roff, roff + pltrelsz, 24):
                r_offset, r_info, r_addend = struct.unpack_from('<QQq', raw, off)
                sidx = r_info >> 32
                rtype = r_info & 0xffffffff
                s = sym(sidx) if sidx else {'index': 0, 'name': '', 'value': 0, 'size': 0, 'shndx': 0, 'info': 0}
                relocs.append({'rela_file_offset': off, 'offset': r_offset, 'type': rtype, 'symbol': s, 'addend': r_addend})

    targets = [r for r in relocs if r['symbol']['name'] in TARGET_NAMES or 'SoLibrary' in r['symbol']['name'] or 'AsmFunction' in r['symbol']['name']]
    return raw, loads, dynamic, needed, relocs, targets


def disasm_raw(raw: bytes, start: int, size: int):
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    out = []
    end = min(len(raw), start + size)
    for pc in range(start & ~3, end - 3, 4):
        ds = list(md.disasm(raw[pc:pc+4], pc, count=1))
        if not ds:
            out.append({'address': pc, 'mnemonic': '.word', 'op_str': f'0x{int.from_bytes(raw[pc:pc+4],"little"):08x}'})
            continue
        ins = ds[0]
        out.append({'address': pc, 'mnemonic': ins.mnemonic, 'op_str': ins.op_str})
    return out


def scan_raw(raw: bytes, target_relocs):
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    target_values = {r['symbol']['value']: r['symbol']['name'] for r in target_relocs if r['symbol']['value']}
    got_targets = {r['offset']: r['symbol']['name'] for r in target_relocs}
    direct_calls = []
    plt_like = []

    # Raw BL scan across the complete file, including bytes omitted by corrupted PT_LOAD/sections.
    for pc in range(0, len(raw) - 4, 4):
        ds = list(md.disasm(raw[pc:pc+4], pc, count=1))
        if not ds:
            continue
        ins = ds[0]
        if ins.mnemonic == 'bl' and ins.operands and ins.operands[0].type == ARM64_OP_IMM:
            t = int(ins.operands[0].imm)
            if t in target_values:
                direct_calls.append({'address': pc, 'target': t, 'symbol': target_values[t], 'context': disasm_raw(raw, max(0, pc-0x60), 0xc4)})

    # Canonical AArch64 PLT-like sequences; calculate the referenced GOT slot
    # from Capstone's resolved ADRP immediate rather than trusting section names.
    for pc in range(0, len(raw) - 16, 4):
        insns = []
        ok = True
        for j in range(4):
            ds = list(md.disasm(raw[pc+4*j:pc+4*j+4], pc+4*j, count=1))
            if not ds:
                ok = False; break
            insns.append(ds[0])
        if not ok:
            continue
        a, l, ad, br = insns
        if a.mnemonic != 'adrp' or l.mnemonic != 'ldr' or ad.mnemonic != 'add' or br.mnemonic != 'br':
            continue
        if len(a.operands) < 2 or a.operands[0].type != ARM64_OP_REG or a.reg_name(a.operands[0].reg) != 'x16' or a.operands[1].type != ARM64_OP_IMM:
            continue
        if len(l.operands) < 2 or l.operands[0].type != ARM64_OP_REG or l.reg_name(l.operands[0].reg) != 'x17' or l.operands[1].type != ARM64_OP_MEM or l.reg_name(l.operands[1].mem.base) != 'x16':
            continue
        if len(br.operands) < 1 or br.operands[0].type != ARM64_OP_REG or br.reg_name(br.operands[0].reg) != 'x17':
            continue
        got = int(a.operands[1].imm) + int(l.operands[1].mem.disp)
        plt_like.append({'address': pc, 'got': got, 'symbol': got_targets.get(got), 'instructions': [{'address':int(x.address),'mnemonic':x.mnemonic,'op_str':x.op_str} for x in insns]})

    return direct_calls, plt_like


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libstub', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    raw, loads, dynamic, needed, relocs, targets = parse_dynamic(args.libstub)
    direct_calls, plt_like = scan_raw(raw, targets)
    target_symbols = []
    for r in targets:
        s = r['symbol']
        if s not in target_symbols:
            target_symbols.append(s)
    forced = []
    for s in target_symbols:
        if s['value'] and s['value'] < len(raw):
            forced.append({'symbol': s, 'instructions': disasm_raw(raw, s['value'], max(0x180, min(0x600, s['size'] or 0x180)))})

    rep = {
        'size': len(raw),
        'loads': loads,
        'dynamic': dynamic,
        'needed': needed,
        'target_relocations': targets,
        'target_symbols': target_symbols,
        'raw_direct_calls': direct_calls,
        'plt_like_stubs': plt_like,
        'forced_symbol_disassembly': forced,
    }
    args.out.mkdir(parents=True, exist_ok=True)
    (args.out/'stub-bridge.json').write_text(json.dumps(rep, indent=2)+'\n')

    L = ['# AppGuard `libstub.so` -> `libcompatible.so` bridge','', '## DT_NEEDED','']
    for n in needed: L.append(f'- `{n}`')
    L += ['', '## PT_DYNAMIC loader relocations','', '| r_offset | type | symbol | dynsym value | size | shndx |','|---:|---:|---|---:|---:|---:|']
    for r in targets:
        s=r['symbol']; L.append(f"| `0x{r['offset']:x}` | `0x{r['type']:x}` | `{s['name']}` | `0x{s['value']:x}` | {s['size']} | `{s['shndx']}` |")
    L += ['', '## Raw-file canonical PLT-like stubs','', '| Address | GOT target | Bound symbol |','|---:|---:|---|']
    for p in plt_like:
        L.append(f"| `0x{p['address']:x}` | `0x{p['got']:x}` | `{p.get('symbol') or '-'}` |")
    L += ['', '## Raw direct calls to loader symbol values','']
    if not direct_calls: L.append('No raw direct `BL` to the weak symbol value; runtime symbol preemption/GOT dispatch is expected.')
    for c in direct_calls:
        L += [f"### `{c['symbol']}` at `0x{c['address']:x}`",'', '```asm']
        for i in c['context']: L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
        L += ['```','']
    L += ['', '## Forced raw disassembly of loader symbol bodies','']
    for f in forced:
        s=f['symbol']; L += [f"### `{s['name']}` @ `0x{s['value']:x}` (declared size {s['size']})",'', '```asm']
        for i in f['instructions']: L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}")
        L += ['```','']
    (args.out/'stub-bridge.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'needed':needed,'targets':targets,'direct_calls':len(direct_calls),'plt_like':len(plt_like),'forced':[(x['symbol']['name'],hex(x['symbol']['value'])) for x in forced]}, indent=2))

if __name__ == '__main__':
    main()

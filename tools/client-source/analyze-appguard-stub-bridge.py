#!/usr/bin/env python3
"""Recover libstub -> libcompatible loader bridge for the exact MLTD AppGuard sample."""
from __future__ import annotations

import argparse, json
from pathlib import Path
from collections import defaultdict

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

TARGET_NAMES = {'SoLibraryStart', 'SoLibraryEnd', 'GetAsmFunction'}


def load_elf(path: Path):
    with path.open('rb') as f:
        elf = ELFFile(f)
        dynsym = elf.get_section_by_name('.dynsym')
        imports = []
        exports = []
        if dynsym:
            for i, s in enumerate(dynsym.iter_symbols()):
                if not s.name:
                    continue
                row = {'index': i, 'name': s.name, 'value': int(s['st_value']), 'size': int(s['st_size']), 'shndx': s['st_shndx']}
                (imports if s['st_shndx'] == 'SHN_UNDEF' else exports).append(row)
        sections = []
        for sec in elf.iter_sections():
            sections.append({'name': sec.name, 'addr': int(sec['sh_addr']), 'off': int(sec['sh_offset']), 'size': int(sec['sh_size']), 'flags': int(sec['sh_flags'])})
        needed = []
        dyn = elf.get_section_by_name('.dynamic')
        if dyn:
            for tag in dyn.iter_tags():
                if tag.entry.d_tag == 'DT_NEEDED':
                    needed.append(tag.needed)
        relocs = []
        for sec in elf.iter_sections():
            if sec['sh_type'] not in ('SHT_RELA', 'SHT_REL'):
                continue
            linked = elf.get_section(sec['sh_link']) if sec['sh_link'] else None
            for rel in sec.iter_relocations():
                idx = int(rel.entry.r_info_sym)
                name = ''
                if linked is not None and idx:
                    try: name = linked.get_symbol(idx).name
                    except Exception: pass
                if name in TARGET_NAMES or 'SoLibrary' in name or 'AsmFunction' in name:
                    relocs.append({'section': sec.name, 'offset': int(rel['r_offset']), 'type': int(rel.entry.r_info_type), 'symbol_index': idx, 'symbol': name, 'addend': int(rel.entry.r_addend) if hasattr(rel.entry, 'r_addend') else None})
        # Recover AArch64 PLT stubs from .rela.plt ordering when section names are intact.
        plt_map = {}
        plt = elf.get_section_by_name('.plt')
        rela_plt = elf.get_section_by_name('.rela.plt')
        if plt is not None and rela_plt is not None and dynsym is not None:
            base = int(plt['sh_addr'])
            for i, rel in enumerate(rela_plt.iter_relocations()):
                idx = int(rel.entry.r_info_sym)
                name = dynsym.get_symbol(idx).name if idx else ''
                if name:
                    plt_map[base + 32 + 16*i] = name
        exec_sections = []
        for sec in elf.iter_sections():
            if int(sec['sh_flags']) & 0x4 and int(sec['sh_size']):
                exec_sections.append((sec.name, int(sec['sh_addr']), int(sec['sh_offset']), sec.data()))
    return imports, exports, needed, relocs, plt_map, exec_sections


def scan_calls(exec_sections, plt_map):
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    calls = []
    all_ins = {}
    for secname, va, off, data in exec_sections:
        for ins in md.disasm(data, va):
            all_ins[int(ins.address)] = {'section': secname, 'address': int(ins.address), 'file_offset': off + int(ins.address)-va, 'mnemonic': ins.mnemonic, 'op_str': ins.op_str}
            if ins.mnemonic == 'bl' and ins.operands and ins.operands[0].type == ARM64_OP_IMM:
                target = int(ins.operands[0].imm)
                name = plt_map.get(target)
                if name and (name in TARGET_NAMES or 'SoLibrary' in name or 'AsmFunction' in name):
                    calls.append({'address': int(ins.address), 'file_offset': off + int(ins.address)-va, 'target': target, 'symbol': name, 'section': secname})
    # Include a bounded instruction window around each callsite.
    for c in calls:
        window = []
        for a in range(c['address']-0x80, c['address']+0x84, 4):
            if a in all_ins:
                window.append(all_ins[a])
        c['context'] = window
    return calls


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libstub', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    imports, exports, needed, relocs, plt_map, exec_sections = load_elf(args.libstub)
    calls = scan_calls(exec_sections, plt_map)
    rep = {
        'needed': needed,
        'target_imports': [x for x in imports if x['name'] in TARGET_NAMES or 'SoLibrary' in x['name'] or 'AsmFunction' in x['name']],
        'target_exports': [x for x in exports if x['name'] in TARGET_NAMES or 'SoLibrary' in x['name'] or 'AsmFunction' in x['name']],
        'target_relocations': relocs,
        'target_callsites': calls,
    }
    args.out.mkdir(parents=True, exist_ok=True)
    (args.out/'stub-bridge.json').write_text(json.dumps(rep, indent=2)+'\n')
    L = ['# AppGuard `libstub.so` -> `libcompatible.so` bridge','', '## DT_NEEDED','']
    for n in needed: L.append(f'- `{n}`')
    L += ['', '## Loader-related imports', '']
    for x in rep['target_imports']: L.append(f"- `{x['name']}` dynsym#{x['index']}")
    L += ['', '## Loader-related relocations','', '| Section | Offset | Type | Symbol |','|---|---:|---:|---|']
    for r in relocs: L.append(f"| `{r['section']}` | `0x{r['offset']:x}` | {r['type']} | `{r['symbol']}` |")
    L += ['', '## Direct PLT callsites','']
    if not calls: L.append('No direct PLT callsite recovered; the bridge may use a relocated function pointer or protected code.')
    for c in calls:
        L += [f"### `{c['symbol']}` call at `0x{c['address']:x}`",'', '```asm']
        for i in c['context']:
            mark = '  ; <-- call' if i['address'] == c['address'] else ''
            L.append(f"0x{i['address']:x}: {i['mnemonic']} {i['op_str']}{mark}")
        L += ['```','']
    (args.out/'stub-bridge.md').write_text('\n'.join(L)+'\n')
    print(json.dumps({'needed':needed,'target_imports':rep['target_imports'],'relocations':len(relocs),'callsites':len(calls)},indent=2))

if __name__ == '__main__':
    main()

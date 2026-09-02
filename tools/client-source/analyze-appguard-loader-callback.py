#!/usr/bin/env python3
"""Trace the runtime-installed AppGuard loader callback recovered by DT_INIT.

The Bionic-accurate bootstrap emulator proves asmFunction[0x98/0xa0] becomes
libcompatible VA 0xd356c.  This pass treats that concrete callback as a CFG root
and labels direct PLT imports so the next protected-module loader stage can be
recovered without trusting intentionally corrupted symbol sizes.
"""
from __future__ import annotations

import argparse, bisect, hashlib, json
from collections import Counter, defaultdict, deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

MAX_BLOCKS = 50000
MAX_INSNS = 300000
MAX_DEPTH = 24


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1 << 20), b''):
            h.update(chunk)
    return h.hexdigest()


class Image:
    def __init__(self, path: Path):
        self.segments = []
        self.symbols = []
        with path.open('rb') as f:
            elf = ELFFile(f)
            for seg in elf.iter_segments():
                if str(seg['p_type']) == 'PT_LOAD':
                    self.segments.append({
                        'va': int(seg['p_vaddr']),
                        'off': int(seg['p_offset']),
                        'filesz': int(seg['p_filesz']),
                        'flags': int(seg['p_flags']),
                        'data': seg.data(),
                    })
            for sec in elf.iter_sections():
                if isinstance(sec, SymbolTableSection):
                    for sym in sec.iter_symbols():
                        if sym.name and sym['st_shndx'] != 'SHN_UNDEF' and int(sym['st_value']):
                            self.symbols.append({
                                'name': sym.name,
                                'address': int(sym['st_value']),
                                'size': int(sym['st_size']),
                            })
        self.by_addr = defaultdict(list)
        for s in self.symbols:
            self.by_addr[s['address']].append(s)
        self.addrs = sorted(self.by_addr)

    def executable(self, addr: int) -> bool:
        return any((s['flags'] & 1) and s['va'] <= addr < s['va'] + s['filesz'] for s in self.segments)

    def read(self, addr: int, n: int) -> bytes:
        for s in self.segments:
            if s['va'] <= addr and addr + n <= s['va'] + s['filesz']:
                off = addr - s['va']
                return s['data'][off:off+n]
        return b''

    def file_offset(self, addr: int):
        for s in self.segments:
            if s['va'] <= addr < s['va'] + s['filesz']:
                return s['off'] + addr - s['va']
        return None

    def exact(self, addr: int):
        return sorted(x['name'] for x in self.by_addr.get(addr, []))

    def nearest(self, addr: int):
        i = bisect.bisect_right(self.addrs, addr) - 1
        if i < 0:
            return None
        start = self.addrs[i]
        row = max(self.by_addr[start], key=lambda x: x['size'])
        return {'name': row['name'], 'start': start, 'offset': addr - start, 'size': row['size']}


def branch_target(ins):
    for op in reversed(ins.operands):
        if op.type == ARM64_OP_IMM:
            return int(op.imm)
    return None


def trace(path: Path, entry: int, plt: dict[str, str]):
    image = Image(path)
    if not image.executable(entry):
        raise SystemExit(f'entry 0x{entry:x} is not executable/file-backed')
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    queue = deque([(entry, 0)])
    visited = set()
    blocks = []
    calls = []
    indirect = []
    invalid = []
    instructions = 0

    while queue and len(blocks) < MAX_BLOCKS and instructions < MAX_INSNS:
        start, depth = queue.popleft()
        if start in visited or start % 4 or not image.executable(start):
            continue
        visited.add(start)
        pc = start
        rows = []
        successors = []
        termination = None
        for _ in range(2048):
            raw = image.read(pc, 4)
            if len(raw) != 4:
                termination = 'unmapped'
                break
            decoded = list(md.disasm(raw, pc, count=1))
            if not decoded:
                invalid.append({'address': pc, 'file_offset': image.file_offset(pc), 'owner': image.nearest(pc), 'depth': depth})
                termination = 'invalid'
                break
            ins = decoded[0]
            instructions += 1
            row = {'address': pc, 'file_offset': image.file_offset(pc), 'mnemonic': ins.mnemonic, 'op_str': ins.op_str}
            names = image.exact(pc)
            if names:
                row['symbols'] = names
            rows.append(row)
            m = ins.mnemonic
            target = branch_target(ins)

            if m == 'bl':
                imp = plt.get(hex(target)) if target is not None else None
                calls.append({
                    'address': pc,
                    'file_offset': image.file_offset(pc),
                    'target': target,
                    'target_symbols': image.exact(target) if target is not None else [],
                    'target_nearest': image.nearest(target) if target is not None else None,
                    'plt_import': imp,
                    'owner': image.nearest(pc),
                    'depth': depth,
                })
                if target is not None and image.executable(target) and not imp and depth < MAX_DEPTH:
                    queue.append((target, depth + 1))
                pc += 4
                continue
            if m == 'blr':
                indirect.append({'address': pc, 'file_offset': image.file_offset(pc), 'op_str': ins.op_str, 'owner': image.nearest(pc), 'depth': depth})
                termination = 'blr'
                break
            if m == 'b':
                if target is not None and image.executable(target):
                    successors.append(target)
                    queue.append((target, depth))
                termination = 'b'
                break
            if m.startswith('b.') or m in ('cbz', 'cbnz', 'tbz', 'tbnz'):
                if target is not None and image.executable(target):
                    successors.append(target)
                    queue.append((target, depth))
                fallthrough = pc + 4
                if image.executable(fallthrough):
                    successors.append(fallthrough)
                    queue.append((fallthrough, depth))
                termination = m
                break
            if m in ('ret', 'br', 'udf'):
                termination = m
                break
            pc += 4
        blocks.append({
            'start': start,
            'depth': depth,
            'owner': image.nearest(start),
            'instructions': rows,
            'termination': termination,
            'successors': sorted(set(successors)),
        })

    imports = Counter(c['plt_import'] for c in calls if c.get('plt_import'))
    return {
        'sample_sha256': sha256(path),
        'entry': entry,
        'stats': {
            'blocks': len(blocks),
            'instructions': instructions,
            'direct_calls': len(calls),
            'indirect_calls': len(indirect),
            'invalid': len(invalid),
        },
        'import_call_counts': dict(imports.most_common()),
        'calls': calls,
        'indirect_calls': indirect,
        'invalid_sites': invalid,
        'blocks': blocks,
    }


def render_md(rep):
    L = [
        '# AppGuard runtime loader callback CFG', '',
        f"- entry: `0x{rep['entry']:x}`",
        f"- blocks: **{rep['stats']['blocks']}**",
        f"- instructions: **{rep['stats']['instructions']}**",
        f"- direct calls: **{rep['stats']['direct_calls']}**",
        f"- indirect-call boundaries: **{rep['stats']['indirect_calls']}**",
        f"- invalid boundaries: **{rep['stats']['invalid']}**", '',
        '## Imported functions reached', '',
        '| Import | Calls |', '|---|---:|',
    ]
    for name, count in rep['import_call_counts'].items():
        L.append(f'| `{name}` | {count} |')
    L += ['', '## Direct calls', '', '| Callsite | Depth | Target | Label | Import |', '|---:|---:|---:|---|---|']
    for c in rep['calls'][:1200]:
        names = c.get('target_symbols') or []
        near = c.get('target_nearest') or {}
        label = ','.join(names) if names else (near.get('name', '-') + (f"+0x{near.get('offset',0):x}" if near else ''))
        L.append(f"| `0x{c['address']:x}` | {c['depth']} | `{hex(c['target']) if c['target'] is not None else '-'}` | `{label}` | `{c.get('plt_import') or '-'}` |")
    L += ['', '## Indirect-call boundaries', '', '| Address | Depth | Instruction | Owner |', '|---:|---:|---|---|']
    for c in rep['indirect_calls'][:400]:
        owner = (c.get('owner') or {}).get('name', '-')
        L.append(f"| `0x{c['address']:x}` | {c['depth']} | `{c['op_str']}` | `{owner}` |")
    L += ['', '## First code blocks', '']
    for b in sorted(rep['blocks'], key=lambda x: (x['depth'], x['start']))[:120]:
        L += [f"### `0x{b['start']:x}` depth {b['depth']} ({b['termination']})", '', '```asm']
        for ins in b['instructions'][:120]:
            L.append(f"0x{ins['address']:x}: {ins['mnemonic']} {ins['op_str']}")
        L += ['```', '']
    return '\n'.join(L) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--loader-slice', type=Path, required=True)
    ap.add_argument('--entry', type=lambda x: int(x, 0), default=0xd356c)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    loader = json.loads(args.loader_slice.read_text())
    plt = {k: v['symbol'] for k, v in loader.get('plt_stubs', {}).items()}
    rep = trace(args.libcompatible, args.entry, plt)
    args.out.mkdir(parents=True, exist_ok=True)
    (args.out / 'loader-callback-cfg.json').write_text(json.dumps(rep, indent=2) + '\n')
    (args.out / 'loader-callback-cfg.md').write_text(render_md(rep))
    print(json.dumps({'entry': hex(rep['entry']), **rep['stats'], 'imports': rep['import_call_counts']}, indent=2))


if __name__ == '__main__':
    main()

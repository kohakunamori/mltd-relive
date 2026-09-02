#!/usr/bin/env python3
"""Trace the exact MLTD AppGuard bootstrap before its encrypted code is restored.

The on-disk libcompatible.so intentionally contains encrypted 16-byte function
slots (including asm_* wrappers), so whole-segment linear disassembly and xref
scans are misleading. This pass starts only from stable loader entry points:
DT_INIT, ELF e_entry and any visible JNI_OnLoad-like symbol. It recursively
follows valid AArch64 control flow and performs small constant propagation for
ADRP/ADR/MOV/ADD so writes/references into protected code regions can be found.
"""
from __future__ import annotations

import argparse
import bisect
import hashlib
import json
from collections import defaultdict, deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_MEM, ARM64_OP_REG
from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile
from elftools.elf.sections import SymbolTableSection

ASM_RANGE = (0xD2340, 0xD2440)
INTERESTING_RANGES = {
    'asm_wrapper_slots': ASM_RANGE,
}
MAX_INSN = 180000
MAX_BLOCKS = 30000
MAX_CALL_DEPTH = 10


def sha256(p: Path) -> str:
    h = hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            h.update(b)
    return h.hexdigest()


def all_symbols(elf: ELFFile) -> list[dict]:
    out = []
    for sec in elf.iter_sections():
        if not isinstance(sec, SymbolTableSection):
            continue
        for s in sec.iter_symbols():
            if not s.name or s['st_shndx'] == 'SHN_UNDEF':
                continue
            a = int(s['st_value'])
            if not a:
                continue
            out.append({
                'name': s.name,
                'address': a,
                'size': int(s['st_size']),
                'type': str(s['st_info']['type']),
                'bind': str(s['st_info']['bind']),
            })
    dedup = {(x['address'], x['name']): x for x in out}
    return sorted(dedup.values(), key=lambda x: (x['address'], x['name']))


def dynamic_init(elf: ELFFile) -> int | None:
    for seg in elf.iter_segments():
        if isinstance(seg, DynamicSegment) or str(seg['p_type']) == 'PT_DYNAMIC':
            try:
                for tag in seg.iter_tags():
                    if tag.entry.d_tag == 'DT_INIT':
                        return int(tag.entry.d_val)
            except Exception:
                pass
    return None


def load_segments(elf: ELFFile) -> list[dict]:
    rows = []
    for seg in elf.iter_segments():
        if str(seg['p_type']) != 'PT_LOAD':
            continue
        rows.append({
            'vaddr': int(seg['p_vaddr']),
            'memsz': int(seg['p_memsz']),
            'filesz': int(seg['p_filesz']),
            'offset': int(seg['p_offset']),
            'flags': int(seg['p_flags']),
            'data': seg.data(),
        })
    return rows


class Image:
    def __init__(self, segs: list[dict]):
        self.segs = segs

    def executable(self, addr: int) -> bool:
        return any((s['flags'] & 1) and s['vaddr'] <= addr < s['vaddr'] + s['filesz'] for s in self.segs)

    def mapped(self, addr: int) -> bool:
        return any(s['vaddr'] <= addr < s['vaddr'] + s['memsz'] for s in self.segs)

    def read(self, addr: int, n: int) -> bytes:
        for s in self.segs:
            if s['vaddr'] <= addr < s['vaddr'] + s['filesz']:
                off = addr - s['vaddr']
                return s['data'][off:off+n]
        return b''

    def file_offset(self, addr: int) -> int | None:
        for s in self.segs:
            if s['vaddr'] <= addr < s['vaddr'] + s['filesz']:
                return s['offset'] + addr - s['vaddr']
        return None


def symbol_lookup(symbols: list[dict]):
    grouped = defaultdict(list)
    for s in symbols:
        grouped[s['address']].append(s)
    pairs = []
    for addr, rows in grouped.items():
        rows.sort(key=lambda r: (-r['size'], r['name']))
        pairs.append((addr, rows[0]))
    pairs.sort()
    addrs = [a for a, _ in pairs]

    def exact(addr: int):
        rows = grouped.get(addr)
        return sorted(rows, key=lambda r: r['name']) if rows else []

    def nearest(addr: int):
        i = bisect.bisect_right(addrs, addr) - 1
        if i < 0:
            return None
        start, row = pairs[i]
        return {**row, 'offset': addr - start}
    return exact, nearest


def reg_name(ins, op) -> str | None:
    if op.type != ARM64_OP_REG:
        return None
    return ins.reg_name(op.reg)


def normalize_xreg(name: str | None) -> str | None:
    if not name:
        return None
    if name.startswith('w') and name[1:].isdigit():
        return 'x' + name[1:]
    return name


def branch_target(ins) -> int | None:
    for op in reversed(ins.operands):
        if op.type == ARM64_OP_IMM:
            return int(op.imm)
    return None


def classify_target(addr: int) -> list[str]:
    hits = []
    for name, (lo, hi) in INTERESTING_RANGES.items():
        if lo <= addr < hi:
            hits.append(name)
    return hits


def transfer_constants(ins, regs: dict[str, int]) -> list[dict]:
    """Tiny AArch64 constant propagation; returns memory-reference events."""
    events = []
    m = ins.mnemonic
    ops = ins.operands

    def kill(dst: str | None):
        dst = normalize_xreg(dst)
        if dst:
            regs.pop(dst, None)

    if m in ('adr', 'adrp') and len(ops) >= 2 and ops[0].type == ARM64_OP_REG and ops[1].type == ARM64_OP_IMM:
        regs[normalize_xreg(reg_name(ins, ops[0]))] = int(ops[1].imm)
    elif m in ('mov', 'movz') and len(ops) >= 2 and ops[0].type == ARM64_OP_REG:
        dst = normalize_xreg(reg_name(ins, ops[0]))
        if ops[1].type == ARM64_OP_IMM:
            regs[dst] = int(ops[1].imm)
        elif ops[1].type == ARM64_OP_REG:
            src = normalize_xreg(reg_name(ins, ops[1]))
            if src in regs:
                regs[dst] = regs[src]
            else:
                kill(dst)
        else:
            kill(dst)
    elif m == 'movk' and len(ops) >= 2 and ops[0].type == ARM64_OP_REG and ops[1].type == ARM64_OP_IMM:
        dst = normalize_xreg(reg_name(ins, ops[0]))
        if dst in regs:
            # Capstone exposes shift info on the operand.
            shift = getattr(ops[1].shift, 'value', 0) or 0
            mask = 0xffff << shift
            regs[dst] = (regs[dst] & ~mask) | ((int(ops[1].imm) & 0xffff) << shift)
        else:
            kill(dst)
    elif m in ('add', 'sub') and len(ops) >= 3 and ops[0].type == ARM64_OP_REG and ops[1].type == ARM64_OP_REG and ops[2].type == ARM64_OP_IMM:
        dst = normalize_xreg(reg_name(ins, ops[0]))
        src = normalize_xreg(reg_name(ins, ops[1]))
        if src in regs:
            val = int(ops[2].imm)
            regs[dst] = regs[src] + (val if m == 'add' else -val)
        else:
            kill(dst)
    elif m.startswith(('ldr', 'ldp')) and ops and ops[0].type == ARM64_OP_REG:
        # Loaded value becomes unknown, but record any statically-known load address.
        for op in ops:
            if op.type == ARM64_OP_MEM:
                base = normalize_xreg(ins.reg_name(op.mem.base))
                if base in regs:
                    addr = regs[base] + int(op.mem.disp)
                    events.append({'kind': 'read', 'address': addr})
        kill(reg_name(ins, ops[0]))
        if m.startswith('ldp') and len(ops) > 1 and ops[1].type == ARM64_OP_REG:
            kill(reg_name(ins, ops[1]))
    elif m.startswith(('str', 'stp')):
        for op in ops:
            if op.type == ARM64_OP_MEM:
                base = normalize_xreg(ins.reg_name(op.mem.base))
                if base in regs:
                    addr = regs[base] + int(op.mem.disp)
                    events.append({'kind': 'write', 'address': addr})
    else:
        # Conservative invalidation for obvious register-writing operations.
        if ops and ops[0].type == ARM64_OP_REG and m not in (
            'cmp', 'cmn', 'tst', 'cbz', 'cbnz', 'tbz', 'tbnz', 'br', 'blr', 'ret', 'b', 'bl'
        ) and not m.startswith(('st', 'b.')):
            kill(reg_name(ins, ops[0]))
    return events


def trace(path: Path) -> dict:
    with path.open('rb') as f:
        elf = ELFFile(f)
        if str(elf['e_machine']) != 'EM_AARCH64':
            raise SystemExit('bootstrap tracer currently supports AArch64 only')
        symbols = all_symbols(elf)
        init = dynamic_init(elf)
        entry = int(elf['e_entry'])
        segs = load_segments(elf)
    image = Image(segs)
    exact_sym, nearest_sym = symbol_lookup(symbols)

    roots = []
    if init is not None:
        roots.append({'name': 'DT_INIT', 'address': init})
    roots.append({'name': 'e_entry', 'address': entry})
    for s in symbols:
        low = s['name'].lower()
        if 'jni_onload' in low or low == 'jnionload':
            roots.append({'name': s['name'], 'address': s['address']})
    # Some protected builds expose JNI helpers but not literal JNI_OnLoad. Preserve them as secondary roots.
    for s in symbols:
        if 'JNIEnv' in s['name'] and s['address'] not in {r['address'] for r in roots}:
            roots.append({'name': s['name'], 'address': s['address']})

    # De-duplicate roots by address while retaining aliases.
    by_root = defaultdict(list)
    for r in roots:
        by_root[r['address']].append(r['name'])
    roots = [{'address': a, 'names': sorted(set(n))} for a, n in sorted(by_root.items()) if image.executable(a)]

    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    visited_blocks: set[int] = set()
    visited_insn: set[int] = set()
    blocks = []
    calls = []
    interesting_refs = []
    udf_sites = []
    queue = deque((r['address'], 0, r['names'][0]) for r in roots)

    while queue and len(blocks) < MAX_BLOCKS and len(visited_insn) < MAX_INSN:
        start, depth, provenance = queue.popleft()
        if start in visited_blocks or not image.executable(start) or start % 4:
            continue
        visited_blocks.add(start)
        regs: dict[str, int] = {}
        ins_rows = []
        pc = start
        terminated = None
        successors = []
        for _ in range(512):
            raw = image.read(pc, 4)
            if len(raw) != 4:
                terminated = 'unmapped'; break
            dec = list(md.disasm(raw, pc, count=1))
            if not dec:
                terminated = 'invalid'; break
            ins = dec[0]
            visited_insn.add(pc)
            row = {'address': pc, 'file_offset': image.file_offset(pc), 'mnemonic': ins.mnemonic, 'op_str': ins.op_str}
            syms = exact_sym(pc)
            if syms:
                row['symbols'] = [x['name'] for x in syms]
            ins_rows.append(row)

            for ev in transfer_constants(ins, regs):
                tags = classify_target(ev['address'])
                if tags:
                    interesting_refs.append({
                        'instruction': pc,
                        'file_offset': image.file_offset(pc),
                        'operation': ev['kind'],
                        'target': ev['address'],
                        'target_tags': tags,
                        'owner': nearest_sym(pc),
                        'root_provenance': provenance,
                    })

            m = ins.mnemonic
            target = branch_target(ins)
            if m == 'bl':
                call = {
                    'address': pc,
                    'file_offset': image.file_offset(pc),
                    'target': target,
                    'target_symbols': [x['name'] for x in exact_sym(target)] if target is not None else [],
                    'target_nearest': nearest_sym(target) if target is not None else None,
                    'owner': nearest_sym(pc),
                    'depth': depth,
                    'root_provenance': provenance,
                }
                calls.append(call)
                if target is not None and image.executable(target) and depth < MAX_CALL_DEPTH:
                    queue.append((target, depth + 1, provenance))
                pc += 4
                continue
            if m == 'b':
                if target is not None and image.executable(target):
                    successors.append(target); queue.append((target, depth, provenance))
                terminated = 'b'; break
            if m.startswith('b.') or m in ('cbz', 'cbnz', 'tbz', 'tbnz'):
                if target is not None and image.executable(target):
                    successors.append(target); queue.append((target, depth, provenance))
                fall = pc + 4
                if image.executable(fall):
                    successors.append(fall); queue.append((fall, depth, provenance))
                terminated = m; break
            if m in ('ret', 'br'):
                terminated = m; break
            if m == 'blr':
                terminated = 'indirect-call-boundary'; break
            if m == 'udf':
                udf_sites.append({'address': pc, 'owner': nearest_sym(pc), 'root_provenance': provenance})
                terminated = 'udf'; break
            pc += 4
        blocks.append({
            'start': start,
            'root_provenance': provenance,
            'depth': depth,
            'owner': nearest_sym(start),
            'instructions': ins_rows,
            'termination': terminated,
            'successors': sorted(set(successors)),
        })

    # Calls into the protected slot region are useful even if the target bytes are encrypted.
    protected_calls = [c for c in calls if c['target'] is not None and ASM_RANGE[0] <= c['target'] < ASM_RANGE[1]]
    root_summaries = []
    for r in roots:
        prov = r['names'][0]
        bs = [b for b in blocks if b['root_provenance'] == prov]
        cs = [c for c in calls if c['root_provenance'] == prov]
        refs = [x for x in interesting_refs if x['root_provenance'] == prov]
        root_summaries.append({
            'root': r,
            'blocks': len(bs),
            'calls': len(cs),
            'interesting_refs': len(refs),
            'udf_sites': sum(1 for x in udf_sites if x['root_provenance'] == prov),
        })

    return {
        'sample': {'name': path.name, 'sha256': sha256(path), 'size': path.stat().st_size},
        'dt_init': init,
        'entry': entry,
        'roots': roots,
        'root_summaries': root_summaries,
        'limits': {'max_instructions': MAX_INSN, 'max_blocks': MAX_BLOCKS, 'max_call_depth': MAX_CALL_DEPTH},
        'visited_block_count': len(blocks),
        'visited_instruction_count': len(visited_insn),
        'calls': calls,
        'calls_into_encrypted_asm_slots': protected_calls,
        'interesting_memory_refs': interesting_refs,
        'udf_sites': udf_sites,
        'blocks': blocks,
    }


def write_md(out: Path, rep: dict):
    L = [
        '# AppGuard bootstrap CFG', '',
        f"- sample: `{rep['sample']['sha256']}`",
        f"- `DT_INIT`: `{hex(rep['dt_init']) if rep['dt_init'] is not None else '-'}`",
        f"- ELF entry: `{hex(rep['entry'])}`",
        f"- recursively visited blocks: **{rep['visited_block_count']}**",
        f"- recursively visited instructions: **{rep['visited_instruction_count']}**", '',
        '## Roots', '', '| Address | Names | Blocks | Calls | Protected-slot refs | UDF |', '|---:|---|---:|---:|---:|---:|'
    ]
    summary_by_addr = {x['root']['address']: x for x in rep['root_summaries']}
    for r in rep['roots']:
        s = summary_by_addr.get(r['address'], {})
        L.append(f"| `0x{r['address']:x}` | {', '.join('`'+x+'`' for x in r['names'])} | {s.get('blocks',0)} | {s.get('calls',0)} | {s.get('interesting_refs',0)} | {s.get('udf_sites',0)} |")

    L += ['', '## Direct calls into encrypted `asm_*` slot region', '']
    if rep['calls_into_encrypted_asm_slots']:
        L += ['| Callsite | Owner | Target | Root |', '|---:|---|---:|---|']
        for c in rep['calls_into_encrypted_asm_slots']:
            owner = c['owner']['name'] if c.get('owner') else '-'
            L.append(f"| `0x{c['address']:x}` | `{owner}` | `0x{c['target']:x}` | `{c['root_provenance']}` |")
    else:
        L.append('No direct bootstrap call into the encrypted wrapper slots was recovered; access may be indirect or the slot-decryptor may populate function pointers first.')

    L += ['', '## Statically resolved reads/writes touching protected wrapper slots', '']
    if rep['interesting_memory_refs']:
        L += ['| Instruction | Owner | Operation | Target | Root |', '|---:|---|---|---:|---|']
        for x in rep['interesting_memory_refs']:
            owner = x['owner']['name'] if x.get('owner') else '-'
            L.append(f"| `0x{x['instruction']:x}` | `{owner}` | {x['operation']} | `0x{x['target']:x}` | `{x['root_provenance']}` |")
    else:
        L.append('No direct ADRP/ADR-derived protected-slot memory access was resolved. The bootstrap may compute destinations indirectly or via tables.')

    L += ['', '## First-level calls from each root', '']
    for r in rep['roots']:
        prov = r['names'][0]
        L.append(f"### `{prov}` @ `0x{r['address']:x}`")
        L.append('')
        rows = [c for c in rep['calls'] if c['root_provenance'] == prov and c['depth'] <= 1]
        if not rows:
            L.append('No direct BL calls recovered.')
            L.append(''); continue
        L += ['| Callsite | Target | Symbol/nearest | Depth |', '|---:|---:|---|---:|']
        for c in rows[:160]:
            names = c['target_symbols']
            if names:
                label = ', '.join('`'+x+'`' for x in names)
            elif c.get('target_nearest'):
                n = c['target_nearest']; label = f"`{n['name']}+0x{n['offset']:x}`"
            else:
                label = '-'
            L.append(f"| `0x{c['address']:x}` | `{hex(c['target']) if c['target'] is not None else '-'}` | {label} | {c['depth']} |")
        L.append('')

    out.write_text('\n'.join(L) + '\n', encoding='utf-8')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    rep = trace(args.libcompatible)
    args.out.mkdir(parents=True, exist_ok=True)
    (args.out / 'bootstrap-cfg.json').write_text(json.dumps(rep, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    write_md(args.out / 'bootstrap-cfg.md', rep)
    print(json.dumps({
        'dt_init': rep['dt_init'], 'entry': rep['entry'], 'roots': rep['roots'],
        'blocks': rep['visited_block_count'], 'instructions': rep['visited_instruction_count'],
        'calls': len(rep['calls']), 'protected_calls': len(rep['calls_into_encrypted_asm_slots']),
        'protected_refs': len(rep['interesting_memory_refs'])
    }, indent=2))


if __name__ == '__main__':
    main()

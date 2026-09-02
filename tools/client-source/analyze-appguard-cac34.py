#!/usr/bin/env python3
"""Static + dynamic probe for libcompatible+0xcac34.

The callback installer at +0xc2a30 gates its real callback-pointer path on bit 0
of the return value from +0xcac34.  This probe intentionally reuses the existing
Bionic/Unicorn bootstrap so that the observation is made in the same state that
already reproduces the installer fallback.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
import struct
from collections import Counter, deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM
from unicorn import UC_HOOK_MEM_READ, UcError
from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
P = HERE / 'emulate-appguard-callback-installer.py'
spec = importlib.util.spec_from_file_location('callback_installer', P)
mod = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(mod)
base = mod.base

CAC34 = 0xCAC34
INSTALLER_RETURN = 0xC2A3C
STATIC_LO = 0xCA000
STATIC_HI = 0xCB800
TRUE_SOURCES = [0x1E5638, 0x1E5D40, 0x1E6110, 0x1E59D0, 0x1E5A70, 0x1E5E00]
TRUE_INTERNAL = 0x2E010
DEST_SLOTS = list(mod.SLOTS)


def hx(v):
    return None if v is None else f'0x{int(v):x}'


def readq(uc, rva):
    try:
        return struct.unpack('<Q', bytes(uc.mem_read(base.BIAS + rva, 8)))[0]
    except UcError:
        return None


def branch_target(ins):
    if not getattr(ins, 'operands', None):
        return None
    for op in reversed(ins.operands):
        if op.type == ARM64_OP_IMM:
            return int(op.imm)
    return None


def static_cfg(image):
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    md.detail = True
    work = deque([CAC34])
    seen_blocks = set()
    blocks = []
    direct_calls = []
    indirect_calls = []
    memory_refs = []
    max_blocks = 1024

    while work and len(seen_blocks) < max_blocks:
        start = work.popleft()
        if start in seen_blocks or not (STATIC_LO <= start < STATIC_HI):
            continue
        seen_blocks.add(start)
        pc = start
        rows = []
        for _ in range(512):
            raw = image.read_file_va(pc, 4)
            if len(raw) != 4:
                rows.append({'address': pc, 'bytes': raw.hex(), 'mnemonic': '<unmapped>', 'op_str': ''})
                break
            insns = list(md.disasm(raw, pc, count=1))
            if not insns:
                rows.append({'address': pc, 'bytes': raw.hex(), 'mnemonic': '<invalid>', 'op_str': ''})
                break
            ins = insns[0]
            row = {'address': ins.address, 'bytes': ins.bytes.hex(), 'mnemonic': ins.mnemonic, 'op_str': ins.op_str}
            rows.append(row)
            m = ins.mnemonic
            t = branch_target(ins)
            if m == 'bl':
                if t is not None:
                    direct_calls.append({'callsite': pc, 'target': t})
                pc += 4
                continue
            if m == 'blr':
                indirect_calls.append({'callsite': pc, 'op_str': ins.op_str})
                pc += 4
                continue
            if m == 'b':
                if t is not None and STATIC_LO <= t < STATIC_HI:
                    work.append(t)
                row['successors'] = [t] if t is not None else []
                break
            if m.startswith('b.') or m in ('cbz', 'cbnz', 'tbz', 'tbnz'):
                succ = []
                if t is not None:
                    succ.append(t)
                    if STATIC_LO <= t < STATIC_HI:
                        work.append(t)
                succ.append(pc + 4)
                work.append(pc + 4)
                row['successors'] = succ
                break
            if m in ('ret', 'br', 'eret'):
                row['successors'] = []
                break
            if m in ('adrp', 'adr', 'ldr', 'ldp'):
                memory_refs.append({'address': pc, 'mnemonic': m, 'op_str': ins.op_str})
            pc += 4
        blocks.append({'start': start, 'instructions': rows})

    relas = image.relas()
    source_relocs = []
    for r in relas:
        if r['offset'] in TRUE_SOURCES:
            source_relocs.append({
                'offset': r['offset'],
                'type': r['type'],
                'addend': r['addend'],
                'table': r['table'],
                'symbol': r['symbol'],
            })
    return {
        'entry': CAC34,
        'blocks': sorted(blocks, key=lambda x: x['start']),
        'direct_calls': sorted(direct_calls, key=lambda x: x['callsite']),
        'indirect_calls': sorted(indirect_calls, key=lambda x: x['callsite']),
        'memory_refs': sorted(memory_refs, key=lambda x: x['address']),
        'true_branch_source_relocations': sorted(source_relocs, key=lambda x: x['offset']),
    }


class Probe(mod.E):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.in_cac34 = False
        self.cac_entry = None
        self.cac_exit = None
        self.cac_pcs = []
        self.cac_pc_counts = Counter()
        self.cac_reads = {}
        self.cac_external = []
        self.cac_syscalls = []
        self.cac_history = deque(maxlen=64)

    def regs(self, uc):
        row = {}
        for i in range(31):
            row[f'x{i}'] = uc.reg_read(globals()[f'UC_ARM64_REG_X{i}'])
        row['sp'] = uc.reg_read(UC_ARM64_REG_SP)
        row['pc'] = uc.reg_read(UC_ARM64_REG_PC)
        try:
            row['nzcv'] = uc.reg_read(UC_ARM64_REG_NZCV)
        except Exception:
            row['nzcv'] = None
        return row

    def globals_snapshot(self):
        return {
            'true_sources': {f'0x{x:x}': readq(self.uc, x) for x in TRUE_SOURCES},
            'true_internal': TRUE_INTERNAL,
            'dest_slots': {f'0x{x:x}': readq(self.uc, x) for x in DEST_SLOTS},
            'rwx_ptr': self.current_rwx_ptr,
            'extdata': {k: v for k, v in sorted(self.extdata_by_name.items())},
            'stubs': {k: v for k, v in sorted(self.stub_by_name.items())},
        }

    def code_hook(self, uc, address, size, user):
        rel = address - base.BIAS
        if rel == CAC34 and not self.in_cac34:
            self.in_cac34 = True
            self.cac_entry = {'registers': self.regs(uc), 'globals': self.globals_snapshot()}
        if self.in_cac34:
            self.cac_pcs.append(rel)
            self.cac_pc_counts[rel] += 1
            self.cac_history.append(rel)
        if rel == INSTALLER_RETURN and self.in_cac34:
            self.cac_exit = {
                'registers': self.regs(uc),
                'w0': uc.reg_read(UC_ARM64_REG_W0),
                'globals': self.globals_snapshot(),
                'history': list(self.cac_history),
            }
            self.in_cac34 = False
        super().code_hook(uc, address, size, user)

    def read_hook(self, uc, access, address, size, value, user):
        if not self.in_cac34:
            return
        pc = uc.reg_read(UC_ARM64_REG_PC)
        try:
            raw = bytes(uc.mem_read(address, min(size, 16)))
            v = int.from_bytes(raw[:8], 'little') if raw else 0
        except UcError:
            raw = b''
            v = None
        if base.BIAS <= address < base.BIAS + 0x4000000:
            key_addr = f'+0x{address-base.BIAS:x}'
        else:
            key_addr = f'0x{address:x}'
        key = f'{key_addr}/{size}'
        row = self.cac_reads.get(key)
        if row is None:
            row = {
                'address': address,
                'rva': address - base.BIAS if base.BIAS <= address < base.BIAS + 0x4000000 else None,
                'size': size,
                'count': 0,
                'first_pc': pc - base.BIAS if base.BIAS <= pc < base.BIAS + 0x4000000 else pc,
                'first_value': v,
                'first_bytes': raw.hex(),
            }
            self.cac_reads[key] = row
        row['count'] += 1

    def emulate_external(self, name, address):
        if self.in_cac34:
            xs = [self.uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(8)]
            self.cac_external.append({'name': name, 'stub': address, 'args': xs, 'caller_lr': self.uc.reg_read(UC_ARM64_REG_X30)})
        return super().emulate_external(name, address)

    def syscall_hook(self, uc, intno, user):
        if self.in_cac34:
            nr = uc.reg_read(UC_ARM64_REG_X8)
            xs = [uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(6)]
            self.cac_syscalls.append({'nr': nr, 'args': xs, 'pc': uc.reg_read(UC_ARM64_REG_PC)})
        return super().syscall_hook(uc, intno, user)

    def run_probe(self):
        self.uc.hook_add(UC_HOOK_MEM_READ, self.read_hook)
        boot = self.run_bootstrap()
        before = self.globals_snapshot()
        inst = self.run_installer()
        after = self.globals_snapshot()
        return {
            'bootstrap': boot,
            'installer': inst,
            'before_installer': before,
            'after_installer': after,
            'cac34_entry': self.cac_entry,
            'cac34_exit': self.cac_exit,
            'cac34_unique_pcs': len(self.cac_pc_counts),
            'cac34_total_instructions_observed': sum(self.cac_pc_counts.values()),
            'cac34_hot_pcs': [{'rva': k, 'count': v} for k, v in self.cac_pc_counts.most_common(128)],
            'cac34_path_head': self.cac_pcs[:512],
            'cac34_path_tail': self.cac_pcs[-512:],
            'cac34_memory_reads': sorted(self.cac_reads.values(), key=lambda x: (-x['count'], x['address']))[:2048],
            'cac34_external_calls': self.cac_external,
            'cac34_direct_syscalls': self.cac_syscalls,
        }


def render(rep):
    d = rep['dynamic']
    s = rep['static']
    exit_row = d.get('cac34_exit') or {}
    w0 = exit_row.get('w0')
    L = [
        '# AppGuard `libcompatible+0xcac34` analysis', '',
        f"- static CFG blocks: **{len(s['blocks'])}**",
        f"- direct calls in CFG: **{len(s['direct_calls'])}**",
        f"- dynamic instructions observed inside call: **{d['cac34_total_instructions_observed']}**",
        f"- dynamic unique PCs: **{d['cac34_unique_pcs']}**",
        f"- return `w0`: `{hx(w0)}`",
        f"- installer selected bit0: **{bool(w0 & 1) if w0 is not None else 'unknown'}**", '',
        '## True-branch callback source relocations', '',
        '| source slot | type | table | symbol | symbol value |',
        '|---:|---:|---|---|---:|',
    ]
    rel_by_off = {r['offset']: r for r in s['true_branch_source_relocations']}
    for off in TRUE_SOURCES:
        r = rel_by_off.get(off)
        if r:
            sym = r.get('symbol') or {}
            L.append(f"| `+0x{off:x}` | {r['type']} | `{r['table']}` | `{sym.get('name','')}` | `{hx(sym.get('value'))}` |")
        else:
            L.append(f"| `+0x{off:x}` | - | - | - | - |")
    L += ['', '## Runtime true-branch source values before installer', '', '| source | value |', '|---:|---:|']
    for k, v in d['before_installer']['true_sources'].items():
        L.append(f"| `{k}` | `{hx(v)}` |")
    L.append(f"| internal `+0x{TRUE_INTERNAL:x}` | `{hx(base.BIAS + TRUE_INTERNAL)}` |")
    L += ['', '## `+0xcac34` direct calls', '', '| callsite | target |', '|---:|---:|']
    for x in s['direct_calls']:
        L.append(f"| `+0x{x['callsite']:x}` | `+0x{x['target']:x}` |")
    if not s['direct_calls']:
        L.append('| - | - |')
    L += ['', '## External calls reached dynamically', '', '| # | API | caller LR | x0 | x1 | x2 |', '|---:|---|---:|---:|---:|---:|']
    for i, c in enumerate(d['cac34_external_calls']):
        a = c['args']
        L.append(f"| {i} | `{c['name']}` | `{hx(c['caller_lr']-base.BIAS if base.BIAS <= c['caller_lr'] < base.BIAS+0x4000000 else c['caller_lr'])}` | `{hx(a[0])}` | `{hx(a[1])}` | `{hx(a[2])}` |")
    if not d['cac34_external_calls']:
        L.append('| - | none | - | - | - | - |')
    L += ['', '## Most-read memory locations inside `+0xcac34`', '', '| address/RVA | size | count | first PC | first value |', '|---:|---:|---:|---:|---:|']
    for r in d['cac34_memory_reads'][:128]:
        addr = f"+0x{r['rva']:x}" if r['rva'] is not None else f"0x{r['address']:x}"
        pc = f"+0x{r['first_pc']:x}" if r['first_pc'] < 0x4000000 else f"0x{r['first_pc']:x}"
        L.append(f"| `{addr}` | {r['size']} | {r['count']} | `{pc}` | `{hx(r['first_value'])}` |")
    L += ['', '## Dynamic exit', '', '```json', json.dumps(exit_row, indent=2), '```', '', '## Static CFG disassembly', '']
    for b in s['blocks']:
        L += [f"### block `+0x{b['start']:x}`", '', '```asm']
        for ins in b['instructions']:
            L.append(f"0x{ins['address']:x}: {ins['mnemonic']} {ins['op_str']}")
        L += ['```', '']
    return '\n'.join(L) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    a = ap.parse_args()
    a.out.mkdir(parents=True, exist_ok=True)
    image = base.Image(a.libcompatible)
    static = static_cfg(image)
    emu = Probe(image, a.out)
    dynamic = emu.run_probe()
    rep = {'static': static, 'dynamic': dynamic}
    (a.out / 'cac34-analysis.json').write_text(json.dumps(rep, indent=2) + '\n')
    (a.out / 'cac34-analysis.md').write_text(render(rep))
    print(json.dumps({
        'w0': (dynamic.get('cac34_exit') or {}).get('w0'),
        'cfg_blocks': len(static['blocks']),
        'direct_calls': static['direct_calls'],
        'source_relocations': static['true_branch_source_relocations'],
        'external_calls': [{k: v for k, v in c.items() if k != 'args'} for c in dynamic['cac34_external_calls']],
        'read_count': len(dynamic['cac34_memory_reads']),
        'installer_slots': dynamic['installer']['slots'],
    }, indent=2))


if __name__ == '__main__':
    main()

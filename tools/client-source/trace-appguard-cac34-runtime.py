#!/usr/bin/env python3
"""Trace the *runtime-decrypted* control flow of libcompatible+0xcac34.

Raw file bytes are insufficient here because the AppGuard bootstrap mutates
protected code ranges before the callback installer runs.  This tool snapshots
and disassembles +0xcac34 after bootstrap, then aggregates dynamically executed
BL/BLR edges while the predicate is active.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from collections import Counter
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from capstone.arm64 import ARM64_OP_IMM, ARM64_OP_REG
from unicorn import UcError
from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
P = HERE / 'analyze-appguard-cac34.py'
spec = importlib.util.spec_from_file_location('cac34_analyzer', P)
ana = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(ana)
base = ana.base

ENTRY = 0xCAC34
TOP_END = 0xCAE40
HELPERS = [0x1704E0, 0x11CBEC]

REGS = {f'x{i}': globals()[f'UC_ARM64_REG_X{i}'] for i in range(31)}
REGS.update({f'w{i}': globals()[f'UC_ARM64_REG_W{i}'] for i in range(31)})


def classify_target(e, addr: int):
    stub_names = {v: k for k, v in e.stub_by_name.items()}
    if addr in stub_names:
        return 'external', stub_names[addr]
    if base.BIAS <= addr < base.BIAS + 0x4000000:
        return 'libcompatible', f'+0x{addr-base.BIAS:x}'
    if e.current_rwx_ptr and e.current_rwx_ptr <= addr < e.current_rwx_ptr + 0x1000:
        return 'rwx', f'0x{addr:x}'
    return 'other', f'0x{addr:x}'


class Trace(ana.Probe):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
        self.md.detail = True
        self.call_edges = Counter()
        self.top_exec = Counter()
        self.top_branches = []
        self.first_top_state = {}
        self.last_top_state = {}

    def _decode(self, address, size):
        try:
            raw = bytes(self.uc.mem_read(address, size))
            return next(iter(self.md.disasm(raw, address, count=1)), None)
        except (UcError, StopIteration):
            return None

    def code_hook(self, uc, address, size, user):
        was_active = self.in_cac34 or (address - base.BIAS == ENTRY)
        if was_active:
            ins = self._decode(address, size)
            if ins is not None:
                rva = address - base.BIAS if base.BIAS <= address < base.BIAS + 0x4000000 else address
                if ENTRY <= rva < TOP_END:
                    self.top_exec[rva] += 1
                    regs = {f'x{i}': uc.reg_read(REGS[f'x{i}']) for i in range(8)}
                    regs.update({'x19': uc.reg_read(UC_ARM64_REG_X19), 'x20': uc.reg_read(UC_ARM64_REG_X20),
                                 'x21': uc.reg_read(UC_ARM64_REG_X21), 'x22': uc.reg_read(UC_ARM64_REG_X22),
                                 'x23': uc.reg_read(UC_ARM64_REG_X23), 'x24': uc.reg_read(UC_ARM64_REG_X24),
                                 'x25': uc.reg_read(UC_ARM64_REG_X25), 'x26': uc.reg_read(UC_ARM64_REG_X26),
                                 'x27': uc.reg_read(UC_ARM64_REG_X27), 'nzcv': uc.reg_read(UC_ARM64_REG_NZCV)})
                    self.first_top_state.setdefault(rva, regs)
                    self.last_top_state[rva] = regs
                    if (ins.mnemonic.startswith('b.') or ins.mnemonic in ('cbz','cbnz','tbz','tbnz')):
                        target = None
                        for op in ins.operands:
                            if op.type == ARM64_OP_IMM:
                                target = int(op.imm)
                        self.top_branches.append({'rva': rva, 'mnemonic': ins.mnemonic, 'op_str': ins.op_str,
                                                  'target': target, 'registers': regs})

                if ins.mnemonic in ('bl', 'blr'):
                    target = None
                    if ins.operands:
                        op = ins.operands[0]
                        if op.type == ARM64_OP_IMM:
                            target = int(op.imm)
                        elif op.type == ARM64_OP_REG:
                            name = ins.reg_name(op.reg)
                            rr = REGS.get(name)
                            if rr is not None:
                                target = uc.reg_read(rr)
                    if target is not None:
                        kind, label = classify_target(self, target)
                        caller = rva
                        self.call_edges[(caller, target, kind, label)] += 1
        super().code_hook(uc, address, size, user)

    def runtime_disasm(self, start, end):
        raw = bytes(self.uc.mem_read(base.BIAS + start, end - start))
        rows = []
        for ins in self.md.disasm(raw, start):
            if ins.address >= end:
                break
            rows.append({'rva': ins.address, 'bytes': ins.bytes.hex(), 'mnemonic': ins.mnemonic, 'op_str': ins.op_str})
        return rows


def render(rep):
    L = ['# Runtime-decrypted `libcompatible+0xcac34` trace', '',
         f"- gate return w0: `0x{rep['gate_w0']:x}`",
         f"- gate bit0: **{bool(rep['gate_w0'] & 1)}**",
         f"- dynamic call edges: **{len(rep['call_edges'])}**", '',
         '## Runtime disassembly of top-level predicate', '', '```asm']
    for x in rep['top_runtime_disassembly']:
        mark = '*' if str(x['rva']) in rep['top_exec_counts'] else ' '
        L.append(f"{mark} 0x{x['rva']:x}: {x['bytes']:<8} {x['mnemonic']} {x['op_str']}")
    L += ['```', '', '## Dynamic calls while predicate active', '',
          '| caller | target | class | label | count |', '|---:|---:|---|---|---:|']
    for x in rep['call_edges']:
        L.append(f"| `+0x{x['caller_rva']:x}` | `0x{x['target']:x}` | `{x['kind']}` | `{x['label']}` | {x['count']} |")
    L += ['', '## Executed top-level conditional branches', '',
          '| RVA | instruction | target | executions | representative x0 | x19 | x22 | x27 | NZCV |',
          '|---:|---|---:|---:|---:|---:|---:|---:|---:|']
    counts = Counter((x['rva'], x['mnemonic'], x['op_str']) for x in rep['top_branches'])
    emitted = set()
    for x in rep['top_branches']:
        key = (x['rva'], x['mnemonic'], x['op_str'])
        if key in emitted:
            continue
        emitted.add(key)
        r = x['registers']
        tgt = x['target']
        tgt_s = '-' if tgt is None else f'0x{tgt:x}'
        L.append(f"| `+0x{x['rva']:x}` | `{x['mnemonic']} {x['op_str']}` | `{tgt_s}` | {counts[key]} | "
                 f"`0x{r['x0']:x}` | `0x{r['x19']:x}` | `0x{r['x22']:x}` | `0x{r['x27']:x}` | `0x{r['nzcv']:x}` |")
    for name, rows in rep['helper_runtime_disassembly'].items():
        L += ['', f'## Runtime disassembly helper `{name}`', '', '```asm']
        for x in rows:
            L.append(f"0x{x['rva']:x}: {x['bytes']:<8} {x['mnemonic']} {x['op_str']}")
        L += ['```']
    return '\n'.join(L) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    a = ap.parse_args()
    a.out.mkdir(parents=True, exist_ok=True)
    e = Trace(base.Image(a.libcompatible), a.out)
    boot = e.run_bootstrap()
    top_dis = e.runtime_disasm(ENTRY, TOP_END)
    helper_dis = {f'+0x{x:x}': e.runtime_disasm(x, x + 0x300) for x in HELPERS}
    inst = e.run_installer()
    gate_w0 = (e.cac_exit or {}).get('w0', 0)
    edges = []
    for (caller, target, kind, label), count in e.call_edges.most_common():
        edges.append({'caller_rva': caller, 'target': target, 'kind': kind, 'label': label, 'count': count})
    rep = {
        'bootstrap': boot,
        'installer': inst,
        'gate_w0': gate_w0,
        'top_runtime_disassembly': top_dis,
        'helper_runtime_disassembly': helper_dis,
        'top_exec_counts': {str(k): v for k, v in sorted(e.top_exec.items())},
        'call_edges': edges,
        'top_branches': e.top_branches,
        'entry_state': e.cac_entry,
        'exit_state': e.cac_exit,
    }
    (a.out / 'runtime-trace.json').write_text(json.dumps(rep, indent=2) + '\n')
    (a.out / 'runtime-trace.md').write_text(render(rep))
    print(json.dumps({'gate_w0': gate_w0, 'calls': edges[:80],
                      'top_exec': len(e.top_exec), 'top_branches': len(e.top_branches)}, indent=2))


if __name__ == '__main__':
    main()

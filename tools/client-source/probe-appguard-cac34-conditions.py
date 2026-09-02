#!/usr/bin/env python3
"""Differentially probe the environment predicate behind libcompatible+0xcac34.

This deliberately changes one emulator semantic at a time and records whether
bit 0 of the callback-installer gate changes.  It also emits compact external
API/callsite/return summaries so that subsequent variants are evidence-driven.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from collections import Counter, defaultdict
from pathlib import Path

from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
ANALYZER = HERE / 'analyze-appguard-cac34.py'
spec = importlib.util.spec_from_file_location('cac34_analyzer', ANALYZER)
ana = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(ana)
base = ana.base


def relpc(v):
    if base.BIAS <= v < base.BIAS + 0x4000000:
        return v - base.BIAS
    return v


class VariantProbe(ana.Probe):
    def __init__(self, image, out, variant):
        super().__init__(image, out)
        self.variant = variant
        self.external_returns = []

    def _log_override(self, name, address, xs, ret, extra=None):
        if self.in_cac34:
            self.cac_external.append({
                'name': name,
                'stub': address,
                'args': xs,
                'caller_lr': self.uc.reg_read(UC_ARM64_REG_X30),
            })
        self.stub_return(ret)
        if self.in_cac34:
            row = {
                'name': name,
                'caller_lr': self.uc.reg_read(UC_ARM64_REG_X30),
                'args': xs,
                'ret': ret & 0xffffffffffffffff,
            }
            if extra is not None:
                row['extra'] = extra
            self.external_returns.append(row)

    def emulate_external(self, name, address):
        xs = [self.uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(8)]
        caller = self.uc.reg_read(UC_ARM64_REG_X30)

        if self.variant == 'dlsym-resolve-known' and name == 'dlsym':
            sym = self.cstring(xs[1]) if xs[1] else ''
            ret = self.stub_by_name.get(sym, 0)
            self._log_override(name, address, xs, ret, {'symbol': sym})
            return

        if self.variant.startswith('sysconf=') and name == 'sysconf':
            ret = int(self.variant.split('=', 1)[1], 0)
            self._log_override(name, address, xs, ret, {'key': xs[0]})
            return

        if self.variant.startswith('getauxval=') and name == 'getauxval':
            ret = int(self.variant.split('=', 1)[1], 0)
            self._log_override(name, address, xs, ret, {'key': xs[0]})
            return

        # Preserve the existing emulator semantics, but record the actual return
        # register after the stub model has executed.
        super().emulate_external(name, address)
        if self.in_cac34:
            self.external_returns.append({
                'name': name,
                'caller_lr': caller,
                'args': xs,
                'ret': self.uc.reg_read(UC_ARM64_REG_X0),
            })


def compact_dynamic(d, returns):
    api_counts = Counter()
    site_counts = Counter()
    ret_counts = Counter()
    examples = {}
    for r in returns:
        caller = relpc(r['caller_lr'])
        api_counts[r['name']] += 1
        site_counts[(r['name'], caller)] += 1
        ret_counts[(r['name'], caller, r['ret'])] += 1
        examples.setdefault((r['name'], caller), r)

    return {
        'gate_w0': (d.get('cac34_exit') or {}).get('w0'),
        'gate_bit0': bool(((d.get('cac34_exit') or {}).get('w0') or 0) & 1),
        'instruction_count': d['cac34_total_instructions_observed'],
        'unique_pcs': d['cac34_unique_pcs'],
        'api_counts': [{'name': n, 'count': c} for n, c in api_counts.most_common()],
        'callsite_counts': [
            {'name': n, 'caller_rva': pc, 'count': c,
             'example_args': examples[(n, pc)]['args'],
             'example_extra': examples[(n, pc)].get('extra')}
            for (n, pc), c in site_counts.most_common()
        ],
        'return_counts': [
            {'name': n, 'caller_rva': pc, 'return': ret, 'count': c}
            for (n, pc, ret), c in ret_counts.most_common()
        ],
        'path_tail': d['cac34_path_tail'][-128:],
        'exit_history': (d.get('cac34_exit') or {}).get('history', []),
        'direct_syscalls': d['cac34_direct_syscalls'],
    }


def run_one(lib, out, variant):
    image = base.Image(lib)
    p = VariantProbe(image, out / variant.replace('=', '_'), variant)
    d = p.run_probe()
    return compact_dynamic(d, p.external_returns)


def render(report):
    lines = ['# `libcompatible+0xcac34` condition differential probe', '']
    lines += ['| variant | w0 | bit0 | instructions | unique PCs |',
              '|---|---:|---:|---:|---:|']
    for name, r in report['variants'].items():
        lines.append(f"| `{name}` | `0x{r['gate_w0']:x}` | {r['gate_bit0']} | {r['instruction_count']} | {r['unique_pcs']} |")
    base_r = report['variants']['baseline']
    lines += ['', '## Baseline external API summary', '', '| API | calls |', '|---|---:|']
    for row in base_r['api_counts']:
        lines.append(f"| `{row['name']}` | {row['count']} |")
    lines += ['', '## Baseline external callsites / returns', '',
              '| API | caller RVA | calls | representative return | args x0..x3 |',
              '|---|---:|---:|---:|---|']
    retmap = {}
    for row in base_r['return_counts']:
        retmap.setdefault((row['name'], row['caller_rva']), row['return'])
    for row in base_r['callsite_counts']:
        a = row['example_args']
        ret = retmap.get((row['name'], row['caller_rva']), 0)
        lines.append(f"| `{row['name']}` | `+0x{row['caller_rva']:x}` | {row['count']} | `0x{ret:x}` | "
                     f"`{a[0]:#x}, {a[1]:#x}, {a[2]:#x}, {a[3]:#x}` |")
    lines += ['', '## Baseline path tail', '', '```text']
    lines.append(' '.join(f'+0x{x:x}' if 0 <= x < 0x4000000 else f'0x{x:x}' for x in base_r['path_tail']))
    lines += ['```', '']
    return '\n'.join(lines)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    args.out.mkdir(parents=True, exist_ok=True)

    variants = [
        'baseline',
        'dlsym-resolve-known',
        'sysconf=-1',
        'sysconf=1',
        'sysconf=8',
        'sysconf=64',
        'getauxval=0',
        'getauxval=1',
        'getauxval=0xffffffffffffffff',
    ]
    report = {'variants': {}}
    for v in variants:
        print(f'== {v} ==', flush=True)
        report['variants'][v] = run_one(args.libcompatible, args.out, v)
        print(json.dumps({k: report['variants'][v][k] for k in ('gate_w0','gate_bit0','instruction_count','api_counts')}, indent=2), flush=True)

    (args.out / 'condition-probe.json').write_text(json.dumps(report, indent=2) + '\n')
    (args.out / 'condition-probe.md').write_text(render(report) + '\n')


if __name__ == '__main__':
    main()

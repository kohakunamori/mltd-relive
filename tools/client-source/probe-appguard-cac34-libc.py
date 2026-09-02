#!/usr/bin/env python3
"""Probe libc semantics that are actually exercised by +0xcac34.

The baseline harness intentionally implements only the APIs needed so far.  The
cac34 predicate reaches locale conversion helpers and pthread_once; returning 0
for these calls is not faithful enough to decide the callback branch.  This
probe varies only those observed semantics.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from pathlib import Path

from unicorn.arm64_const import UC_ARM64_REG_PC, UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X30

HERE = Path(__file__).resolve().parent
P = HERE / 'probe-appguard-cac34-conditions.py'
spec = importlib.util.spec_from_file_location('cond_probe', P)
cond = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(cond)
base = cond.base

TRAMPOLINE = base.STUB_BASE + base.STUB_SIZE - 0x100
WEOF = 0xffffffff
EOF = 0xffffffffffffffff


class LibcProbe(cond.VariantProbe):
    def __init__(self, image, out, variant):
        super().__init__(image, out, variant)
        self.once_done = set()
        self.once_return_stack = []
        self.once_invocations = []
        # Mapped already as part of STUB space; contents do not matter because
        # code_hook intercepts before execution.
        self.uc.mem_write(TRAMPOLINE, bytes.fromhex('c0035fd6'))

    @property
    def use_locale(self):
        return self.variant in ('locale-ascii', 'locale+once')

    @property
    def use_once(self):
        return self.variant in ('pthread_once-execute', 'locale+once')

    def code_hook(self, uc, address, size, user):
        if address == TRAMPOLINE and self.once_return_stack:
            ret = self.once_return_stack.pop()
            uc.reg_write(UC_ARM64_REG_X0, 0)
            uc.reg_write(UC_ARM64_REG_PC, ret)
            return
        super().code_hook(uc, address, size, user)

    def emulate_external(self, name, address):
        n = name.split('@', 1)[0]
        x0 = self.uc.reg_read(UC_ARM64_REG_X0)
        x1 = self.uc.reg_read(UC_ARM64_REG_X1)
        xs = [self.uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(8)] if False else None

        if self.use_locale and n == 'btowc':
            c = x0 & 0xffffffff
            ret = c if c <= 0x7f else WEOF
            self._log_override(name, address, [self.uc.reg_read(globals().get(f'UC_ARM64_REG_X{i}', UC_ARM64_REG_X0)) for i in range(8)] if False else [x0, x1, 0, 0, 0, 0, 0, 0], ret,
                               {'model': 'C/UTF-8 single-byte ASCII'})
            return
        if self.use_locale and n == 'wctob':
            wc = x0 & 0xffffffff
            ret = wc if wc <= 0x7f else EOF
            self._log_override(name, address, [x0, x1, 0, 0, 0, 0, 0, 0], ret,
                               {'model': 'ASCII identity, EOF otherwise'})
            return
        if self.use_locale and n == 'wctype':
            prop = self.cstring(x0).decode('ascii', errors='replace') if x0 else ''
            descs = {'alnum':1,'alpha':2,'blank':3,'cntrl':4,'digit':5,'graph':6,'lower':7,
                     'print':8,'punct':9,'space':10,'upper':11,'xdigit':12}
            ret = descs.get(prop, 0)
            self._log_override(name, address, [x0, x1, 0, 0, 0, 0, 0, 0], ret, {'property': prop})
            return
        if self.use_once and n == 'pthread_once':
            control, init = x0, x1
            caller = self.uc.reg_read(UC_ARM64_REG_X30)
            if control in self.once_done:
                self.stub_return(0)
                return
            self.once_done.add(control)
            self.once_return_stack.append(caller)
            self.once_invocations.append({'control': control, 'init': init, 'caller': caller})
            self.uc.reg_write(UC_ARM64_REG_X30, TRAMPOLINE)
            self.uc.reg_write(UC_ARM64_REG_PC, init)
            return
        super().emulate_external(name, address)


def run_one(lib, out, variant):
    image = base.Image(lib)
    p = LibcProbe(image, out / variant.replace('+','_'), variant)
    d = p.run_probe()
    result = cond.compact_dynamic(d, p.external_returns)
    result['pthread_once_invocations'] = p.once_invocations
    result['installer_slots'] = d['installer']['slots']
    return result


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    a = ap.parse_args(); a.out.mkdir(parents=True, exist_ok=True)
    variants = ['baseline', 'locale-ascii', 'pthread_once-execute', 'locale+once']
    report = {'variants': {}}
    for v in variants:
        print('==', v, '==', flush=True)
        try:
            report['variants'][v] = run_one(a.libcompatible, a.out, v)
        except Exception as exc:
            report['variants'][v] = {'error': f'{type(exc).__name__}: {exc}'}
        print(json.dumps(report['variants'][v], indent=2)[:20000], flush=True)
    (a.out/'libc-probe.json').write_text(json.dumps(report, indent=2)+'\n')
    lines = ['# `cac34` libc / pthread_once differential probe','',
             '| variant | w0 | bit0 | instructions | once initializers | error |',
             '|---|---:|---:|---:|---:|---|']
    for v, r in report['variants'].items():
        if 'error' in r:
            lines.append(f'| `{v}` | - | - | - | - | `{r["error"]}` |')
        else:
            lines.append(f'| `{v}` | `0x{r["gate_w0"]:x}` | {r["gate_bit0"]} | {r["instruction_count"]} | {len(r["pthread_once_invocations"])} | |')
    lines += ['', '## pthread_once initializers', '']
    for v, r in report['variants'].items():
        if 'pthread_once_invocations' not in r: continue
        lines.append(f'### `{v}`')
        for x in r['pthread_once_invocations']:
            init = x['init']-base.BIAS if base.BIAS <= x['init'] < base.BIAS+0x4000000 else x['init']
            caller = x['caller']-base.BIAS if base.BIAS <= x['caller'] < base.BIAS+0x4000000 else x['caller']
            lines.append(f'- control `0x{x["control"]:x}` -> init `+0x{init:x}`, caller/return `+0x{caller:x}`')
        lines.append('')
    (a.out/'libc-probe.md').write_text('\n'.join(lines)+'\n')


if __name__ == '__main__': main()

#!/usr/bin/env python3
"""Inspect the three concrete matcher invocations that decide +0xcac34.

The runtime-decrypted top-level predicate creates three decoded strings and
calls +0x15c778 on each.  Capture those strings, argument provenance, return
values, and the relocations behind the third-call callback/global operands.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
P = HERE / 'analyze-appguard-cac34.py'
spec = importlib.util.spec_from_file_location('cac34_analyzer', P)
ana = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(ana)
base = ana.base

MATCHER = 0x15C778
CTOR = 0x15BD84
DECODE_RET_SITES = {0xCACA0: 'candidate_d48', 0xCACE8: 'candidate_e48', 0xCAD30: 'candidate_c48'}
MATCH_RET_SITES = {0xCAD74: 0, 0xCAD94: 1, 0xCADB0: 2}
WATCH_RELOCS = {0x1E5910, 0x1E60D0}


def fmt_addr(v):
    if base.BIAS <= v < base.BIAS + 0x4000000:
        return f'+0x{v-base.BIAS:x}'
    return f'0x{v:x}'


def safe_cstr(e, addr, limit=512):
    try:
        b = e.cstring(addr, limit)
        return {'address': addr, 'text': b.decode('utf-8', errors='backslashreplace'), 'hex': b.hex(), 'length': len(b)}
    except Exception as exc:
        return {'address': addr, 'error': f'{type(exc).__name__}: {exc}'}


class Inspect(ana.Probe):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.decoded = []
        self.matcher_entries = []
        self.matcher_returns = []
        self.ctor_return = None

    def code_hook(self, uc, address, size, user):
        rva = address - base.BIAS if base.BIAS <= address < base.BIAS + 0x4000000 else address
        if self.in_cac34 or rva == ana.CAC34:
            if rva in DECODE_RET_SITES:
                x0 = uc.reg_read(UC_ARM64_REG_X0)
                self.decoded.append({'site': rva, 'name': DECODE_RET_SITES[rva], 'x0': x0, 'cstring': safe_cstr(self, x0)})
            if rva == 0xCAD60:
                self.ctor_return = uc.reg_read(UC_ARM64_REG_X0)
            if rva == MATCHER:
                xs = [uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(4)]
                self.matcher_entries.append({
                    'index': len(self.matcher_entries), 'x0': xs[0], 'x1': xs[1], 'x2': xs[2], 'x3': xs[3],
                    'x0_class': fmt_addr(xs[0]), 'x3_class': fmt_addr(xs[3]), 'candidate': safe_cstr(self, xs[1]),
                })
            if rva in MATCH_RET_SITES:
                self.matcher_returns.append({'index': MATCH_RET_SITES[rva], 'site': rva,
                                             'w0': uc.reg_read(UC_ARM64_REG_W0), 'x0': uc.reg_read(UC_ARM64_REG_X0)})
        super().code_hook(uc, address, size, user)

    def disasm_runtime(self, rva, size):
        md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
        raw = bytes(self.uc.mem_read(base.BIAS+rva, size))
        return [{'rva': i.address, 'bytes': i.bytes.hex(), 'mnemonic': i.mnemonic, 'op_str': i.op_str}
                for i in md.disasm(raw, rva)]


def reloc_row(r):
    s = r.get('symbol') or {}
    return {'offset': r['offset'], 'type': r['type'], 'table': r['table'], 'addend': r['addend'],
            'symbol': s.get('name'), 'symbol_value': s.get('value'), 'symbol_type': s.get('type')}


def render(rep):
    L = ['# `cac34` matcher inputs / returns', '', f"- gate w0: `0x{rep['gate_w0']:x}`", '']
    L += ['## Decoded candidates', '', '| stage | returned pointer | length | text | hex |', '|---|---:|---:|---|---|']
    for x in rep['decoded_candidates']:
        c=x['cstring']; txt=c.get('text','').replace('|','\\|')
        L.append(f"| `{x['name']}` | `{fmt_addr(x['x0'])}` | {c.get('length','-')} | `{txt}` | `{c.get('hex','')}` |")
    L += ['', '## Matcher calls', '', '| # | object | candidate | x2 | x3 | return w0 |', '|---:|---:|---|---:|---:|---:|']
    rets={x['index']:x['w0'] for x in rep['matcher_returns']}
    for x in rep['matcher_entries']:
        txt=x['candidate'].get('text','').replace('|','\\|')
        L.append(f"| {x['index']} | `{fmt_addr(x['x0'])}` | `{txt}` | `0x{x['x2']:x}` | `{fmt_addr(x['x3'])}` | `0x{rets.get(x['index'],0):x}` |")
    L += ['', '## Relocations / runtime values for top-level globals', '', '| slot | relocation | symbol | runtime value |', '|---:|---|---|---:|']
    byoff={x['offset']:x for x in rep['relocations']}
    for off in sorted(WATCH_RELOCS):
        r=byoff.get(off); desc='-' if not r else f"type {r['type']} `{r['table']}`"
        sym='-' if not r else (r.get('symbol') or '-')
        L.append(f"| `+0x{off:x}` | {desc} | `{sym}` | `{fmt_addr(rep['runtime_globals'][f'0x{off:x}'])}` |")
    for name in ('ctor','matcher'):
        L += ['', f'## Runtime disassembly `{name}`', '', '```asm']
        for i in rep[f'{name}_disassembly']:
            L.append(f"0x{i['rva']:x}: {i['bytes']:<8} {i['mnemonic']} {i['op_str']}")
        L += ['```']
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--libcompatible',type=Path,required=True); ap.add_argument('--out',type=Path,required=True)
    a=ap.parse_args(); a.out.mkdir(parents=True,exist_ok=True)
    image=base.Image(a.libcompatible); e=Inspect(image,a.out)
    boot=e.run_bootstrap()
    ctor_dis=e.disasm_runtime(CTOR,0x800); matcher_dis=e.disasm_runtime(MATCHER,0x1000)
    runtime_globals={f'0x{x:x}': ana.readq(e.uc,x) for x in WATCH_RELOCS}
    relocs=[reloc_row(r) for r in image.relas() if r['offset'] in WATCH_RELOCS]
    inst=e.run_installer(); w0=(e.cac_exit or {}).get('w0',0)
    rep={'bootstrap':boot,'installer':inst,'gate_w0':w0,'decoded_candidates':e.decoded,
         'ctor_return':e.ctor_return,'matcher_entries':e.matcher_entries,'matcher_returns':e.matcher_returns,
         'relocations':relocs,'runtime_globals':runtime_globals,'ctor_disassembly':ctor_dis,'matcher_disassembly':matcher_dis}
    (a.out/'predicate-inspection.json').write_text(json.dumps(rep,indent=2)+'\n')
    (a.out/'predicate-inspection.md').write_text(render(rep))
    print(json.dumps({'gate_w0':w0,'decoded':e.decoded,'matcher_entries':e.matcher_entries,
                      'matcher_returns':e.matcher_returns,'relocations':relocs,'runtime_globals':runtime_globals},indent=2))


if __name__=='__main__': main()

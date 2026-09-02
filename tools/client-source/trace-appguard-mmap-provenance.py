#!/usr/bin/env python3
"""Trace mmap/mprotect/munmap provenance through bootstrap -> installer -> JNI.

The minimal emulator currently ignores mmap requested addresses, protections,
and flags and always allocates from a synthetic high arena.  The native ARM64
callback-installer fallback stores small values such as 0x7250 and later calls
them directly.  This probe records the exact mapping requests made by the
sample before that call so we can distinguish a real low/fixed executable map
from an emulator artefact without changing sample semantics.
"""
from __future__ import annotations

import argparse
import importlib.util
import json
from collections import Counter
from pathlib import Path

from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
P = HERE / 'emulate-appguard-callback-installer.py'
spec = importlib.util.spec_from_file_location('cb_installer', P)
cb = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(cb)
base = cb.base

MAP_FIXED = 0x10
MAP_ANONYMOUS = 0x20
MAP_FIXED_NOREPLACE = 0x100000
PROT_EXEC = 0x4
LOW_LIMIT = 0x100000
FALLBACK_MAX = 0x7510


def relpc(pc: int) -> str:
    if base.BIAS <= pc < base.BIAS + 0x4000000:
        return f'+0x{pc-base.BIAS:x}'
    return f'0x{pc:x}'


def mapping_class(addr: int, length: int, prot: int, flags: int) -> dict:
    end = addr + length if addr <= (1 << 63) else addr
    return {
        'requested_low': addr < LOW_LIMIT,
        'covers_fallback_if_honored': addr <= FALLBACK_MAX < end if length else False,
        'fixed': bool(flags & MAP_FIXED),
        'fixed_noreplace': bool(flags & MAP_FIXED_NOREPLACE),
        'anonymous': bool(flags & MAP_ANONYMOUS),
        'executable': bool(prot & PROT_EXEC),
    }


class Trace(cb.E):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.map_events = []
        self._seq = 0

    def _event(self, *, source, name, pc, args, ret=None, before=True):
        row = {
            'seq': self._seq,
            'stage': getattr(self, 'stage', None),
            'source': source,
            'name': name,
            'pc': pc,
            'pc_rel': relpc(pc),
            'args': list(args[:6]),
        }
        if name in ('mmap', 'mmap64') and len(args) >= 4:
            row['mapping'] = mapping_class(args[0], args[1], args[2], args[3])
        if ret is not None:
            row['return'] = ret
            row['return_low'] = ret < LOW_LIMIT
        if before:
            self._seq += 1
            self.map_events.append(row)
            return len(self.map_events) - 1
        return row

    def emulate_external(self, name, address):
        n = name.split('@', 1)[0]
        if n not in ('mmap', 'mmap64', 'mprotect', 'munmap', 'madvise'):
            return super().emulate_external(name, address)
        xs = [self.uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(8)]
        caller = self.uc.reg_read(UC_ARM64_REG_X30)
        idx = self._event(source='plt', name=n, pc=caller-4 if caller >= 4 else caller, args=xs)
        super().emulate_external(name, address)
        ret = self.uc.reg_read(UC_ARM64_REG_X0)
        self.map_events[idx]['return'] = ret
        self.map_events[idx]['return_low'] = ret < LOW_LIMIT

    def syscall_hook(self, uc, intno, user):
        nr = uc.reg_read(UC_ARM64_REG_X8)
        names = {215: 'munmap', 222: 'mmap', 226: 'mprotect'}
        if nr not in names:
            return super().syscall_hook(uc, intno, user)
        xs = [uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(6)]
        pc = uc.reg_read(UC_ARM64_REG_PC)
        idx = self._event(source='svc', name=names[nr], pc=pc, args=xs)
        super().syscall_hook(uc, intno, user)
        ret = uc.reg_read(UC_ARM64_REG_X0)
        self.map_events[idx]['return'] = ret
        self.map_events[idx]['return_low'] = ret < LOW_LIMIT


def render(rep: dict) -> str:
    events = rep['mapping_events']
    L = [
        '# AppGuard mapping provenance before fallback callback', '',
        f"- bootstrap: `{rep['bootstrap'].get('stop')}`",
        f"- installer: `{rep['installer'].get('stop')}`",
        f"- JNI: `{rep['jni'].get('stop')}`",
        f"- mapping/protection events: **{len(events)}**",
        f"- mmap events: **{sum(1 for x in events if x['name'] in ('mmap','mmap64'))}**",
        f"- requested low mmap: **{sum(1 for x in events if x.get('mapping',{}).get('requested_low'))}**",
        f"- fixed mmap: **{sum(1 for x in events if x.get('mapping',{}).get('fixed') or x.get('mapping',{}).get('fixed_noreplace'))}**",
        f"- executable mmap: **{sum(1 for x in events if x.get('mapping',{}).get('executable'))}**",
        f"- mappings that would cover `0x7250` if request were honored: **{sum(1 for x in events if x.get('mapping',{}).get('covers_fallback_if_honored'))}**",
        '',
        '## mmap requests', '',
        '| # | stage | source | callsite | requested | len | prot | flags | returned | low | fixed | exec | covers 0x7250 |',
        '|---:|---|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|',
    ]
    for x in events:
        if x['name'] not in ('mmap','mmap64'):
            continue
        a=x['args']; m=x.get('mapping',{})
        L.append(
            f"| {x['seq']} | `{x['stage']}` | `{x['source']}` | `{x['pc_rel']}` | `0x{a[0]:x}` | `0x{a[1]:x}` | "
            f"`0x{a[2]:x}` | `0x{a[3]:x}` | `0x{x.get('return',0):x}` | {m.get('requested_low')} | "
            f"{m.get('fixed') or m.get('fixed_noreplace')} | {m.get('executable')} | {m.get('covers_fallback_if_honored')} |"
        )
    L += ['', '## mprotect / munmap / madvise', '',
          '| # | stage | API | callsite | x0 | x1 | x2 | x3 | return |',
          '|---:|---|---|---:|---:|---:|---:|---:|---:|']
    for x in events:
        if x['name'] in ('mmap','mmap64'):
            continue
        a=x['args'] + [0]*6
        L.append(f"| {x['seq']} | `{x['stage']}` | `{x['name']}` | `{x['pc_rel']}` | `0x{a[0]:x}` | `0x{a[1]:x}` | `0x{a[2]:x}` | `0x{a[3]:x}` | `0x{x.get('return',0):x}` |")
    L += ['', '## Callback slots after installer', '', '| slot | value |', '|---:|---:|']
    for k,v in rep['installer']['slots'].items():
        L.append(f'| `{k}` | `0x{v:x}` |')
    return '\n'.join(L) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    a = ap.parse_args(); a.out.mkdir(parents=True, exist_ok=True)

    e = Trace(base.Image(a.libcompatible), a.out)
    boot = e.run_bootstrap()
    inst = e.run_installer()
    pre = [cb.mod.decrypt_range(e, r) for r in cb.mod.RANGES]
    jni = e.run_jni()

    rep = {
        'bootstrap': boot,
        'installer': inst,
        'predecrypted_ranges': pre,
        'jni': jni,
        'mapping_events': e.map_events,
    }
    (a.out/'mmap-provenance.json').write_text(json.dumps(rep, indent=2)+'\n')
    (a.out/'mmap-provenance.md').write_text(render(rep))

    mmaps = [x for x in e.map_events if x['name'] in ('mmap','mmap64')]
    print(json.dumps({
        'jni_stop': jni['stop'],
        'mmap_count': len(mmaps),
        'low_requests': [x for x in mmaps if x.get('mapping',{}).get('requested_low')],
        'fixed_requests': [x for x in mmaps if x.get('mapping',{}).get('fixed') or x.get('mapping',{}).get('fixed_noreplace')],
        'cover_7250': [x for x in mmaps if x.get('mapping',{}).get('covers_fallback_if_honored')],
    }, indent=2))


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""Execute the exact AppGuard libcompatible -> libstub loader stage.

This harness first runs libcompatible DT_INIT with the Bionic PRNG model until
asmFunction[0x98/0xa0] installs the recovered loader callback.  It then maps the
full raw official libstub image at a second module bias, applies Android-linker-
like RELA/JUMP_SLOT relocations (preempting libstub's encrypted weak
SoLibraryStart with libcompatible's strong export), and calls the real
libcompatible SoLibraryStart with the argument proven by libstub DT_INIT:

    x0 = LIBSTUB_BASE + 0x16000

The result records modifications of the protected libstub bytes, loader-related
external calls, anonymous/heap ELF magic, and the encrypted weak symbol region.
"""
from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import struct
from collections import Counter
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn import UcError, UC_HOOK_MEM_WRITE
from unicorn.arm64_const import (
    UC_ARM64_REG_PC, UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2,
    UC_ARM64_REG_X3, UC_ARM64_REG_X4, UC_ARM64_REG_X5, UC_ARM64_REG_X6,
    UC_ARM64_REG_X7, UC_ARM64_REG_X30,
)

HERE = Path(__file__).resolve().parent
BIONIC_PATH = HERE / 'emulate-appguard-dt-init-bionic.py'
spec = importlib.util.spec_from_file_location('appguard_bionic', BIONIC_PATH)
bionic = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(bionic)
base = bionic.base
fast = bionic.mod

LIBSTUB_BASE = 0x20000000
SOLIBRARY_START = 0xC0D64
CALLBACK_DONE = fast.LOADER_CALLBACK_WRITE_DONE
STUB_CONFIG_OFFSET = 0x16000
STUB_WEAK_SOLIBRARY = 0x8C63C
STUB_SOLIBRARY_GOT = 0x41E70
STAGE2_LIMIT = 8_000_000


def align_up(x: int, a: int = 0x1000) -> int:
    return (x + a - 1) & ~(a - 1)


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def compress_ranges(offsets: list[int], limit: int = 1000) -> list[dict]:
    if not offsets:
        return []
    out = []
    start = prev = offsets[0]
    for x in offsets[1:]:
        if x == prev + 1:
            prev = x
            continue
        out.append({'start': start, 'end': prev + 1, 'size': prev + 1 - start})
        if len(out) >= limit:
            return out
        start = prev = x
    out.append({'start': start, 'end': prev + 1, 'size': prev + 1 - start})
    return out[:limit]


def decode_probe(data: bytes, address: int) -> dict:
    md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
    rows = []
    valid = 0
    for off in range(0, min(len(data), 0x180) - 3, 4):
        ds = list(md.disasm(data[off:off+4], address + off, count=1))
        if ds:
            valid += 1
            rows.append({'address': address + off, 'mnemonic': ds[0].mnemonic, 'op_str': ds[0].op_str})
        else:
            rows.append({'address': address + off, 'mnemonic': '.word', 'op_str': f'0x{int.from_bytes(data[off:off+4], "little"):08x}'})
    return {'sha256': sha256_bytes(data), 'hex': data.hex(), 'valid_words': valid, 'rows': rows}


class CrossLoader(bionic.BionicEmulator):
    def __init__(self, compatible: Path, stub: Path, out: Path):
        self.stub_path = stub
        self.stub_raw = stub.read_bytes()
        self.stub_image = base.Image(stub)
        self.stub_extent = max(
            len(self.stub_raw),
            max((s['vaddr'] + s['memsz'] for s in self.stub_image.loads), default=0),
        )
        self.stub_map_size = align_up(self.stub_extent + 0x10000)
        self.stage = 'bootstrap'
        self.stage2_insns = 0
        self.stage2_writes = 0
        self.stage2_write_pages = Counter()
        self.stage2_write_samples = []
        self.stage1_result = None
        super().__init__(base.Image(compatible), out)

    def code_hook(self, uc, address, size, user):
        if self.stage == 'bootstrap':
            super().code_hook(uc, address, size, user)
            rel = address - base.BIAS
            if rel == CALLBACK_DONE and self.callback_captured:
                self.stopped_reason = 'libcompatible loader callback ready'
                uc.emu_stop()
            return

        # Stage 2 still needs the exact Fibonacci shortcut/external stub dispatch
        # inherited from BionicEmulator/FastEmulator, but use an independent limit.
        self.stage2_insns += 1
        if self.stage2_insns > STAGE2_LIMIT:
            self.stopped_reason = f'libstub stage instruction limit {STAGE2_LIMIT}'
            uc.emu_stop()
            return
        super().code_hook(uc, address, size, user)

    def stub_write_hook(self, uc, access, address, size, value, user):
        if not (LIBSTUB_BASE <= address < LIBSTUB_BASE + self.stub_map_size):
            return
        rel = address - LIBSTUB_BASE
        self.stage2_writes += 1
        self.stage2_write_pages[rel >> 12] += 1
        if len(self.stage2_write_samples) < 4096:
            self.stage2_write_samples.append({'offset': rel, 'size': size, 'value': value, 'pc': uc.reg_read(UC_ARM64_REG_PC)})

    def bootstrap(self):
        # run_fast installs code/syscall/invalid hooks and leaves the initialized
        # Unicorn instance alive when our callback checkpoint stops execution.
        result = self.run_bionic()
        self.stage1_result = result
        if not self.callback_captured:
            raise RuntimeError(f'bootstrap did not install loader callback: {result.get("stop")}')
        table = result['snapshots'][-1].get('asmfunction_table') if result.get('snapshots') else None
        return result, table

    def map_libstub(self):
        self.uc.mem_map(LIBSTUB_BASE, self.stub_map_size, base.UC_PROT_ALL)
        self.uc.mem_write(LIBSTUB_BASE, self.stub_raw)
        # Ensure libstub's real JUMP_SLOT resolves to the strong libcompatible symbol.
        self.uc.mem_write(LIBSTUB_BASE + STUB_SOLIBRARY_GOT, struct.pack('<Q', base.BIAS + SOLIBRARY_START))

    def apply_libstub_relocations(self):
        rows = []
        for r in self.stub_image.relas():
            typ = r['type']
            sym = r['symbol']
            dest = LIBSTUB_BASE + r['offset']
            value = None
            kind = None
            name = sym.get('name') or ''
            if name == 'SoLibraryStart':
                value = base.BIAS + SOLIBRARY_START
                kind = 'preempted-by-libcompatible'
            elif typ == base.R_AARCH64_RELATIVE:
                value = LIBSTUB_BASE + r['addend']
                kind = 'relative'
            elif typ in (base.R_AARCH64_ABS64, base.R_AARCH64_GLOB_DAT, base.R_AARCH64_JUMP_SLOT):
                if sym.get('value'):
                    value = LIBSTUB_BASE + sym['value'] + r['addend']
                    kind = 'internal-symbol'
                elif sym.get('type') == base.STT_OBJECT:
                    value = self.alloc_extdata(name or f'stub_object_{sym["index"]}') + r['addend']
                    kind = 'external-object'
                else:
                    value = self.alloc_stub(name or f'stub_func_{sym["index"]}') + r['addend']
                    kind = 'external-function'
            elif typ == base.R_AARCH64_IRELATIVE:
                value = LIBSTUB_BASE + r['addend']
                kind = 'irelative-resolver'
            if value is None:
                continue
            try:
                self.uc.mem_write(dest, struct.pack('<Q', value & 0xffffffffffffffff))
                rows.append({'offset': r['offset'], 'type': typ, 'symbol': name, 'value': value, 'kind': kind})
            except UcError:
                rows.append({'offset': r['offset'], 'type': typ, 'symbol': name, 'value': value, 'kind': kind, 'write_failed': True})
        return rows

    def arena_magic(self):
        needles = {'ELF': b'\x7fELF', 'metadata': bytes.fromhex('af1bb1fa')}
        regions = []
        candidates = [
            ('heap', base.HEAP_BASE + 0x1000, max(base.HEAP_BASE + 0x1000, self.heap_next)),
            ('mmap', base.MMAP_BASE + 0x1000, max(base.MMAP_BASE + 0x1000, self.mmap_next)),
            ('libstub', LIBSTUB_BASE, LIBSTUB_BASE + self.stub_map_size),
        ]
        for name, lo, hi in candidates:
            size = hi - lo
            if size <= 0 or size > 0x08000000:
                continue
            try:
                data = bytes(self.uc.mem_read(lo, size))
            except UcError:
                continue
            hits = {}
            for needle_name, needle in needles.items():
                poss = []
                p = data.find(needle)
                while p >= 0 and len(poss) < 128:
                    poss.append(p)
                    p = data.find(needle, p + 1)
                hits[needle_name] = poss
            regions.append({'name': name, 'base': lo, 'size': size, 'hits': hits})
        return regions

    def enrich_calls(self, calls):
        rows = []
        path_x0 = {'dlopen', 'open', 'open64', 'fopen', 'opendir'}
        path_x1 = {'openat'}
        symbol_x1 = {'dlsym'}
        for c in calls:
            row = dict(c)
            n = c['name'].split('@', 1)[0]
            args = c.get('args') or []
            ptr = None
            if n in path_x0 and len(args) > 0:
                ptr = args[0]
            elif n in path_x1 and len(args) > 1:
                ptr = args[1]
            elif n in symbol_x1 and len(args) > 1:
                ptr = args[1]
            if ptr:
                try:
                    row['string_arg'] = self.cstring(ptr, 512).decode('utf-8', errors='replace')
                except Exception:
                    pass
            rows.append(row)
        return rows

    def run_libstub_stage(self):
        before = bytes(self.uc.mem_read(LIBSTUB_BASE, len(self.stub_raw)))
        probe_lo = LIBSTUB_BASE + STUB_WEAK_SOLIBRARY
        probe_before = bytes(self.uc.mem_read(probe_lo, 0x180))
        call_start = len(self.calls)
        svc_start = len(getattr(self, 'svc_calls', []))

        self.stage = 'libstub'
        self.stage2_insns = 0
        self.insns = 0  # keep inherited limiter from firing on stage-1 count
        self.stopped_reason = None
        self.uc.hook_add(UC_HOOK_MEM_WRITE, self.stub_write_hook)
        # Arguments not proven by DT_INIT are cleared rather than leaking bootstrap state.
        regs = [UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X3, UC_ARM64_REG_X4, UC_ARM64_REG_X5, UC_ARM64_REG_X6, UC_ARM64_REG_X7]
        for r in regs:
            self.uc.reg_write(r, 0)
        self.uc.reg_write(UC_ARM64_REG_X0, LIBSTUB_BASE + STUB_CONFIG_OFFSET)
        self.uc.reg_write(UC_ARM64_REG_X30, base.STOP_ADDR)
        try:
            self.uc.emu_start(base.BIAS + SOLIBRARY_START, base.STOP_ADDR, count=STAGE2_LIMIT + 1000)
        except UcError as exc:
            if self.stopped_reason is None:
                self.stopped_reason = f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'

        after = bytes(self.uc.mem_read(LIBSTUB_BASE, len(self.stub_raw)))
        probe_after = bytes(self.uc.mem_read(probe_lo, 0x180))
        diff_offsets = [i for i, (a, b) in enumerate(zip(before, after)) if a != b]
        page_counts = Counter(i >> 12 for i in diff_offsets)
        stage_calls = self.enrich_calls(self.calls[call_start:])
        stage_svcs = getattr(self, 'svc_calls', [])[svc_start:]
        return {
            'stop': self.stopped_reason,
            'instructions': self.stage2_insns,
            'pc': self.uc.reg_read(UC_ARM64_REG_PC),
            'stub_base': LIBSTUB_BASE,
            'stub_config_ptr': LIBSTUB_BASE + STUB_CONFIG_OFFSET,
            'stub_size': len(self.stub_raw),
            'stub_extent': self.stub_extent,
            'writes_observed': self.stage2_writes,
            'write_pages': [{'page': p, 'offset': p << 12, 'writes': n} for p, n in page_counts.most_common(256)],
            'write_samples': self.stage2_write_samples[:512],
            'diff_bytes': len(diff_offsets),
            'diff_ranges': compress_ranges(diff_offsets),
            'probe_before': decode_probe(probe_before, STUB_WEAK_SOLIBRARY),
            'probe_after': decode_probe(probe_after, STUB_WEAK_SOLIBRARY),
            'external_calls': stage_calls,
            'direct_syscalls': stage_svcs,
            'invalid_memory_tail': self.invalid_memory[-64:],
            'arena_magic': self.arena_magic(),
        }


def render_md(rep):
    s1 = rep['bootstrap']
    s2 = rep['libstub_stage']
    L = [
        '# Cross-library AppGuard `libcompatible -> libstub` emulation', '',
        f"- libcompatible bootstrap stop: `{s1.get('stop')}`",
        f"- callback captured: **{s1.get('callback_captured')}**",
        f"- libstub stage stop: `{s2['stop']}`",
        f"- libstub stage instructions: **{s2['instructions']}**",
        f"- libstub bytes changed: **{s2['diff_bytes']}**",
        f"- observed libstub writes: **{s2['writes_observed']}**", '',
        '## Proven entry', '',
        f"- `SoLibraryStart = libcompatible+0x{SOLIBRARY_START:x}`",
        f"- `x0 = libstub+0x{STUB_CONFIG_OFFSET:x}` = `0x{s2['stub_config_ptr']:x}`",
        f"- libstub `JUMP_SLOT[SoLibraryStart] = 0x{LIBSTUB_BASE + STUB_SOLIBRARY_GOT:x}` -> `0x{base.BIAS + SOLIBRARY_START:x}`", '',
        '## Encrypted weak `SoLibraryStart` probe', '',
        f"- before SHA-256: `{s2['probe_before']['sha256']}`; valid words: {s2['probe_before']['valid_words']}",
        f"- after SHA-256: `{s2['probe_after']['sha256']}`; valid words: {s2['probe_after']['valid_words']}",
        f"- changed: **{s2['probe_before']['sha256'] != s2['probe_after']['sha256']}**", '',
        '## Modified libstub ranges', '',
        '| Start | End | Size |', '|---:|---:|---:|',
    ]
    for r in s2['diff_ranges'][:300]:
        L.append(f"| `0x{r['start']:x}` | `0x{r['end']:x}` | {r['size']} |")
    if not s2['diff_ranges']:
        L.append('| - | - | 0 |')
    L += ['', '## Loader-related/external calls', '', '| API | Args | String arg |', '|---|---|---|']
    for c in s2['external_calls'][:500]:
        args = ', '.join(f'0x{x:x}' for x in (c.get('args') or [])[:6])
        string = (c.get('string_arg') or '').replace('|', '\\|')
        L.append(f"| `{c['name']}` | `{args}` | `{string}` |")
    if not s2['external_calls']:
        L.append('| - | - | - |')
    L += ['', '## ELF / metadata magic after stage', '', '| Region | Size | ELF offsets | metadata offsets |', '|---|---:|---|---|']
    for r in s2['arena_magic']:
        elf = ', '.join(f'0x{x:x}' for x in r['hits']['ELF'][:32]) or '-'
        meta = ', '.join(f'0x{x:x}' for x in r['hits']['metadata'][:32]) or '-'
        L.append(f"| `{r['name']}` | {r['size']} | {elf} | {meta} |")
    if s2['invalid_memory_tail']:
        L += ['', '## Last invalid memory accesses', '', '```json', json.dumps(s2['invalid_memory_tail'], indent=2), '```']
    return '\n'.join(L) + '\n'


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--libstub', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    args.out.mkdir(parents=True, exist_ok=True)

    em = CrossLoader(args.libcompatible, args.libstub, args.out)
    bootstrap, table = em.bootstrap()
    em.map_libstub()
    stub_relocs = em.apply_libstub_relocations()
    stage = em.run_libstub_stage()
    result = {
        'inputs': {
            'libcompatible_sha256': hashlib.sha256(args.libcompatible.read_bytes()).hexdigest(),
            'libstub_sha256': hashlib.sha256(args.libstub.read_bytes()).hexdigest(),
        },
        'bootstrap': {
            'stop': bootstrap.get('stop'),
            'instructions': bootstrap.get('instructions'),
            'callback_captured': bootstrap.get('callback_captured'),
            'rand_calls': len(bootstrap.get('rand_calls', [])),
            'last_asmfunction_98_a0': (table[19:21] if table and len(table) >= 21 else None),
        },
        'libstub_relocations_applied': stub_relocs,
        'libstub_stage': stage,
    }
    (args.out/'libstub-stage.json').write_text(json.dumps(result, indent=2) + '\n')
    (args.out/'libstub-stage.md').write_text(render_md(result))
    print(json.dumps({
        'bootstrap_callback': result['bootstrap']['callback_captured'],
        'stage_stop': stage['stop'],
        'stage_instructions': stage['instructions'],
        'diff_bytes': stage['diff_bytes'],
        'weak_symbol_changed': stage['probe_before']['sha256'] != stage['probe_after']['sha256'],
        'external_calls': [x['name'] for x in stage['external_calls'][-20:]],
        'arena_magic': stage['arena_magic'],
    }, indent=2))


if __name__ == '__main__':
    main()

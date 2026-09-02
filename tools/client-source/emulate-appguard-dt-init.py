#!/usr/bin/env python3
"""Minimally execute the exact MLTD 2.1.000 AppGuard DT_INIT bootstrap.

This is deliberately *not* a general Android emulator.  It loads libcompatible.so
at a fixed PIE bias, applies the dynamic relocations needed by the bootstrap,
stubs the small libc surface reached during startup, and snapshots AppGuard's
runtime-generated 0x1070 code/config buffer plus the 21-entry asmFunction table.

The goal is to cross the static-analysis boundary around the self-modifying RWX
trampoline builder without requiring a device or executing the game itself.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import struct
from pathlib import Path

from elftools.elf.dynamic import DynamicSegment
from elftools.elf.elffile import ELFFile
from unicorn import Uc, UcError, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE, UC_HOOK_MEM_INVALID, UC_PROT_ALL
from unicorn.arm64_const import *

BIAS = 0x10000000
STACK_BASE = 0x7000000000
STACK_SIZE = 0x01000000
TLS_BASE = 0x7100000000
TLS_SIZE = 0x10000
HEAP_BASE = 0x5000000000
HEAP_SIZE = 0x04000000
MMAP_BASE = 0x5100000000
MMAP_SIZE = 0x04000000
STUB_BASE = 0x6000000000
STUB_SIZE = 0x00200000
EXTDATA_BASE = 0x6100000000
EXTDATA_SIZE = 0x00200000
STOP_ADDR = 0x6200000000
PAGE = 0x1000
MAX_INSNS = 4_000_000

R_AARCH64_ABS64 = 257
R_AARCH64_GLOB_DAT = 1025
R_AARCH64_JUMP_SLOT = 1026
R_AARCH64_RELATIVE = 1027
R_AARCH64_IRELATIVE = 1032
STT_OBJECT = 1
STT_FUNC = 2


def align_down(x: int, a: int = PAGE) -> int:
    return x & ~(a - 1)


def align_up(x: int, a: int = PAGE) -> int:
    return (x + a - 1) & ~(a - 1)


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for b in iter(lambda: f.read(1 << 20), b''):
            h.update(b)
    return h.hexdigest()


class Image:
    def __init__(self, path: Path):
        self.path = path
        self.loads = []
        self.dynamic = {}
        with path.open('rb') as f:
            elf = ELFFile(f)
            self.entry = int(elf['e_entry'])
            for seg in elf.iter_segments():
                if str(seg['p_type']) == 'PT_LOAD':
                    self.loads.append({
                        'vaddr': int(seg['p_vaddr']),
                        'offset': int(seg['p_offset']),
                        'filesz': int(seg['p_filesz']),
                        'memsz': int(seg['p_memsz']),
                        'data': seg.data(),
                    })
                if isinstance(seg, DynamicSegment) or str(seg['p_type']) == 'PT_DYNAMIC':
                    try:
                        for tag in seg.iter_tags():
                            k = str(tag.entry.d_tag)
                            v = getattr(tag.entry, 'd_val', None)
                            if v is None:
                                v = getattr(tag.entry, 'd_ptr', None)
                            if v is not None:
                                self.dynamic[k] = int(v)
                    except Exception:
                        pass
        self.dt_init = self.dynamic.get('DT_INIT')

    def read_file_va(self, va: int, n: int) -> bytes:
        for s in self.loads:
            if s['vaddr'] <= va and va + n <= s['vaddr'] + s['filesz']:
                o = va - s['vaddr']
                return s['data'][o:o+n]
        return b''

    def cstr(self, va: int, limit: int = 512) -> str:
        b = self.read_file_va(va, limit)
        if not b:
            return ''
        try:
            return b.split(b'\0', 1)[0].decode('utf-8', errors='replace')
        except Exception:
            return ''

    def dynsym(self, idx: int) -> dict:
        st = self.dynamic.get('DT_SYMTAB')
        ss = self.dynamic.get('DT_SYMENT', 24)
        strings = self.dynamic.get('DT_STRTAB')
        if st is None or strings is None:
            return {'index': idx, 'name': '', 'value': 0, 'size': 0, 'type': 0, 'shndx': 0}
        b = self.read_file_va(st + idx * ss, 24)
        if len(b) != 24:
            return {'index': idx, 'name': '', 'value': 0, 'size': 0, 'type': 0, 'shndx': 0}
        st_name, st_info, st_other, st_shndx, st_value, st_size = struct.unpack('<IBBHQQ', b)
        return {
            'index': idx,
            'name': self.cstr(strings + st_name),
            'value': st_value,
            'size': st_size,
            'type': st_info & 0xf,
            'bind': st_info >> 4,
            'shndx': st_shndx,
        }

    def relas(self) -> list[dict]:
        rows = []
        for base_tag, size_tag, table in (
            ('DT_RELA', 'DT_RELASZ', 'RELA'),
            ('DT_JMPREL', 'DT_PLTRELSZ', 'JMPREL'),
        ):
            base = self.dynamic.get(base_tag)
            size = self.dynamic.get(size_tag)
            ent = self.dynamic.get('DT_RELAENT', 24)
            if base is None or size is None:
                continue
            for off in range(0, size, ent):
                b = self.read_file_va(base + off, 24)
                if len(b) != 24:
                    break
                r_offset, r_info, r_addend = struct.unpack('<QQq', b)
                sym_idx = r_info >> 32
                r_type = r_info & 0xffffffff
                rows.append({
                    'table': table,
                    'rela_va': base + off,
                    'offset': r_offset,
                    'type': r_type,
                    'addend': r_addend,
                    'symbol': self.dynsym(sym_idx),
                })
        return rows


class BootstrapEmulator:
    def __init__(self, image: Image, out: Path):
        self.image = image
        self.out = out
        self.uc = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
        self.heap_next = HEAP_BASE + 0x1000
        self.mmap_next = MMAP_BASE + 0x1000
        self.stub_next = STUB_BASE + 0x1000
        self.extdata_next = EXTDATA_BASE + 0x1000
        self.stub_by_name: dict[str, int] = {}
        self.name_by_stub: dict[int, str] = {}
        self.extdata_by_name: dict[str, int] = {}
        self.calls = []
        self.snapshots = []
        self.forced_edges = []
        self.invalid_memory = []
        self.insns = 0
        self.stopped_reason = None
        self.current_config_ptr = None
        self.current_rwx_ptr = None

    def map_memory(self):
        lo = min(align_down(s['vaddr']) for s in self.image.loads)
        hi = max(align_up(s['vaddr'] + s['memsz']) for s in self.image.loads)
        self.uc.mem_map(BIAS + lo, hi - lo, UC_PROT_ALL)
        for s in self.image.loads:
            if s['data']:
                self.uc.mem_write(BIAS + s['vaddr'], s['data'])
        self.uc.mem_map(STACK_BASE, STACK_SIZE, UC_PROT_ALL)
        self.uc.mem_map(TLS_BASE, TLS_SIZE, UC_PROT_ALL)
        self.uc.mem_map(HEAP_BASE, HEAP_SIZE, UC_PROT_ALL)
        self.uc.mem_map(MMAP_BASE, MMAP_SIZE, UC_PROT_ALL)
        self.uc.mem_map(STUB_BASE, STUB_SIZE, UC_PROT_ALL)
        self.uc.mem_map(EXTDATA_BASE, EXTDATA_SIZE, UC_PROT_ALL)
        self.uc.mem_map(STOP_ADDR, PAGE, UC_PROT_ALL)
        # RET at STOP_ADDR is not normally executed; the code hook stops first.
        self.uc.mem_write(STOP_ADDR, bytes.fromhex('c0035fd6'))
        # Defensive low page in case this Unicorn build returns zero for TPIDR_EL0.
        try:
            self.uc.mem_map(0, PAGE, UC_PROT_ALL)
        except UcError:
            pass
        try:
            self.uc.mem_write(0x28, struct.pack('<Q', 0x6d6c746472656c76))
        except UcError:
            pass
        self.uc.mem_write(TLS_BASE + 0x28, struct.pack('<Q', 0x6d6c746472656c76))

    def alloc_stub(self, name: str) -> int:
        if name in self.stub_by_name:
            return self.stub_by_name[name]
        addr = self.stub_next
        self.stub_next += 0x10
        if self.stub_next >= STUB_BASE + STUB_SIZE:
            raise RuntimeError('external stub space exhausted')
        self.uc.mem_write(addr, bytes.fromhex('c0035fd6') + b'\0' * 12)
        self.stub_by_name[name] = addr
        self.name_by_stub[addr] = name
        return addr

    def alloc_extdata(self, name: str, size: int = 0x100) -> int:
        if name in self.extdata_by_name:
            return self.extdata_by_name[name]
        addr = align_up(self.extdata_next, 16)
        self.extdata_next = addr + align_up(size, 16)
        self.extdata_by_name[name] = addr
        # environ should look like a pointer to a NULL pointer array.
        if name == 'environ':
            envp = addr + 0x20
            self.uc.mem_write(addr, struct.pack('<Q', envp))
            self.uc.mem_write(envp, struct.pack('<Q', 0))
        elif 'stack_chk_guard' in name:
            self.uc.mem_write(addr, struct.pack('<Q', 0x6d6c746472656c76))
        else:
            self.uc.mem_write(addr, b'\0' * min(size, 0x1000))
        return addr

    def apply_relocations(self):
        applied = []
        for r in self.image.relas():
            typ = r['type']
            sym = r['symbol']
            dest = BIAS + r['offset']
            value = None
            kind = None
            if typ == R_AARCH64_RELATIVE:
                value = BIAS + r['addend']
                kind = 'relative'
            elif typ in (R_AARCH64_ABS64, R_AARCH64_GLOB_DAT, R_AARCH64_JUMP_SLOT):
                if sym.get('value'):
                    value = BIAS + sym['value'] + r['addend']
                    kind = 'internal-symbol'
                elif sym.get('type') == STT_OBJECT:
                    value = self.alloc_extdata(sym.get('name') or f'object_{sym["index"]}') + r['addend']
                    kind = 'external-object'
                else:
                    value = self.alloc_stub(sym.get('name') or f'func_{sym["index"]}') + r['addend']
                    kind = 'external-function'
            elif typ == R_AARCH64_IRELATIVE:
                # Retain the resolver address. If the bootstrap actually calls it, Unicorn
                # will execute the internal resolver rather than an invented return value.
                value = BIAS + r['addend']
                kind = 'irelative-resolver'
            if value is not None:
                try:
                    self.uc.mem_write(dest, struct.pack('<Q', value & 0xffffffffffffffff))
                    applied.append({
                        'offset': r['offset'], 'type': typ, 'symbol': sym.get('name'),
                        'symbol_type': sym.get('type'), 'value': value, 'kind': kind,
                    })
                except UcError:
                    pass
        return applied

    def setup_registers(self):
        sp = STACK_BASE + STACK_SIZE - 0x2000
        self.uc.reg_write(UC_ARM64_REG_SP, sp)
        self.uc.reg_write(UC_ARM64_REG_X29, sp)
        self.uc.reg_write(UC_ARM64_REG_X30, STOP_ADDR)
        try:
            self.uc.reg_write(UC_ARM64_REG_TPIDR_EL0, TLS_BASE)
        except Exception:
            pass

    def qword(self, addr: int) -> int | None:
        try:
            return struct.unpack('<Q', bytes(self.uc.mem_read(addr, 8)))[0]
        except UcError:
            return None

    def cstring(self, addr: int, limit: int = 4096) -> bytes:
        if not addr:
            return b''
        out = bytearray()
        for i in range(limit):
            try:
                b = bytes(self.uc.mem_read(addr + i, 1))[0]
            except UcError:
                break
            if b == 0:
                break
            out.append(b)
        return bytes(out)

    def alloc_heap(self, n: int, zero: bool = True) -> int:
        n = max(1, int(n))
        addr = align_up(self.heap_next, 16)
        self.heap_next = addr + align_up(n, 16)
        if self.heap_next >= HEAP_BASE + HEAP_SIZE:
            raise RuntimeError('heap exhausted')
        if zero:
            self.uc.mem_write(addr, b'\0' * n)
        return addr

    def alloc_mmap(self, n: int) -> int:
        n = align_up(max(PAGE, int(n)), PAGE)
        addr = align_up(self.mmap_next, PAGE)
        self.mmap_next = addr + n
        if self.mmap_next >= MMAP_BASE + MMAP_SIZE:
            raise RuntimeError('mmap arena exhausted')
        self.uc.mem_write(addr, b'\0' * min(n, 0x100000))
        self.current_rwx_ptr = addr
        return addr

    def stub_return(self, value: int = 0):
        self.uc.reg_write(UC_ARM64_REG_X0, value & 0xffffffffffffffff)
        self.uc.reg_write(UC_ARM64_REG_PC, self.uc.reg_read(UC_ARM64_REG_X30))

    def emulate_external(self, name: str, address: int):
        xs = [self.uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(8)]
        self.calls.append({'pc': address, 'name': name, 'args': xs})
        n = name.split('@', 1)[0]
        try:
            if n == 'calloc':
                self.stub_return(self.alloc_heap(xs[0] * xs[1], True)); return
            if n in ('malloc', '_Znwm', '_Znwj'):
                self.stub_return(self.alloc_heap(xs[0], False)); return
            if n == 'realloc':
                new = self.alloc_heap(xs[1], False)
                if xs[0] and xs[1]:
                    try: self.uc.mem_write(new, bytes(self.uc.mem_read(xs[0], min(xs[1], 0x100000))))
                    except UcError: pass
                self.stub_return(new); return
            if n in ('free', '_ZdlPv', '_ZdaPv'):
                self.stub_return(0); return
            if n in ('mmap', 'mmap64'):
                self.stub_return(self.alloc_mmap(xs[1])); return
            if n == 'munmap':
                self.stub_return(0); return
            if n == 'mprotect':
                self.stub_return(0); return
            if n in ('memcpy', 'memmove', '__memcpy_chk', '__memmove_chk'):
                size = xs[2]
                if size > 0x2000000: raise RuntimeError(f'implausible {n} size {size:#x}')
                data = bytes(self.uc.mem_read(xs[1], size))
                self.uc.mem_write(xs[0], data)
                self.stub_return(xs[0]); return
            if n in ('memset', '__memset_chk'):
                size = xs[2]
                if size > 0x2000000: raise RuntimeError(f'implausible memset size {size:#x}')
                self.uc.mem_write(xs[0], bytes([xs[1] & 0xff]) * size)
                self.stub_return(xs[0]); return
            if n == 'memcmp':
                a = bytes(self.uc.mem_read(xs[0], xs[2])); b = bytes(self.uc.mem_read(xs[1], xs[2]))
                self.stub_return((a > b) - (a < b)); return
            if n in ('strlen', 'strnlen'):
                s = self.cstring(xs[0], min(xs[1], 4096) if n == 'strnlen' else 4096)
                self.stub_return(len(s)); return
            if n in ('strcmp', 'strncmp'):
                lim = xs[2] if n == 'strncmp' else 4096
                a = self.cstring(xs[0], lim); b = self.cstring(xs[1], lim)
                self.stub_return((a > b) - (a < b)); return
            if n == 'getpagesize':
                self.stub_return(PAGE); return
            if n == 'sysconf':
                self.stub_return(PAGE); return
            if n in ('__errno', '__errno_location'):
                self.stub_return(EXTDATA_BASE + 0x80); return
            if n in ('getpid', 'getppid', 'getuid', 'geteuid', 'getgid', 'getegid', 'gettid'):
                self.stub_return(1000); return
            if n in ('pthread_mutex_init','pthread_mutex_lock','pthread_mutex_unlock','pthread_mutex_destroy',
                     'pthread_cond_init','pthread_cond_destroy','pthread_cond_signal','pthread_cond_broadcast',
                     'pthread_rwlock_init','pthread_rwlock_rdlock','pthread_rwlock_wrlock','pthread_rwlock_unlock',
                     'pthread_once','sched_yield','madvise','prctl'):
                self.stub_return(0); return
            if n in ('clock_gettime', 'gettimeofday'):
                if xs[1]:
                    try: self.uc.mem_write(xs[1], b'\0' * 32)
                    except UcError: pass
                self.stub_return(0); return
            if n in ('dlopen',):
                self.stub_return(0x12340000); return
            if n in ('dlsym',):
                self.stub_return(0); return
            if n in ('open','open64','openat','fopen','read','pread','lseek','lseek64','readlink','opendir'):
                self.stub_return(0xffffffffffffffff); return
            if n in ('close','fclose','closedir'):
                self.stub_return(0); return
            if n in ('abort','__stack_chk_fail'):
                self.stopped_reason = f'external fatal call: {n}'
                self.uc.emu_stop(); return
            # Benign default for environment/probe APIs. The call is retained in the report.
            self.stub_return(0)
        except (UcError, RuntimeError) as exc:
            self.stopped_reason = f'external stub {n} failed: {exc}'
            self.uc.emu_stop()

    def snapshot(self, label: str, pc: int):
        cfg_slot = BIAS + 0x1ecea0
        cfg = self.qword(cfg_slot)
        asm_table_addr = BIAS + 0x1eceb8
        row = {'label': label, 'pc': pc, 'config_slot': cfg_slot, 'config_ptr': cfg, 'x20': self.uc.reg_read(UC_ARM64_REG_X20)}
        if cfg:
            try:
                raw = bytes(self.uc.mem_read(cfg, 0x1070))
                source = bytes(self.uc.mem_read(BIAS + 0x94c, 0x1070))
                diffs = [i for i, (a, b) in enumerate(zip(source, raw)) if a != b]
                row.update({
                    'config_sha256': hashlib.sha256(raw).hexdigest(),
                    'config_head': raw[:0x100].hex(),
                    'u32_at_0x70': struct.unpack_from('<I', raw, 0x70)[0],
                    'source_sha256_after_relocations': hashlib.sha256(source).hexdigest(),
                    'diff_count_vs_loaded_source': len(diffs),
                    'first_diff_offsets': diffs[:128],
                })
                if label == 'builder-entry':
                    (self.out / 'runtime-config-at-builder.bin').write_bytes(raw)
            except UcError as exc:
                row['config_read_error'] = repr(exc)
        try:
            table = bytes(self.uc.mem_read(asm_table_addr, 0xa8))
            row['asmfunction_table'] = [struct.unpack_from('<Q', table, i)[0] for i in range(0, 0xa8, 8)]
        except UcError as exc:
            row['table_read_error'] = repr(exc)
        if self.current_rwx_ptr:
            try:
                rwx = bytes(self.uc.mem_read(self.current_rwx_ptr, 0x1000))
                row['rwx_page_ptr'] = self.current_rwx_ptr
                row['rwx_page_sha256'] = hashlib.sha256(rwx).hexdigest()
                row['rwx_page_nonzero_bytes'] = sum(1 for x in rwx if x)
                if label in ('builder-entry', 'asm-table-complete'):
                    (self.out / f'rwx-page-{label}.bin').write_bytes(rwx)
            except UcError:
                pass
        self.snapshots.append(row)

    def code_hook(self, uc, address, size, _user):
        self.insns += 1
        if self.insns > MAX_INSNS:
            self.stopped_reason = f'instruction limit {MAX_INSNS}'
            uc.emu_stop(); return
        if address == STOP_ADDR:
            self.stopped_reason = 'DT_INIT returned'
            uc.emu_stop(); return
        if address in self.name_by_stub:
            self.emulate_external(self.name_by_stub[address], address); return

        rel = address - BIAS
        checkpoints = {
            0x7590: 'source-copy-complete',
            0x7654: 'rwx-mmap-returned',
            0x7dd0: 'builder-entry',
            0x892c: 'asm-table-complete',
        }
        if rel in checkpoints:
            self.snapshot(checkpoints[rel], address)

        # Two opaque-predicate trap loops are statically proven to be dead on a
        # normal startup path. A minimal harness lacks Android's process state used
        # by those predicates, so redirect only these exact self-loops and record it.
        forced = {
            0x6b04: 0x72d4,
            0x7dcc: 0x7dd0,
        }
        if rel in forced:
            target = BIAS + forced[rel]
            self.forced_edges.append({'from': rel, 'to': forced[rel]})
            uc.reg_write(UC_ARM64_REG_PC, target)

    def invalid_hook(self, uc, access, address, size, value, _user):
        self.invalid_memory.append({'access': int(access), 'address': address, 'size': size, 'value': value, 'pc': uc.reg_read(UC_ARM64_REG_PC)})
        # Do not silently invent arbitrary process state. One low guard page is
        # already mapped for TPIDR_EL0 fallback; every other unmapped access aborts.
        return False

    def run(self) -> dict:
        self.out.mkdir(parents=True, exist_ok=True)
        self.map_memory()
        relocations = self.apply_relocations()
        self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE, self.code_hook)
        self.uc.hook_add(UC_HOOK_MEM_INVALID, self.invalid_hook)
        start = BIAS + self.image.dt_init
        try:
            self.uc.emu_start(start, STOP_ADDR, count=MAX_INSNS + 1000)
        except UcError as exc:
            if self.stopped_reason is None:
                self.stopped_reason = f'Unicorn error: {exc}'
        if not any(x['label'] == 'asm-table-complete' for x in self.snapshots):
            try:
                self.snapshot('final-state', self.uc.reg_read(UC_ARM64_REG_PC))
            except Exception:
                pass
        return {
            'sample_sha256': sha256(self.image.path),
            'bias': BIAS,
            'dt_init': self.image.dt_init,
            'instructions_executed': self.insns,
            'stopped_reason': self.stopped_reason,
            'forced_opaque_edges': self.forced_edges,
            'invalid_memory': self.invalid_memory[-32:],
            'relocations_applied': len(relocations),
            'external_stub_count': len(self.stub_by_name),
            'external_calls': self.calls,
            'snapshots': self.snapshots,
        }


def write_report(out: Path, rep: dict):
    (out / 'dt-init-emulation.json').write_text(json.dumps(rep, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    L = [
        '# Minimal AppGuard `DT_INIT` emulation', '',
        f"- sample: `{rep['sample_sha256']}`",
        f"- instructions executed: **{rep['instructions_executed']}**",
        f"- relocations applied: **{rep['relocations_applied']}**",
        f"- external stubs: **{rep['external_stub_count']}**",
        f"- stop: `{rep['stopped_reason']}`",
        f"- forced opaque edges: **{len(rep['forced_opaque_edges'])}**",
        f"- invalid memory accesses: **{len(rep['invalid_memory'])}**", '',
        '## Runtime snapshots', '',
        '| Checkpoint | config ptr | +0x70 u32 | diff vs relocated source | RWX nonzero |',
        '|---|---:|---:|---:|---:|',
    ]
    for s in rep['snapshots']:
        L.append(
            f"| `{s['label']}` | `{hex(s['config_ptr']) if s.get('config_ptr') else '-'}` | "
            f"`{hex(s['u32_at_0x70']) if s.get('u32_at_0x70') is not None else '-'}` | "
            f"{s.get('diff_count_vs_loaded_source','-')} | {s.get('rwx_page_nonzero_bytes','-')} |"
        )
    L += ['', '## External calls reached', '']
    counts = {}
    for c in rep['external_calls']:
        counts[c['name']] = counts.get(c['name'], 0) + 1
    if counts:
        for name, n in sorted(counts.items(), key=lambda x: (-x[1], x[0])):
            L.append(f"- `{name}`: {n}")
    else:
        L.append('- none')
    if rep['invalid_memory']:
        L += ['', '## Last invalid memory accesses', '', '```json', json.dumps(rep['invalid_memory'], indent=2), '```']
    (out / 'dt-init-emulation.md').write_text('\n'.join(L) + '\n', encoding='utf-8')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    image = Image(args.libcompatible)
    if image.dt_init is None:
        raise SystemExit('DT_INIT not found')
    emu = BootstrapEmulator(image, args.out)
    rep = emu.run()
    write_report(args.out, rep)
    print(json.dumps({
        'stop': rep['stopped_reason'],
        'instructions': rep['instructions_executed'],
        'snapshots': [(x['label'], x.get('u32_at_0x70'), x.get('diff_count_vs_loaded_source')) for x in rep['snapshots']],
        'invalid_memory': len(rep['invalid_memory']),
    }, indent=2))


if __name__ == '__main__':
    main()

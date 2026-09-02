#!/usr/bin/env python3
"""Continue the minimal AppGuard DT_INIT harness across its direct SVC wrappers."""
from __future__ import annotations

import argparse
import importlib.util
import json
from pathlib import Path

from unicorn import UcError, UC_HOOK_CODE, UC_HOOK_INTR, UC_HOOK_MEM_INVALID
from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
BASE_PATH = HERE / 'emulate-appguard-dt-init.py'
spec = importlib.util.spec_from_file_location('appguard_dt_init_base', BASE_PATH)
base = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(base)

# Linux AArch64 syscall numbers used by the protected wrapper family.
SYSCALLS = {
    26: 'inotify_init1',
    27: 'inotify_add_watch',
    56: 'openat',
    57: 'close',
    61: 'getdents64',
    62: 'lseek',
    63: 'read',
    64: 'write',
    78: 'readlinkat',
    79: 'newfstatat',
    117: 'ptrace',
    129: 'kill',
    167: 'prctl',
    172: 'getpid',
    215: 'munmap',
    222: 'mmap',
    226: 'mprotect',
    260: 'wait4',
}


class SvcBootstrapEmulator(base.BootstrapEmulator):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.svc_calls = []

    def syscall_hook(self, uc, intno, _user):
        nr = uc.reg_read(UC_ARM64_REG_X8)
        regs = [uc.reg_read(globals()[f'UC_ARM64_REG_X{i}']) for i in range(6)]
        pc = uc.reg_read(UC_ARM64_REG_PC)
        name = SYSCALLS.get(nr, f'sys_{nr}')
        row = {'pc': pc, 'intno': int(intno), 'nr': nr, 'name': name, 'args': regs}
        self.svc_calls.append(row)

        # Mirror only the small syscall surface the AppGuard bootstrap needs.
        if nr == 222:  # mmap
            ret = self.alloc_mmap(regs[1])
        elif nr in (226, 215):  # mprotect / munmap
            ret = 0
        elif nr == 172:  # getpid
            ret = 1000
        elif nr == 64:  # write
            ret = regs[2]
        elif nr in (63, 61):  # read / getdents64 -> EOF
            ret = 0
        elif nr == 62:  # lseek
            ret = 0
        elif nr in (57, 117, 129, 167):  # close / ptrace / kill / prctl
            ret = 0
        elif nr in (56, 78, 79, 26, 27, 260):
            # Probe-style filesystem/inotify/wait calls. ENOENT-ish failure is safer
            # than fabricating host process state for an anti-tamper bootstrap.
            ret = 0xffffffffffffffff
        else:
            row['unsupported'] = True
            self.stopped_reason = f'unsupported direct syscall {nr} at {pc:#x}'
            uc.emu_stop()
            return
        uc.reg_write(UC_ARM64_REG_X0, ret & 0xffffffffffffffff)

    def run(self):
        self.out.mkdir(parents=True, exist_ok=True)
        self.map_memory()
        relocations = self.apply_relocations()
        self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE, self.code_hook)
        self.uc.hook_add(UC_HOOK_INTR, self.syscall_hook)
        self.uc.hook_add(UC_HOOK_MEM_INVALID, self.invalid_hook)
        start = base.BIAS + self.image.dt_init
        try:
            self.uc.emu_start(start, base.STOP_ADDR, count=base.MAX_INSNS + 1000)
        except UcError as exc:
            if self.stopped_reason is None:
                self.stopped_reason = f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        if not any(x['label'] == 'asm-table-complete' for x in self.snapshots):
            try:
                self.snapshot('final-state', self.uc.reg_read(UC_ARM64_REG_PC))
            except Exception:
                pass
        return {
            'sample_sha256': base.sha256(self.image.path),
            'bias': base.BIAS,
            'dt_init': self.image.dt_init,
            'instructions_executed': self.insns,
            'stopped_reason': self.stopped_reason,
            'forced_opaque_edges': self.forced_edges,
            'invalid_memory': self.invalid_memory[-32:],
            'relocations_applied': len(relocations),
            'external_stub_count': len(self.stub_by_name),
            'external_calls': self.calls,
            'direct_syscalls': self.svc_calls,
            'snapshots': self.snapshots,
        }


def write_report(out: Path, rep: dict):
    (out / 'dt-init-emulation-svc.json').write_text(json.dumps(rep, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    L = [
        '# AppGuard `DT_INIT` emulation with direct-syscall handling', '',
        f"- instructions executed: **{rep['instructions_executed']}**",
        f"- stop: `{rep['stopped_reason']}`",
        f"- direct SVC calls: **{len(rep['direct_syscalls'])}**",
        f"- invalid memory accesses: **{len(rep['invalid_memory'])}**", '',
        '## Runtime snapshots', '',
        '| Checkpoint | config ptr | +0x70 u32 | diff vs loaded source | RWX nonzero |',
        '|---|---:|---:|---:|---:|',
    ]
    for s in rep['snapshots']:
        L.append(
            f"| `{s['label']}` | `{hex(s['config_ptr']) if s.get('config_ptr') else '-'}` | "
            f"`{hex(s['u32_at_0x70']) if s.get('u32_at_0x70') is not None else '-'}` | "
            f"{s.get('diff_count_vs_loaded_source','-')} | {s.get('rwx_page_nonzero_bytes','-')} |"
        )
    L += ['', '## Direct syscalls', '', '| # | PC | nr | name | x0 | x1 | x2 |', '|---:|---:|---:|---|---:|---:|---:|']
    for i, c in enumerate(rep['direct_syscalls']):
        a = c['args']
        L.append(f"| {i} | `{c['pc']:#x}` | {c['nr']} | `{c['name']}` | `{a[0]:#x}` | `{a[1]:#x}` | `{a[2]:#x}` |")
    if rep['invalid_memory']:
        L += ['', '## Invalid memory', '', '```json', json.dumps(rep['invalid_memory'], indent=2), '```']
    (out / 'dt-init-emulation-svc.md').write_text('\n'.join(L) + '\n', encoding='utf-8')


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--libcompatible', type=Path, required=True)
    ap.add_argument('--out', type=Path, required=True)
    args = ap.parse_args()
    image = base.Image(args.libcompatible)
    emu = SvcBootstrapEmulator(image, args.out)
    rep = emu.run()
    write_report(args.out, rep)
    print(json.dumps({
        'stop': rep['stopped_reason'],
        'instructions': rep['instructions_executed'],
        'svc_calls': [(x['nr'], x['name']) for x in rep['direct_syscalls']],
        'snapshots': [(x['label'], x.get('u32_at_0x70'), x.get('diff_count_vs_loaded_source')) for x in rep['snapshots']],
        'invalid_memory': len(rep['invalid_memory']),
    }, indent=2))


if __name__ == '__main__':
    main()

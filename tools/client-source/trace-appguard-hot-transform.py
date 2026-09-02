#!/usr/bin/env python3
"""Runtime-slice the post-callback 0xfxxx AppGuard transform.

The post-callback profile proves the SoLibraryStart helper page is not modified
in-place during the next million instructions.  Execution instead spends most
of its time in a control-flow-flattened transform around 0xf000.  This tracer
records entry/exit transitions, LR/caller context, register state, and bounded
memory snapshots for pointer registers used by the transform so we can derive a
safe semantic shortcut instead of blindly raising the instruction budget.
"""
from __future__ import annotations

import argparse, hashlib, importlib.util, json, struct
from collections import deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn import UcError, UC_HOOK_CODE, UC_HOOK_INTR, UC_HOOK_MEM_INVALID
from unicorn.arm64_const import *

HERE = Path(__file__).resolve().parent
P = HERE / 'emulate-appguard-dt-init-bionic.py'
spec = importlib.util.spec_from_file_location('bionic_emu', P)
bionic = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(bionic)
base = bionic.base

HOT_LO = 0xEF00
HOT_HI = 0xF800
MAX_POST = 2_000_000
MAX_TRANSITIONS = 32
PTR_REGS = ('x0','x1','x4','x8','x20','x23','x28')
REG_CONSTS = {f'x{i}': globals()[f'UC_ARM64_REG_X{i}'] for i in range(31)}
REG_CONSTS['sp'] = UC_ARM64_REG_SP


def digest(b: bytes) -> dict:
    return {
        'size': len(b),
        'sha256': hashlib.sha256(b).hexdigest(),
        'nonzero': sum(1 for x in b if x),
        'head': b[:256].hex(),
    }


class Tracer(bionic.BionicEmulator):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.post = 0
        self.prev_rel = None
        self.history = deque(maxlen=128)
        self.in_hot = False
        self.transitions = []
        self.hot_entries = 0
        self.hot_exits = 0
        self.entry_buffers = None
        self.entry_regs = None

    def regs(self):
        r = {name: self.uc.reg_read(reg) for name, reg in REG_CONSTS.items()}
        r['pc'] = self.uc.reg_read(UC_ARM64_REG_PC)
        return r

    def safe_read(self, addr: int, n: int) -> bytes | None:
        if not addr:
            return None
        try:
            return bytes(self.uc.mem_read(addr, n))
        except UcError:
            return None

    def snapshot_buffers(self, regs):
        out = {}
        for name in PTR_REGS:
            ptr = regs.get(name, 0)
            # 4 KiB is enough to identify tables/headers while keeping reports small.
            raw = self.safe_read(ptr, 0x1000)
            if raw is None:
                raw = self.safe_read(ptr, 0x200)
            if raw is not None:
                out[name] = {'address': ptr, **digest(raw)}
        sp = regs.get('sp', 0)
        raw = self.safe_read(max(0, sp-0x100), 0x300)
        if raw is not None:
            out['stack'] = {'address': max(0,sp-0x100), **digest(raw)}
        return out

    def caller_disasm(self, lr: int):
        if not (base.BIAS <= lr < base.BIAS + 0x4000000):
            return []
        rel = lr - base.BIAS
        start = max(0, rel - 0x60)
        raw = self.safe_read(base.BIAS + start, 0xc0)
        if raw is None:
            return []
        md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
        return [{'pc': i.address-base.BIAS, 'mnemonic':i.mnemonic, 'op_str':i.op_str}
                for i in md.disasm(raw, base.BIAS+start)]

    @staticmethod
    def buffer_diff(before, after):
        rows=[]
        for name, a in (before or {}).items():
            b=(after or {}).get(name)
            if not b or a.get('address') != b.get('address'):
                continue
            rows.append({
                'register': name,
                'address': a['address'],
                'before_sha256': a['sha256'],
                'after_sha256': b['sha256'],
                'changed': a['sha256'] != b['sha256'],
                'before_head': a['head'],
                'after_head': b['head'],
            })
        return rows

    def record_entry(self, rel):
        regs=self.regs(); bufs=self.snapshot_buffers(regs)
        self.hot_entries += 1
        self.entry_regs=regs; self.entry_buffers=bufs
        lr=regs['x30']
        self.transitions.append({
            'kind':'entry','index':self.hot_entries,'post':self.post,'pc':rel,
            'previous_pc':self.prev_rel,'registers':regs,'buffers':bufs,
            'history':list(self.history),'caller':self.caller_disasm(lr),
            'lr_rel':lr-base.BIAS if base.BIAS <= lr < base.BIAS+0x4000000 else None,
        })

    def record_exit(self, rel):
        regs=self.regs(); bufs=self.snapshot_buffers(regs)
        self.hot_exits += 1
        self.transitions.append({
            'kind':'exit','index':self.hot_exits,'post':self.post,'pc':rel,
            'previous_pc':self.prev_rel,'registers':regs,'buffers':bufs,
            'history':list(self.history),
            'entry_to_exit_diff':self.buffer_diff(self.entry_buffers,bufs),
        })

    def code_hook(self, uc, address, size, user):
        super().code_hook(uc,address,size,user)
        if not self.callback_captured:
            self.prev_rel=address-base.BIAS
            self.history.append(self.prev_rel)
            return
        rel=address-base.BIAS
        self.post += 1
        now_hot = HOT_LO <= rel < HOT_HI
        if now_hot and not self.in_hot and len(self.transitions) < MAX_TRANSITIONS:
            self.record_entry(rel)
        elif self.in_hot and not now_hot and len(self.transitions) < MAX_TRANSITIONS:
            self.record_exit(rel)
        self.in_hot=now_hot
        self.prev_rel=rel
        self.history.append(rel)
        if len(self.transitions) >= MAX_TRANSITIONS or self.post >= MAX_POST:
            self.stopped_reason = 'hot-transform transition limit' if len(self.transitions)>=MAX_TRANSITIONS else f'post-callback limit {MAX_POST}'
            uc.emu_stop()

    def run_trace(self):
        self.out.mkdir(parents=True,exist_ok=True)
        self.map_memory(); relocs=self.apply_relocations(); self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE,self.code_hook)
        self.uc.hook_add(UC_HOOK_INTR,self.syscall_hook)
        self.uc.hook_add(UC_HOOK_MEM_INVALID,self.invalid_hook)
        try:
            self.uc.emu_start(base.BIAS+self.image.dt_init,base.STOP_ADDR,count=base.MAX_INSNS+MAX_POST+5000)
        except UcError as exc:
            if self.stopped_reason is None:
                self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        if self.in_hot and len(self.transitions)<MAX_TRANSITIONS:
            self.record_exit(self.uc.reg_read(UC_ARM64_REG_PC)-base.BIAS)
        return {
            'stop':self.stopped_reason,'callback_captured':self.callback_captured,
            'post_instructions':self.post,'hot_entries':self.hot_entries,'hot_exits':self.hot_exits,
            'transitions':self.transitions,'direct_syscalls':self.svc_calls,
            'external_calls':self.calls,'invalid_memory':self.invalid_memory[-64:],
            'relocations':len(relocs),'rand_calls':self.rand_calls,
        }


def render(rep):
    L=['# Runtime slice of AppGuard post-callback hot transform','',
       f"- stop: `{rep['stop']}`",f"- callback captured: **{rep['callback_captured']}**",
       f"- post-callback instructions: **{rep['post_instructions']}**",
       f"- hot entries/exits: **{rep['hot_entries']} / {rep['hot_exits']}**",'']
    for t in rep['transitions']:
        L += [f"## {t['kind']} #{t['index']} @ `0x{t['pc']:x}`",'',
              f"- previous PC: `{hex(t['previous_pc']) if t.get('previous_pc') is not None else '-'}`",
              f"- post instruction #: **{t['post']}**"]
        if t['kind']=='entry': L.append(f"- LR: `{hex(t['lr_rel']) if t.get('lr_rel') is not None else hex(t['registers']['x30'])}`")
        L += ['', '### Selected registers','', '| reg | value |','|---|---:|']
        for n in ('x0','x1','x2','x3','x4','x5','x6','x7','x8','x19','x20','x21','x22','x23','x24','x25','x26','x27','x28','x29','x30','sp'):
            L.append(f"| `{n}` | `0x{t['registers'][n]:x}` |")
        L += ['', '### Pointer snapshots','', '| reg | address | SHA-256 | nonzero | head |','|---|---:|---|---:|---|']
        for n,b in t.get('buffers',{}).items():
            L.append(f"| `{n}` | `0x{b['address']:x}` | `{b['sha256']}` | {b['nonzero']} | `{b['head'][:128]}` |")
        if t.get('entry_to_exit_diff'):
            L += ['', '### Entry → exit buffer changes','', '| reg | address | changed | before | after |','|---|---:|---|---|---|']
            for d in t['entry_to_exit_diff']:
                L.append(f"| `{d['register']}` | `0x{d['address']:x}` | **{d['changed']}** | `{d['before_sha256']}` | `{d['after_sha256']}` |")
        if t.get('caller'):
            L += ['', '### LR/caller window','', '```asm']
            lr=t.get('lr_rel')
            for i in t['caller']:
                mark='  ; LR' if lr is not None and i['pc']==lr else ('  ; callsite' if lr is not None and i['pc']==lr-4 else '')
                L.append(f"0x{i['pc']:x}: {i['mnemonic']} {i['op_str']}{mark}")
            L += ['```','']
        L += ['', '### Immediate execution history','', '`'+' '.join(f"0x{x:x}" for x in t.get('history',[])[-96:])+'`','']
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    e=Tracer(base.Image(a.libcompatible),a.out);r=e.run_trace()
    (a.out/'hot-transform-trace.json').write_text(json.dumps(r,indent=2)+'\n')
    (a.out/'hot-transform-trace.md').write_text(render(r))
    print(json.dumps({'stop':r['stop'],'post':r['post_instructions'],'entries':r['hot_entries'],'exits':r['hot_exits'],'first_entry':r['transitions'][0] if r['transitions'] else None},indent=2))
if __name__=='__main__':main()

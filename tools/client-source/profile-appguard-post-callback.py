#!/usr/bin/env python3
"""Profile libcompatible DT_INIT after the loader callback is installed.

The cross-library experiment showed that invoking SoLibraryStart immediately at
asmFunction[0x98/+0xa0] installation is too early: libcompatible+0x1cd84 still
raises an undefined-instruction exception.  This profiler continues the exact
Bionic bootstrap past callback installation, tracks writes to the 0x1c000 page
family used by SoLibraryStart helpers, and records post-callback hot PCs.
"""
from __future__ import annotations

import argparse, hashlib, importlib.util, json
from collections import Counter, deque
from pathlib import Path

from capstone import Cs, CS_ARCH_ARM64, CS_MODE_ARM
from unicorn import UcError, UC_HOOK_CODE, UC_HOOK_INTR, UC_HOOK_MEM_INVALID, UC_HOOK_MEM_WRITE
from unicorn.arm64_const import UC_ARM64_REG_PC

HERE = Path(__file__).resolve().parent
P = HERE / 'emulate-appguard-dt-init-bionic.py'
spec = importlib.util.spec_from_file_location('bionic_emu', P)
bionic = importlib.util.module_from_spec(spec)
assert spec and spec.loader
spec.loader.exec_module(bionic)
base = bionic.base
fast = bionic.mod

POST_LIMIT = 1_000_000
WATCH_LO = 0x1C000
WATCH_HI = 0x1E000
PROBES = (0x1CD4C, 0x1CD84)


class Profiler(bionic.BionicEmulator):
    def __init__(self, image, out):
        super().__init__(image, out)
        self.post_started = False
        self.post_count = 0
        self.post_hits = Counter()
        self.post_last = deque(maxlen=512)
        self.watch_writes = []
        self.probe_snapshots = []
        self._snapshot_marks = {1, 10, 100, 1000, 10000, 100000, 500000, POST_LIMIT}

    def probe(self, label):
        md = Cs(CS_ARCH_ARM64, CS_MODE_ARM)
        row = {'label': label, 'post_count': self.post_count, 'pc': self.uc.reg_read(UC_ARM64_REG_PC), 'probes': []}
        for rel in PROBES:
            try:
                raw = bytes(self.uc.mem_read(base.BIAS + rel, 0x80))
            except UcError:
                continue
            ins = []
            valid = 0
            for off in range(0, len(raw)-3, 4):
                ds = list(md.disasm(raw[off:off+4], rel+off, count=1))
                if ds:
                    valid += 1
                    ins.append({'address': rel+off, 'mnemonic': ds[0].mnemonic, 'op_str': ds[0].op_str})
                else:
                    ins.append({'address': rel+off, 'mnemonic': '.word', 'op_str': f'0x{int.from_bytes(raw[off:off+4], "little"):08x}'})
            row['probes'].append({'address': rel, 'sha256': hashlib.sha256(raw).hexdigest(), 'hex': raw.hex(), 'valid_words': valid, 'instructions': ins})
        self.probe_snapshots.append(row)

    def write_hook(self, uc, access, address, size, value, user):
        rel = address - base.BIAS
        if not (WATCH_LO <= rel < WATCH_HI):
            return
        if len(self.watch_writes) < 8192:
            self.watch_writes.append({'post_count': self.post_count, 'pc': uc.reg_read(UC_ARM64_REG_PC)-base.BIAS, 'offset': rel, 'size': size, 'value': value})
        if any(abs(rel-p) < 0x100 for p in PROBES):
            self.probe(f'write-near-0x{rel:x}')

    def code_hook(self, uc, address, size, user):
        super().code_hook(uc, address, size, user)
        if self.callback_captured and not self.post_started:
            self.post_started = True
            self.post_count = 0
            self.probe('callback-installed')
        if self.post_started:
            rel = address-base.BIAS
            self.post_count += 1
            self.post_hits[rel] += 1
            self.post_last.append(rel)
            if self.post_count in self._snapshot_marks:
                self.probe(f'post-{self.post_count}')
            if self.post_count >= POST_LIMIT:
                self.stopped_reason = f'post-callback profile limit {POST_LIMIT}'
                uc.emu_stop()

    def run_profile(self):
        self.out.mkdir(parents=True, exist_ok=True)
        self.map_memory(); relocs=self.apply_relocations(); self.setup_registers()
        self.uc.hook_add(UC_HOOK_CODE, self.code_hook)
        self.uc.hook_add(UC_HOOK_INTR, self.syscall_hook)
        self.uc.hook_add(UC_HOOK_MEM_INVALID, self.invalid_hook)
        self.uc.hook_add(UC_HOOK_MEM_WRITE, self.write_hook, begin=base.BIAS+WATCH_LO, end=base.BIAS+WATCH_HI-1)
        try:
            self.uc.emu_start(base.BIAS+self.image.dt_init, base.STOP_ADDR, count=base.MAX_INSNS+POST_LIMIT+2000)
        except UcError as exc:
            if self.stopped_reason is None:
                self.stopped_reason=f'Unicorn error: {exc}; pc={self.uc.reg_read(UC_ARM64_REG_PC):#x}'
        if self.post_started:
            self.probe('final')
        top=self.post_hits.most_common(64)
        md=Cs(CS_ARCH_ARM64,CS_MODE_ARM)
        regions=[];seen=set()
        for rel,n in top:
            center=rel & ~0x3f
            if center in seen: continue
            seen.add(center)
            try: raw=bytes(self.uc.mem_read(base.BIAS+center,0x100))
            except UcError: continue
            rows=[]
            for i in md.disasm(raw,center): rows.append({'pc':i.address,'mnemonic':i.mnemonic,'op_str':i.op_str})
            regions.append({'region_start':center,'hot_hits':sum(self.post_hits.get(x['pc'],0) for x in rows),'instructions':rows})
        return {
            'stop':self.stopped_reason,
            'callback_captured':self.callback_captured,
            'post_started':self.post_started,
            'post_count':self.post_count,
            'top_pcs':[{'pc':p,'hits':n} for p,n in top],
            'last_pcs':list(self.post_last),
            'watch_writes':self.watch_writes,
            'probe_snapshots':self.probe_snapshots,
            'regions':regions,
            'external_calls':self.calls,
            'direct_syscalls':self.svc_calls,
            'rand_calls':self.rand_calls,
            'invalid_memory':self.invalid_memory[-64:],
            'relocations':len(relocs),
        }


def render(rep):
    L=['# AppGuard execution after loader-callback installation','',f"- callback captured: **{rep['callback_captured']}**",f"- post-callback sampled instructions: **{rep['post_count']}**",f"- stop: `{rep['stop']}`",f"- writes in libcompatible `0x{WATCH_LO:x}..0x{WATCH_HI:x}`: **{len(rep['watch_writes'])}**",'', '## Probe evolution','', '| Label | Probe | SHA-256 | Valid AArch64 words |','|---|---:|---|---:|']
    for s in rep['probe_snapshots']:
        for p in s['probes']:
            L.append(f"| `{s['label']}` | `0x{p['address']:x}` | `{p['sha256']}` | {p['valid_words']} |")
    L += ['', '## Writes near SoLibraryStart helper page','', '| Post # | PC | Offset | Size | Value |','|---:|---:|---:|---:|---:|']
    for w in rep['watch_writes'][:1000]:
        L.append(f"| {w['post_count']} | `0x{w['pc']:x}` | `0x{w['offset']:x}` | {w['size']} | `0x{w['value']:x}` |")
    if not rep['watch_writes']: L.append('| - | - | - | - | - |')
    L += ['', '## Hot PCs after callback','', '| PC | Hits |','|---:|---:|']
    for x in rep['top_pcs']: L.append(f"| `0x{x['pc']:x}` | {x['hits']} |")
    L += ['', '## Hot-region disassembly','']
    hot=dict((x['pc'],x['hits']) for x in rep['top_pcs'])
    for r in rep['regions'][:20]:
        L += [f"### `0x{r['region_start']:x}`",'', '```asm']
        for i in r['instructions']:
            L.append(f"0x{i['pc']:x}: {i['mnemonic']} {i['op_str']}{'  ; HOT' if i['pc'] in hot else ''}")
        L += ['```','']
    L += ['## Last PCs','', '`'+' '.join(f"0x{x:x}" for x in rep['last_pcs'][-256:])+'`','']
    return '\n'.join(L)+'\n'


def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args()
    em=Profiler(base.Image(a.libcompatible),a.out); rep=em.run_profile();a.out.mkdir(parents=True,exist_ok=True)
    (a.out/'post-callback-profile.json').write_text(json.dumps(rep,indent=2)+'\n')
    (a.out/'post-callback-profile.md').write_text(render(rep))
    first=rep['probe_snapshots'][0]['probes'] if rep['probe_snapshots'] else []
    last=rep['probe_snapshots'][-1]['probes'] if rep['probe_snapshots'] else []
    print(json.dumps({'stop':rep['stop'],'post_count':rep['post_count'],'writes':len(rep['watch_writes']),'probe_changed':[(hex(x['address']),x['sha256']!=y['sha256']) for x,y in zip(first,last)],'top':rep['top_pcs'][:12]},indent=2))
if __name__=='__main__':main()

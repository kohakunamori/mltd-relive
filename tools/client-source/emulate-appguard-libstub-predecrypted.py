#!/usr/bin/env python3
"""Call SoLibraryStart after deterministic offline pre-decryption of known ranges.

Runtime tracing proves AppGuard decrypts each protected range by XORing complete
16-byte blocks with a fixed 16-byte key copied from another libcompatible RVA.
This harness stops at the normal callback-ready checkpoint (~2M instructions),
then applies the two now-proven transforms directly:

  0x1b660..0x4d1d0 key = bytes[0x7080c:0x7081c]
  0x4d1d0..0x521fc key = bytes[0x1712a8:0x1712b8]

Only floor(size/16)*16 bytes are XORed; a remainder is left untouched, matching
the observed 0x502c -> 0x5020 operation count. It then executes the exact
libstub DT_INIT call SoLibraryStart(libstub+0x16000).
"""
from __future__ import annotations

import argparse,hashlib,importlib.util,json
from pathlib import Path

HERE=Path(__file__).resolve().parent
P=HERE/'emulate-appguard-libstub-stage.py'
spec=importlib.util.spec_from_file_location('cross_stage',P)
cross=importlib.util.module_from_spec(spec);assert spec and spec.loader;spec.loader.exec_module(cross)
base=cross.base

RANGES=[
    {'start':0x1B660,'end':0x4D1D0,'key_source':0x7080C,'name':'SoLibrary helper range'},
    {'start':0x4D1D0,'end':0x521FC,'key_source':0x1712A8,'name':'runtime loader range'},
]


def decrypt_range(emu,row):
    start=row['start'];end=row['end'];size=end-start;full=size&~0xf
    key=bytes(emu.uc.mem_read(base.BIAS+row['key_source'],16))
    before=bytes(emu.uc.mem_read(base.BIAS+start,size));after=bytearray(before)
    for i in range(full):after[i]^=key[i&15]
    emu.uc.mem_write(base.BIAS+start,bytes(after))
    return {**row,'size':size,'xor_bytes':full,'remainder':size-full,'key16':key.hex(),'before_sha256':hashlib.sha256(before).hexdigest(),'after_sha256':hashlib.sha256(after).hexdigest(),'head_before':before[:64].hex(),'head_after':bytes(after[:64]).hex()}


def render(rep):
    s=rep['libstub_stage']
    L=['# AppGuard libstub stage with offline pre-decrypted libcompatible ranges','',f"- bootstrap stop: `{rep['bootstrap']['stop']}`",f"- callback captured: **{rep['bootstrap']['callback_captured']}**",'', '## Offline range transforms','', '| range | key source | key16 | xor bytes | remainder | before SHA | after SHA |','|---|---:|---|---:|---:|---|---|']
    for r in rep['predecrypted_ranges']:L.append(f"| `0x{r['start']:x}..0x{r['end']:x}` | `0x{r['key_source']:x}` | `{r['key16']}` | {r['xor_bytes']} | {r['remainder']} | `{r['before_sha256']}` | `{r['after_sha256']}` |")
    L += ['', '## SoLibraryStart -> libstub result','',f"- stop: `{s['stop']}`",f"- instructions: **{s['instructions']}**",f"- libstub bytes changed: **{s['diff_bytes']}**",f"- observed libstub writes: **{s['writes_observed']}**",f"- weak encrypted libstub SoLibraryStart changed: **{s['probe_before']['sha256'] != s['probe_after']['sha256']}**",'', '### External calls reached','']
    if s['external_calls']:
        for c in s['external_calls'][:200]:L.append(f"- `{c['name']}` args=`{c.get('args')}` string=`{c.get('string_arg','')}`")
    else:L.append('- none')
    L += ['', '### Direct exception/syscall events','']
    if s['direct_syscalls']:
        for c in s['direct_syscalls'][:100]:L.append(f"- pc=`0x{c.get('pc',0):x}` intno={c.get('intno')} nr=`{c.get('nr')}` name=`{c.get('name')}` args=`{c.get('args')}`")
    else:L.append('- none')
    L += ['', '### Modified libstub ranges','']
    for r in s['diff_ranges'][:200]:L.append(f"- `0x{r['start']:x}..0x{r['end']:x}` ({r['size']})")
    if not s['diff_ranges']:L.append('- none')
    return '\n'.join(L)+'\n'

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--libcompatible',type=Path,required=True);ap.add_argument('--libstub',type=Path,required=True);ap.add_argument('--out',type=Path,required=True);a=ap.parse_args();a.out.mkdir(parents=True,exist_ok=True)
    e=cross.CrossLoader(a.libcompatible,a.libstub,a.out);boot,_=e.bootstrap();pre=[decrypt_range(e,r) for r in RANGES]
    e.map_libstub();rel=e.apply_libstub_relocations();stage=e.run_libstub_stage();rep={'bootstrap':boot,'predecrypted_ranges':pre,'libstub_relocations_applied':rel,'libstub_stage':stage}
    (a.out/'libstub-predecrypted.json').write_text(json.dumps(rep,indent=2)+'\n');(a.out/'libstub-predecrypted.md').write_text(render(rep))
    print(json.dumps({'bootstrap_stop':boot['stop'],'ranges':[(hex(x['start']),hex(x['end']),x['key16']) for x in pre],'stage_stop':stage['stop'],'stage_pc':hex(stage['pc']),'stage_insns':stage['instructions'],'stub_diff':stage['diff_bytes'],'stub_writes':stage['writes_observed'],'calls':[(x['name'],x.get('string_arg')) for x in stage['external_calls'][:30]],'events':[(hex(x.get('pc',0)),x.get('intno'),x.get('nr')) for x in stage['direct_syscalls'][:20]]},indent=2))
if __name__=='__main__':main()

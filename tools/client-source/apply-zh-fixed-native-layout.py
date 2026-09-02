#!/usr/bin/env python3
"""Apply the recovered native *layout* stage of the historical zh-fixed build.

This script fuses the official arm64 split into an apktool-decoded base tree,
removes the AppGuard-only native modules/assets identified by the reconstruction,
and optionally installs a deprotected libil2cpp/global-metadata pair.

It does NOT derive/decrypt that pair. If --deprotected-* arguments are supplied,
the files must match the known historical zh-fixed hashes in reconstruction-spec.yml.
"""
from __future__ import annotations

import argparse
import hashlib
import shutil
import zipfile
from pathlib import Path

import yaml


def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open('rb') as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b''):
            h.update(chunk)
    return h.hexdigest()


def copy_zip_member(z: zipfile.ZipFile, member: str, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    with z.open(member) as src, dest.open('wb') as out:
        shutil.copyfileobj(src, out)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument('apktool_tree', type=Path)
    ap.add_argument('--arm64-split', required=True, type=Path)
    ap.add_argument('--reconstruction-root', type=Path, default=Path('client/reconstruction'))
    ap.add_argument('--deprotected-libil2cpp', type=Path)
    ap.add_argument('--deprotected-metadata', type=Path)
    args = ap.parse_args()

    root = args.apktool_tree.resolve()
    recon = args.reconstruction_root.resolve()
    spec = yaml.safe_load((recon / 'reconstruction-spec.yml').read_text(encoding='utf-8'))
    native = spec['native']

    remove_libs = set(native.get('remove_libraries', []))
    copied = []
    skipped = []
    with zipfile.ZipFile(args.arm64_split) as z:
        for info in z.infolist():
            name = info.filename
            if not name.startswith('lib/arm64-v8a/') or not name.endswith('.so'):
                continue
            if name in remove_libs:
                skipped.append(name)
                continue
            copy_zip_member(z, name, root / name)
            copied.append(name)

    for rel in native.get('remove_assets', []):
        p = root / rel
        if p.exists():
            p.unlink()
            # prune empty assets/appguard directory if this was its last member
            parent = p.parent
            try:
                parent.rmdir()
            except OSError:
                pass

    # Ensure none of the identified AppGuard libraries survive if the caller's tree
    # already contained a fused copy before this stage.
    for rel in remove_libs:
        p = root / rel
        if p.exists():
            p.unlink()

    target = native['target_payloads']
    installed = {}
    if args.deprotected_libil2cpp:
        got = digest(args.deprotected_libil2cpp)
        expected = target['libil2cpp_sha256']
        if got != expected:
            raise SystemExit(f'deprotected libil2cpp hash mismatch: {got} != {expected}')
        dst = root / 'lib/arm64-v8a/libil2cpp.so'
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(args.deprotected_libil2cpp, dst)
        installed['libil2cpp.so'] = got

    if args.deprotected_metadata:
        got = digest(args.deprotected_metadata)
        expected = target['global_metadata_sha256']
        if got != expected:
            raise SystemExit(f'deprotected global-metadata hash mismatch: {got} != {expected}')
        dst = root / 'assets/bin/Data/Managed/Metadata/global-metadata.dat'
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(args.deprotected_metadata, dst)
        installed['global-metadata.dat'] = got

    print('zh-fixed native layout stage applied')
    print(f'  copied non-AppGuard arm64 libraries: {len(copied)}')
    print(f'  skipped/removed AppGuard libraries: {len(remove_libs)}')
    for name in sorted(remove_libs):
        print(f'    - {name}')
    if installed:
        print('  verified historical deprotected payloads installed:')
        for name, h in installed.items():
            print(f'    - {name}: {h}')
    else:
        print('  deprotected IL2CPP pair not supplied; native decryption stage remains unresolved')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())

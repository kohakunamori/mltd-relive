#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import math
import zipfile
from pathlib import Path
from collections import Counter

from PIL import Image
from elftools.elf.elffile import ELFFile


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def entropy(data: bytes) -> float:
    if not data:
        return 0.0
    c = Counter(data)
    n = len(data)
    return -sum((v / n) * math.log2(v / n) for v in c.values())


def load_json(path: Path):
    return json.loads(path.read_text(encoding='utf-8'))


def write_json(path: Path, obj):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')


def image_semantic(path: Path):
    try:
        with Image.open(path) as im:
            im.load()
            rgba = im.convert('RGBA')
            payload = rgba.tobytes()
            return {
                'format': im.format,
                'mode': im.mode,
                'size': list(im.size),
                'rgba_sha256': sha256(payload),
            }
    except Exception as exc:
        return {'error': repr(exc)}


def refine_resources(original_apktool: Path, fixed_apktool: Path, reconstruction: Path):
    summary_path = reconstruction / 'android' / 'resources-summary.json'
    summary = load_json(summary_path)
    rows = []
    semantic_changed = []
    recompression_only = []
    for row in summary.get('changed', []):
        rel = row['path']
        a = original_apktool / 'res' / rel
        b = fixed_apktool / 'res' / rel
        item = {'path': rel}
        if a.suffix.lower() == '.png' and a.exists() and b.exists():
            ia = image_semantic(a)
            ib = image_semantic(b)
            item['original_image'] = ia
            item['fixed_image'] = ib
            same = (
                'error' not in ia and 'error' not in ib and
                ia.get('size') == ib.get('size') and
                ia.get('rgba_sha256') == ib.get('rgba_sha256')
            )
            item['pixel_identical'] = same
            (recompression_only if same else semantic_changed).append(rel)
        else:
            item['pixel_identical'] = None
            semantic_changed.append(rel)
        rows.append(item)
    out = {
        'raw_changed_count': len(summary.get('changed', [])),
        'recompression_only_count': len(recompression_only),
        'semantic_changed_count': len(semantic_changed),
        'recompression_only': recompression_only,
        'semantic_changed': semantic_changed,
        'details': rows,
    }
    write_json(reconstruction / 'android' / 'resource-semantic-analysis.json', out)
    return out


def extract_member(apk: Path, member: str) -> bytes:
    with zipfile.ZipFile(apk) as z:
        return z.read(member)


def fixed_sections(fixed_bytes: bytes):
    import io
    rows = []
    with io.BytesIO(fixed_bytes) as bio:
        elf = ELFFile(bio)
        for sec in elf.iter_sections():
            rows.append({
                'name': sec.name,
                'offset': int(sec['sh_offset']),
                'size': int(sec['sh_size']),
                'addr': int(sec['sh_addr']),
                'type': str(sec['sh_type']),
            })
        segments = []
        for idx, seg in enumerate(elf.iter_segments()):
            segments.append({
                'index': idx,
                'type': str(seg['p_type']),
                'offset': int(seg['p_offset']),
                'filesz': int(seg['p_filesz']),
                'memsz': int(seg['p_memsz']),
                'vaddr': int(seg['p_vaddr']),
                'flags': int(seg['p_flags']),
            })
    return rows, segments


def compare_range(original: bytes, fixed: bytes, off: int, size: int):
    if size <= 0 or off < 0 or off + size > len(fixed) or off + size > len(original):
        return None
    a = original[off:off + size]
    b = fixed[off:off + size]
    eq = sum(x == y for x, y in zip(a, b))
    return {
        'size': size,
        'original_sha256_at_fixed_offset': sha256(a),
        'fixed_sha256': sha256(b),
        'identical': a == b,
        'equal_bytes': eq,
        'equal_ratio': eq / size,
        'original_entropy': entropy(a),
        'fixed_entropy': entropy(b),
    }


def refine_elf(original_arm64: Path, fixed_apk: Path, reconstruction: Path):
    original = extract_member(original_arm64, 'lib/arm64-v8a/libil2cpp.so')
    fixed = extract_member(fixed_apk, 'lib/arm64-v8a/libil2cpp.so')
    sections, segments = fixed_sections(fixed)
    srows = []
    for sec in sections:
        row = dict(sec)
        row['same_offset_comparison'] = compare_range(original, fixed, sec['offset'], sec['size'])
        srows.append(row)
    prows = []
    for seg in segments:
        row = dict(seg)
        row['same_offset_comparison'] = compare_range(original, fixed, seg['offset'], seg['filesz'])
        prows.append(row)

    prefix_n = min(len(original), len(fixed))
    eq = sum(a == b for a, b in zip(original[:prefix_n], fixed[:prefix_n]))
    appended = original[len(fixed):] if len(original) > len(fixed) else b''
    result = {
        'original_size': len(original),
        'fixed_size': len(fixed),
        'common_prefix_length': prefix_n,
        'same_offset_equal_bytes': eq,
        'same_offset_equal_ratio': eq / prefix_n if prefix_n else 0.0,
        'original_extra_tail_size': len(appended),
        'original_extra_tail_sha256': sha256(appended) if appended else None,
        'original_extra_tail_entropy': entropy(appended) if appended else None,
        'fixed_sections_compared_at_same_file_offsets': srows,
        'fixed_program_segments_compared_at_same_file_offsets': prows,
    }
    write_json(reconstruction / 'il2cpp' / 'same-offset-analysis.json', result)

    table = ['# `libil2cpp.so` same-offset protection map', '',
             '| Fixed section | Offset | Size | Identical | Equal bytes |',
             '|---|---:|---:|:---:|---:|']
    for r in srows:
        c = r['same_offset_comparison']
        if not c:
            continue
        table.append(f"| `{r['name'] or '<null>'}` | 0x{r['offset']:x} | {r['size']} | {'yes' if c['identical'] else 'NO'} | {c['equal_ratio']:.2%} |")
    (reconstruction / 'il2cpp' / 'same-offset-analysis.md').write_text('\n'.join(table) + '\n', encoding='utf-8')
    return result


def update_readme(reconstruction: Path, res, elf):
    readme = reconstruction / 'README.md'
    text = readme.read_text(encoding='utf-8') if readme.exists() else '# zh-fixed reconstruction workspace\n'
    marker = '\n## Refinement findings\n'
    if marker in text:
        text = text.split(marker, 1)[0].rstrip() + '\n'
    text += marker
    text += f"\n- Of the raw resource-file changes, **{res['recompression_only_count']}** are pixel-identical PNG recompression artifacts and **{res['semantic_changed_count']}** remain semantic changes.\n"
    text += f"- `libil2cpp.so` compares at the same file offsets for the first {elf['common_prefix_length']} bytes: **{elf['same_offset_equal_ratio']:.2%}** are byte-identical; the protected official library has an extra **{elf['original_extra_tail_size']} bytes** after the fixed library ends.\n"
    readme.write_text(text, encoding='utf-8')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--original-apktool', type=Path, required=True)
    p.add_argument('--fixed-apktool', type=Path, required=True)
    p.add_argument('--original-arm64', type=Path, required=True)
    p.add_argument('--fixed', type=Path, required=True)
    p.add_argument('--reconstruction', type=Path, required=True)
    args = p.parse_args()
    res = refine_resources(args.original_apktool, args.fixed_apktool, args.reconstruction)
    elf = refine_elf(args.original_arm64, args.fixed, args.reconstruction)
    update_readme(args.reconstruction, res, elf)
    print(json.dumps({
        'resource_recompression_only': res['recompression_only_count'],
        'resource_semantic_changed': res['semantic_changed_count'],
        'libil2cpp_same_offset_equal_ratio': elf['same_offset_equal_ratio'],
        'libil2cpp_extra_protection_tail': elf['original_extra_tail_size'],
    }, indent=2))


if __name__ == '__main__':
    main()

# zh-fixed reconstruction workspace

This directory is generated from the verified official Traditional Chinese 2.1.000 split bundle and the repository's current `zh-fixed` release. It records semantic changes instead of raw rebuild noise.

## Current findings

- Normalized smali: **1 changed**, **5427 identical**, 17 original-only, 0 fixed-only.
- `global-metadata.dat`: original IL2CPP magic = **False**, fixed IL2CPP magic = **True**; equal-byte ratio = **23.1504%**; repeating XOR period <=512 = **None**.
- `libil2cpp.so`: original 105866464 bytes -> fixed 99150888 bytes; changed same-name ELF sections: **3**.

## Layout

- `PROVENANCE.json` — exact original/fixed inputs and hashes.
- `critical-payloads.json` — critical file-level comparison.
- `android/` — decoded Manifest/resource diffs and normalized smali patches.
- `metadata/analysis.json` — metadata header/entropy/XOR analysis.
- `il2cpp/elf-analysis.json` — ELF section-level comparison and attempts to relocate known fixed-baseline patch-point contexts into the official library.

`android/fixed-smali/` contains only the normalized fixed-side source for classes that are semantically different, so this branch preserves the actual reconstructed Android changes without committing the entire generated APKTool tree.

#!/usr/bin/env python3
import argparse
import hashlib
import json
from pathlib import Path

FIXED_LIB = "52d0cdac0179ae4a5d61a00b9bfd500969730d1a3f157cf667d82c525836936b"
FIXED_META = "0b0913387be65fb046a7536e016cd9f8514b0ac23bd79b8b20540c73cb1d8cf0"
IL2CPP_MAGIC = bytes.fromhex("af1bb1fa")


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def inspect_file(path: Path, kind: str):
    data = path.read_bytes()[:16]
    result = {
        "path": str(path),
        "size": path.stat().st_size,
        "sha256": sha256(path),
        "prefix_hex": data.hex(),
    }
    if kind == "lib":
        result["elf_magic"] = data.startswith(b"\x7fELF")
        result["matches_historical_fixed"] = result["sha256"] == FIXED_LIB
    elif kind == "metadata":
        result["il2cpp_magic"] = data.startswith(IL2CPP_MAGIC)
        result["matches_historical_fixed"] = result["sha256"] == FIXED_META
    return result


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--lib", type=Path)
    ap.add_argument("--metadata", type=Path)
    ap.add_argument("--dump-cs", type=Path)
    ap.add_argument("--json-out", type=Path)
    args = ap.parse_args()

    report = {
        "historical_fixed": {
            "libil2cpp_sha256": FIXED_LIB,
            "metadata_sha256": FIXED_META,
        }
    }
    ok = True

    if args.lib:
        if not args.lib.is_file():
            raise SystemExit(f"missing lib: {args.lib}")
        report["libil2cpp"] = inspect_file(args.lib, "lib")
        ok &= report["libil2cpp"]["elf_magic"]

    if args.metadata:
        if not args.metadata.is_file():
            raise SystemExit(f"missing metadata: {args.metadata}")
        report["metadata"] = inspect_file(args.metadata, "metadata")
        ok &= report["metadata"]["il2cpp_magic"]

    if args.dump_cs:
        if not args.dump_cs.is_file():
            raise SystemExit(f"missing dump.cs: {args.dump_cs}")
        text = args.dump_cs.read_text(errors="replace")
        report["dump_cs"] = {
            "path": str(args.dump_cs),
            "size": args.dump_cs.stat().st_size,
            "sha256": sha256(args.dump_cs),
            "contains_assembly_csharp": "Assembly-CSharp" in text,
            "contains_imas_namespace": "Imas." in text,
            "rpc_name_hits": sum(text.count(x) for x in (
                "AuthService.Login", "AssetService.GetAssetVersion",
                "GameService.GetVersion", "UserService.GetSelf"
            )),
        }
        ok &= report["dump_cs"]["size"] > 1024 * 1024

    report["basic_validation_passed"] = bool(ok)
    rendered = json.dumps(report, ensure_ascii=False, indent=2)
    print(rendered)
    if args.json_out:
        args.json_out.parent.mkdir(parents=True, exist_ok=True)
        args.json_out.write_text(rendered + "\n")
    raise SystemExit(0 if ok else 2)


if __name__ == "__main__":
    main()

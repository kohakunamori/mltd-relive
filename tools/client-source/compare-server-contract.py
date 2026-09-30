#!/usr/bin/env python3
"""Compare the recovered MLTD client RPC surface with relive server handlers."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

DECORATOR_RE = re.compile(
    r"@dispatcher\.add_method\s*\(\s*name\s*=\s*['\"]([^'\"]+)['\"]\s*\)"
)


def read_client_methods(path: Path) -> set[str]:
    return {
        line.strip()
        for line in path.read_text(encoding="utf-8", errors="replace").splitlines()
        if line.strip() and not line.lstrip().startswith("#")
    }


def read_server_methods(root: Path) -> tuple[set[str], dict[str, list[str]]]:
    methods: set[str] = set()
    locations: dict[str, list[str]] = {}
    for file in sorted(root.rglob("*.py")):
        text = file.read_text(encoding="utf-8", errors="replace")
        for match in DECORATOR_RE.finditer(text):
            method = match.group(1)
            methods.add(method)
            line = text.count("\n", 0, match.start()) + 1
            locations.setdefault(method, []).append(f"{file}:{line}")
    return methods, locations


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("client_methods", type=Path)
    parser.add_argument("server_services", type=Path)
    parser.add_argument("output_dir", type=Path)
    args = parser.parse_args()

    client = read_client_methods(args.client_methods)
    server, locations = read_server_methods(args.server_services)

    implemented = client & server
    missing = client - server
    server_only = server - client
    coverage = (len(implemented) / len(client) * 100.0) if client else 0.0

    args.output_dir.mkdir(parents=True, exist_ok=True)
    payload = {
        "client_rpc_method_count": len(client),
        "server_registered_method_count": len(server),
        "implemented_client_method_count": len(implemented),
        "client_contract_coverage_percent": round(coverage, 2),
        "missing_on_server": sorted(missing),
        "server_only": sorted(server_only),
        "implemented": sorted(implemented),
        "server_locations": {k: locations[k] for k in sorted(locations)},
    }
    (args.output_dir / "server-contract-diff.json").write_text(
        json.dumps(payload, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )

    lines = [
        "# Recovered client RPC vs relive server",
        "",
        f"- Client RPC constants: **{len(client)}**",
        f"- Server registered handlers: **{len(server)}**",
        f"- Client methods currently handled: **{len(implemented)}**",
        f"- Contract coverage: **{coverage:.2f}%**",
        f"- Client methods without a server handler: **{len(missing)}**",
        f"- Server-only registrations: **{len(server_only)}**",
        "",
        "## Missing on server",
        "",
    ]
    lines.extend(f"- `{name}`" for name in sorted(missing))
    lines.extend(["", "## Server-only registrations", ""])
    lines.extend(f"- `{name}`" for name in sorted(server_only))
    lines.append("")
    (args.output_dir / "server-contract-diff.md").write_text(
        "\n".join(lines), encoding="utf-8"
    )

    print(
        f"client={len(client)} server={len(server)} implemented={len(implemented)} "
        f"coverage={coverage:.2f}% missing={len(missing)} server_only={len(server_only)}"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

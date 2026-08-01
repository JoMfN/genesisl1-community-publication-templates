#!/usr/bin/env python3
"""Optional SMILES preprocessor.

This tool is deliberately not called by `make all`. It runs Open Babel outside LaTeX,
produces reviewable SVG files, and records the input SMILES and output hashes.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()

    executable = shutil.which("obabel")
    if executable is None:
        print(
            "error: Open Babel (`obabel`) is required for this optional target.",
            file=sys.stderr,
        )
        return 2

    args.output.mkdir(parents=True, exist_ok=True)
    records: list[dict[str, str]] = []

    with args.input.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle, delimiter="\t")
        required = {"id", "smiles"}
        if set(reader.fieldnames or ()) != required:
            print("error: TSV columns must be exactly: id<TAB>smiles", file=sys.stderr)
            return 2

        for row in reader:
            identifier = row["id"].strip()
            smiles = row["smiles"].strip()
            if not identifier or not smiles:
                continue
            if not identifier.replace("-", "").replace("_", "").isalnum():
                print(f"error: unsafe compound id: {identifier}", file=sys.stderr)
                return 2

            svg = args.output / f"{identifier}.svg"
            process = subprocess.run(
                [executable, f"-:{smiles}", "-O", str(svg)],
                capture_output=True,
                text=True,
            )
            if process.returncode != 0:
                print(process.stderr, file=sys.stderr)
                return process.returncode

            digest = hashlib.sha256(svg.read_bytes()).hexdigest()
            records.append({
                "id": identifier,
                "smiles": smiles,
                "svg": svg.name,
                "sha256": digest,
            })

    (args.output / "manifest.json").write_text(
        json.dumps(records, indent=2) + "\n",
        encoding="utf-8",
    )
    print(f"Rendered {len(records)} structures into {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

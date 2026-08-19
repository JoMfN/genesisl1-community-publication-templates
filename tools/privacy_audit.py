#!/usr/bin/env python3
"""Fail if a public web release contains build debris or likely private material."""

from __future__ import annotations

import argparse
from pathlib import Path
import re
import sys
import zipfile

FORBIDDEN_SUFFIXES = (
    ".aux", ".log", ".toc", ".out", ".bbl", ".blg", ".fls",
    ".fdb_latexmk", ".synctex.gz", ".lof", ".lot", ".los",
    ".env", ".pem", ".key", ".p12", ".pfx",
)

FORBIDDEN_NAMES = {
    ".git", ".ssh", "__pycache__", ".DS_Store",
    "id_rsa", "id_ed25519", "wallet", "keystore",
}

TEXT_PATTERNS = {
    "private-key block": re.compile(rb"-----BEGIN [A-Z ]*PRIVATE KEY-----"),
    "Linux home path": re.compile(rb"/home/[A-Za-z0-9._-]+/"),
    "macOS home path": re.compile(rb"/Users/[A-Za-z0-9._-]+/"),
    "Windows user path": re.compile(rb"[A-Za-z]:\\\\Users\\\\[^\\\\\r\n]+"),
    "AWS access key": re.compile(rb"\bAKIA[0-9A-Z]{16}\b"),
}

MAX_TEXT_SCAN = 5 * 1024 * 1024


def forbidden_name(path: Path) -> bool:
    if any(part in FORBIDDEN_NAMES for part in path.parts):
        return True
    return any(path.name.endswith(suffix) for suffix in FORBIDDEN_SUFFIXES)


def scan_bytes(name: str, data: bytes, errors: list[str]) -> None:
    if len(data) > MAX_TEXT_SCAN:
        return
    if b"\x00" in data[:4096]:
        return
    for description, pattern in TEXT_PATTERNS.items():
        if pattern.search(data):
            errors.append(f"{name}: matched {description}")


def scan_zip(path: Path, errors: list[str]) -> None:
    try:
        with zipfile.ZipFile(path) as archive:
            for info in archive.infolist():
                entry = Path(info.filename)
                if forbidden_name(entry):
                    errors.append(f"{path}: forbidden archive entry {entry}")
                    continue
                if info.is_dir():
                    continue
                data = archive.read(info)
                scan_bytes(f"{path}!{entry}", data, errors)
    except zipfile.BadZipFile:
        errors.append(f"{path}: invalid ZIP archive")


def scan(root: Path) -> list[str]:
    errors: list[str] = []

    for path in sorted(root.rglob("*")):
        relative = path.relative_to(root)

        if path.is_symlink():
            errors.append(f"{relative}: symbolic links are not allowed")
            continue

        if forbidden_name(relative):
            errors.append(f"{relative}: forbidden name or extension")
            continue

        if not path.is_file():
            continue

        if path.suffix.lower() == ".zip":
            scan_zip(path, errors)
        else:
            try:
                scan_bytes(str(relative), path.read_bytes(), errors)
            except OSError as exc:
                errors.append(f"{relative}: could not read ({exc})")

    return errors


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("path", type=Path)
    args = parser.parse_args()

    root = args.path.resolve()
    if not root.is_dir():
        print(f"error: not a directory: {root}", file=sys.stderr)
        return 2

    errors = scan(root)
    if errors:
        print("Privacy/release audit failed:")
        for error in errors:
            print(f"  - {error}")
        return 1

    print(f"Privacy/release audit passed: {root}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

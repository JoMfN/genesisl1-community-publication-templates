#!/usr/bin/env python3
"""Advisory scientific-language checks for LaTeX manuscripts.

This is deliberately a heuristic reviewer, not a gatekeeper. It reports phrases that
deserve human attention and exits successfully unless --strict is supplied.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import re
import sys

RULES = [
    (
        re.compile(r"\b(proves?|proved|proven)\b", re.IGNORECASE),
        "Use 'proves' only for formal proof. Consider 'provides evidence that' or "
        "'is consistent with'.",
    ),
    (
        re.compile(r"\bclearly superior\b", re.IGNORECASE),
        "Define the comparison, metric, uncertainty, and evidence instead of "
        "calling a method 'clearly superior'.",
    ),
    (
        re.compile(r"\b(previous|earlier) (studies|methods|work) (failed|were wrong)\b", re.IGNORECASE),
        "Describe differences in methods, populations, materials, or conditions "
        "without dismissing prior work.",
    ),
    (
        re.compile(r"\bgoes deeper than\b", re.IGNORECASE),
        "Prefer a neutral statement of the additional mechanism, parameter, or scale.",
    ),
    (
        re.compile(r"\b(first ever|unprecedented|revolutionary)\b", re.IGNORECASE),
        "Check whether the priority or promotional claim is necessary and fully sourced.",
    ),
]

INTERPRETATION_MARKERS = [
    re.compile(r"our results provide evidence that", re.IGNORECASE),
    re.compile(r"this observation points towards", re.IGNORECASE),
    re.compile(r"the findings are consistent with", re.IGNORECASE),
]


def strip_comments(text: str) -> str:
    lines = []
    for line in text.splitlines():
        escaped = False
        kept = []
        for char in line:
            if char == "%" and not escaped:
                break
            kept.append(char)
            escaped = char == "\\" and not escaped
            if char != "\\":
                escaped = False
        lines.append("".join(kept))
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("manuscript", type=Path)
    parser.add_argument("--strict", action="store_true")
    args = parser.parse_args()

    if not args.manuscript.is_file():
        print(f"error: no such manuscript: {args.manuscript}", file=sys.stderr)
        return 2

    text = strip_comments(args.manuscript.read_text(encoding="utf-8"))
    findings: list[str] = []

    for pattern, message in RULES:
        for match in pattern.finditer(text):
            line = text.count("\n", 0, match.start()) + 1
            findings.append(f"line {line}: {match.group(0)!r} - {message}")

    for marker in INTERPRETATION_MARKERS:
        for match in marker.finditer(text):
            line = text.count("\n", 0, match.start()) + 1
            findings.append(
                f"line {line}: interpretation marker {match.group(0)!r}; "
                "confirm that the supporting evidence is stated nearby."
            )

    required_abstract_commands = [
        r"\AbstractBackground",
        r"\AbstractMethods",
        r"\AbstractResults",
        r"\AbstractConclusion",
    ]
    if "GenesisStructuredAbstract" in text:
        for command in required_abstract_commands:
            if command not in text:
                findings.append(f"structured abstract is missing {command}")

    if findings:
        print("Advisory manuscript review:")
        for finding in findings:
            print(f"  - {finding}")
    else:
        print("No advisory language patterns were found.")

    return 1 if args.strict and findings else 0


if __name__ == "__main__":
    raise SystemExit(main())

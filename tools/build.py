#!/usr/bin/env python3
"""Build and publish the GenesisL1 community template repository.

The build machine creates a clean `web/` tree. The Nginx machine only receives
that directory and does not need TeX, Python packages, repository history, or
source datasets.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tomllib
import zipfile

ROOT = Path(__file__).resolve().parents[1]
MANIFEST_PATH = ROOT / "release-manifest.toml"

with MANIFEST_PATH.open("rb") as handle:
    CONFIG = tomllib.load(handle)

TEMPLATES: list[str] = CONFIG["release"]["templates"]
BUILD_DIR = ROOT / CONFIG["build"]["build_directory"]
WEB_DIR = ROOT / CONFIG["build"]["web_output"]
SITE_DIR = ROOT / CONFIG["build"]["web_source"]
LATEX_ENGINE = CONFIG["build"]["latex_engine"]
LATEX_PASSES = int(CONFIG["build"]["passes"])

EXCLUDED_EXTENSIONS = tuple(CONFIG["privacy"]["excluded_extensions"])
EXCLUDED_NAMES = set(CONFIG["privacy"]["excluded_names"])

PREVIEW_NAMES = {
    "scientific-paper": "scientific-paper.pdf",
    "community-letter": "community-letter.pdf",
    "scientific-review": "scientific-review.pdf",
    "scientific-letter": "scientific-letter.pdf",
    "protocol-method": "protocol-method.pdf",
    "manual": "manual.pdf",
}

PACKAGE_NAMES = {
    name: f"genesisl1-{name}-template.zip"
    for name in TEMPLATES
}


def fail(message: str) -> "NoReturn":
    raise RuntimeError(message)


def is_excluded(path: Path) -> bool:
    if any(part in EXCLUDED_NAMES for part in path.parts):
        return True
    name = path.name
    if name in EXCLUDED_NAMES:
        return True
    return any(name.endswith(extension) for extension in EXCLUDED_EXTENSIONS)


def remove_latex_intermediates(root: Path) -> None:
    if not root.exists():
        return
    for path in sorted(root.rglob("*"), reverse=True):
        if path.is_file() and is_excluded(path):
            path.unlink()


def clean() -> None:
    shutil.rmtree(BUILD_DIR, ignore_errors=True)

    # Keep the tracked website source separate. `web/` is deployment output.
    if WEB_DIR.exists():
        shutil.rmtree(WEB_DIR)
    WEB_DIR.mkdir(parents=True)

    remove_latex_intermediates(ROOT / "templates")


def prepare_assets() -> None:
    brand_source = ROOT / "assets" / "brand"
    guidance_source = ROOT / "assets" / "guidance"
    if not brand_source.is_dir():
        fail(f"Missing official brand asset directory: {brand_source}")

    for template in TEMPLATES:
        target_root = ROOT / "templates" / template / "assets"
        brand_target = target_root / "brand"
        guidance_target = target_root / "guidance"

        shutil.rmtree(brand_target, ignore_errors=True)
        shutil.rmtree(guidance_target, ignore_errors=True)
        shutil.copytree(brand_source, brand_target)
        shutil.copytree(guidance_source, guidance_target)


def run_latex(cwd: Path, tex_file: Path, texinputs: Path | None = None) -> Path:
    environment = os.environ.copy()
    if texinputs is not None:
        inherited = environment.get("TEXINPUTS", "")
        environment["TEXINPUTS"] = f"{texinputs}//{os.pathsep}{inherited}"

    command = [
        LATEX_ENGINE,
        "-interaction=nonstopmode",
        "-halt-on-error",
        tex_file.name,
    ]

    for _ in range(LATEX_PASSES):
        process = subprocess.run(
            command,
            cwd=cwd,
            env=environment,
            capture_output=True,
            text=True,
        )
        if process.returncode != 0:
            transcript = process.stdout[-8000:]
            fail(
                f"LaTeX compilation failed for {tex_file}.\n"
                f"Command: {' '.join(command)}\n\n{transcript}"
            )

    pdf = cwd / f"{tex_file.stem}.pdf"
    if not pdf.is_file():
        fail(f"Expected PDF was not created: {pdf}")
    return pdf


def copy_template_to_build(template: str) -> Path:
    source = ROOT / "templates" / template
    target = BUILD_DIR / template
    shutil.rmtree(target, ignore_errors=True)
    shutil.copytree(source, target)
    remove_latex_intermediates(target)
    return target


def compile_template(template: str) -> dict[str, Path]:
    stage = copy_template_to_build(template)
    outputs: dict[str, Path] = {}

    outputs["template"] = run_latex(
        cwd=stage,
        tex_file=stage / "template.tex",
        texinputs=stage,
    )

    if template == "scientific-paper":
        example_dir = stage / "examples"
        outputs["field-showcase"] = run_latex(
            cwd=example_dir,
            tex_file=example_dir / "field-showcase.tex",
            texinputs=stage,
        )

    return outputs


def compile_all() -> dict[str, dict[str, Path]]:
    BUILD_DIR.mkdir(parents=True, exist_ok=True)
    return {template: compile_template(template) for template in TEMPLATES}


def copy_site() -> None:
    if not SITE_DIR.is_dir():
        fail(f"Missing website source: {SITE_DIR}")
    shutil.rmtree(WEB_DIR, ignore_errors=True)
    shutil.copytree(SITE_DIR, WEB_DIR)

    (WEB_DIR / "templates").mkdir(parents=True, exist_ok=True)
    (WEB_DIR / "previews").mkdir(parents=True, exist_ok=True)
    (WEB_DIR / "assets" / "brand").mkdir(parents=True, exist_ok=True)

    # The website only needs the official navy lockup and the official master.
    for name in [
        "genesisl1-lockup-navy.svg",
        "genesisl1-lockup-navy-2400.png",
        "genesisl1-official-logo.svg",
    ]:
        source = ROOT / "assets" / "brand" / name
        if source.is_file():
            shutil.copy2(source, WEB_DIR / "assets" / "brand" / name)


def iter_release_files(template_root: Path):
    for path in sorted(template_root.rglob("*")):
        if not path.is_file():
            continue
        relative = path.relative_to(template_root)
        if is_excluded(relative):
            continue
        if path.suffix == ".pdf":
            # PDFs are injected from the current build, never copied from source.
            continue
        yield path, relative


def package_template(
    template: str,
    outputs: dict[str, Path],
) -> Path:
    package_name = PACKAGE_NAMES[template]
    destination = WEB_DIR / "templates" / package_name
    source_root = ROOT / "templates" / template
    archive_root = f"genesisl1-{template}-template"

    with zipfile.ZipFile(
        destination,
        "w",
        compression=zipfile.ZIP_DEFLATED,
        compresslevel=9,
    ) as archive:
        for source, relative in iter_release_files(source_root):
            archive.write(source, f"{archive_root}/{relative.as_posix()}")

        archive.write(
            outputs["template"],
            f"{archive_root}/template.pdf",
        )

        if template == "scientific-paper" and "field-showcase" in outputs:
            archive.write(
                outputs["field-showcase"],
                f"{archive_root}/examples/field-showcase.pdf",
            )

    return destination


def publish_previews(
    template: str,
    outputs: dict[str, Path],
) -> None:
    shutil.copy2(
        outputs["template"],
        WEB_DIR / "previews" / PREVIEW_NAMES[template],
    )
    if template == "scientific-paper" and "field-showcase" in outputs:
        shutil.copy2(
            outputs["field-showcase"],
            WEB_DIR / "previews" / "scientific-paper-field-showcase.pdf",
        )


def generate_release_metadata(packages: list[Path]) -> None:
    release_files = sorted(
        path for path in WEB_DIR.rglob("*")
        if path.is_file()
        and path.name not in {"SHA256SUMS", "release.json"}
    )

    checksums: list[str] = []
    records: list[dict[str, object]] = []

    for path in release_files:
        digest = hashlib.sha256(path.read_bytes()).hexdigest()
        relative = path.relative_to(WEB_DIR).as_posix()
        checksums.append(f"{digest}  {relative}")
        records.append({
            "path": relative,
            "sha256": digest,
            "bytes": path.stat().st_size,
        })

    (WEB_DIR / "SHA256SUMS").write_text(
        "\n".join(checksums) + "\n",
        encoding="utf-8",
    )

    metadata = {
        "name": CONFIG["release"]["name"],
        "version": CONFIG["release"]["version"],
        "build_model": {
            "preprocessor": "Builds and audits the complete web directory.",
            "web_host": "Serves the web directory as static files under Nginx.",
        },
        "templates": TEMPLATES,
        "packages": [path.name for path in packages],
        "files": records,
    }
    (WEB_DIR / "release.json").write_text(
        json.dumps(metadata, indent=2) + "\n",
        encoding="utf-8",
    )


def package_all(outputs: dict[str, dict[str, Path]]) -> list[Path]:
    packages: list[Path] = []
    for template in TEMPLATES:
        publish_previews(template, outputs[template])
        packages.append(package_template(template, outputs[template]))
    generate_release_metadata(packages)
    return packages


def run_privacy_audit() -> None:
    command = [sys.executable, str(ROOT / "tools" / "privacy_audit.py"), str(WEB_DIR)]
    process = subprocess.run(command, capture_output=True, text=True)
    if process.returncode != 0:
        fail(process.stdout + process.stderr)
    print(process.stdout.strip())


def smoke() -> None:
    prepare_assets()
    outputs = compile_template("scientific-paper")
    print("Scientific paper smoke test passed:")
    for name, path in outputs.items():
        print(f"  {name}: {path}")


def all_build() -> None:
    clean()
    prepare_assets()
    outputs = compile_all()
    copy_site()
    packages = package_all(outputs)
    run_privacy_audit()
    shutil.rmtree(BUILD_DIR, ignore_errors=True)

    print(f"Prepared clean web release: {WEB_DIR}")
    for package in packages:
        print(f"  {package.relative_to(ROOT)}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "command",
        choices=[
            "all", "clean", "assets", "compile", "paper",
            "packages", "site", "smoke",
        ],
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    if args.command == "all":
        all_build()
    elif args.command == "clean":
        clean()
    elif args.command == "assets":
        prepare_assets()
    elif args.command == "compile":
        clean()
        prepare_assets()
        compile_all()
    elif args.command == "paper":
        clean()
        prepare_assets()
        outputs = {"scientific-paper": compile_template("scientific-paper")}
        copy_site()
        publish_previews("scientific-paper", outputs["scientific-paper"])
        package_template("scientific-paper", outputs["scientific-paper"])
        generate_release_metadata(
            [WEB_DIR / "templates" / PACKAGE_NAMES["scientific-paper"]]
        )
        run_privacy_audit()
        shutil.rmtree(BUILD_DIR, ignore_errors=True)
    elif args.command == "packages":
        fail("Use `make all`; packages are created from a fresh successful build.")
    elif args.command == "site":
        copy_site()
    elif args.command == "smoke":
        smoke()
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"error: {exc}", file=sys.stderr)
        raise SystemExit(1)

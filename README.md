# GenesisL1 Community Publication Templates

An open repository of scientific and community publication formats aligned with the
character of GenesisL1.

The redesign preserves the existing six-format skeleton while concentrating current
development on scientific work in:

- blockchain;
- computer science;
- chemistry;
- biochemistry;
- biology.

## Editorial principle

> A supportive container, not a Procrustean bed.

The templates are structures for clearer communication, not rules for how every
scientist must think or write. Remove modules that do not serve the paper. Add
discipline-specific reporting, ethics, nomenclature, and data standards where required.

## Current formats

| Format | Default layout | Purpose |
|---|---|---|
| Scientific Paper | Two columns | Full original research |
| Community Letter | One column | Community communication |
| Scientific Review | One column | Literature and evidence synthesis |
| Scientific Letter | One column | Concise scientific contribution |
| Protocol / Method | One column | Reproducible procedures |
| Manual | One column | Operational guidance |

## Scientific-paper capabilities

The paper class includes:

- a structured abstract;
- evidence-calibrated language guidance;
- numbered equations and readable cross-references;
- chemistry notation and persistent compound numbering;
- language-aware code boxes without shell escape;
- single- and double-column figures;
- numerical sorted citations;
- optional data, model, execution, content-hash, and IPFS fields;
- the official GenesisL1 lockup on the first page only;
- text-only running headers after the first page.

## Repository structure

```text
.
├── assets/                 official press-kit assets and usage guidance
├── docs/                   authoring, tone, deployment, and release guidance
├── shared/                 shared style for single-column formats
├── templates/              six editable template families
├── site/                   source for the public template catalogue
├── tools/                  build, package, chemistry, and audit tools
├── tests/                  smoke-test fixtures
├── build/                  temporary compilation output
├── web/                    complete static Nginx deployment artifact
├── Makefile
└── release-manifest.toml
```

`build/` is temporary. `web/` is the only deployment artifact.

## Build

Reference environment:

- POSIX/Linux build host;
- Python 3.11 or later;
- GNU Make;
- TeX Live with pdfLaTeX and the packages listed in the scientific-paper README.

Build everything:

```bash
make all
```

The command:

1. starts from a clean build and web directory;
2. copies all official press-kit brand assets into each template;
3. compiles every template in an isolated build tree;
4. creates template ZIP packages and PDF previews;
5. excludes LaTeX logs and auxiliary files;
6. creates `SHA256SUMS` and `release.json`;
7. scans the release and nested ZIPs for likely private material;
8. removes the temporary build tree.

Focused scientific-paper build:

```bash
make paper
```

Clean:

```bash
make clean
```

## Two-device deployment

The preprocessing device builds and audits the complete `web/` directory. A separate
Nginx device receives only that directory and serves it read-only.

See [`docs/DEPLOYMENT.md`](docs/DEPLOYMENT.md).

## Optional chemistry preprocessing

The default build does not execute SMILES converters.

```bash
make chemistry-assets
```

This separate target requires Open Babel and generates reviewable SVG files plus a hash
manifest. Generated structures should be reviewed before publication.

## Official assets

The source assets under `assets/brand/` come from the GenesisL1 July 2026 press-media
kit. Use is governed by `assets/guidance/ASSET_USAGE.md`; logos and marks are not
relicensed under this repository's MIT licence.

## Scientific boundary

Exact identifiers, hashes, public ordering, and deterministic execution can improve
inspection and provenance. They do not establish scientific validity, data quality,
lawful rights, safety, clinical relevance, or regulatory acceptance.

## Status

Version 3.0 is a migration-safe redesign proposal for the public repository. It does not
rewrite Git history and should be reviewed through a normal branch and pull request.

## Optional manuscript language review

```bash
make lint FILE=path/to/manuscript.tex
```

The linter is advisory by default. It highlights claim-strength and literature-comparison
phrases for human review; it does not decide scientific validity or style.

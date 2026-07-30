# GenesisL1 Community Publication Templates

A proposed open repository of scientific and community publication formats aligned with the character of GenesisL1.

The repository contains six independent document families:

1. Scientific Paper
2. Community Letter
3. Scientific Review
4. Scientific Letter
5. Protocol / Method Description
6. Manual

The templates share one publication layer while preserving the freedom of each discipline, author, and community contributor.

## Editorial principle

These templates are supportive containers, not rigid standards.

Use only the sections that improve communication. Remove sections that do not serve the document. Add disciplinary requirements where needed. GenesisL1 alignment comes from clarity, provenance, version identity, reproducibility where appropriate, and honest claim boundaries.

## Repository structure

```text
genesisl1-community-publication-templates/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CHANGELOG.md
├── Makefile
├── assets/
│   └── README.md
├── docs/
│   ├── architecture.md
│   ├── template-specification.md
│   └── status-vocabulary.md
├── shared/
│   └── genesisl1-publication.sty
├── templates/
│   ├── scientific-paper/
│   ├── community-letter/
│   ├── scientific-review/
│   ├── scientific-letter/
│   ├── protocol-method/
│   └── manual/
└── web/
    └── index.html
```

## Compile a template

From the repository root:

```bash
make scientific-paper
make community-letter
make scientific-review
make scientific-letter
make protocol-method
make manual
```

Or compile manually:

```bash
cd templates/scientific-paper
pdflatex template.tex
pdflatex template.tex
```

Use BibTeX or Biber only after adding citations.

## Official GenesisL1 logo

The templates expect the official GenesisL1 navy lockup at:

```text
assets/genesisl1-lockup-navy.pdf
```

Keep the official SVG as the editable master and export a tightly cropped PDF for LaTeX. The templates use a text-only `GenesisL1` fallback when the logo file is absent. They do not draw or reconstruct an unofficial replacement mark.

## HTML catalogue

Open:

```text
web/index.html
```

The page proposes the eventual community-facing template catalogue and links each document type to its package and preview.

## Status

This repository is a proposal for community review. It is not an official scientific publishing standard and does not prescribe how community members must write.

## Licence

Template code and documentation are provided under the MIT License unless an individual document states otherwise. Example scientific content may be released under CC BY 4.0.

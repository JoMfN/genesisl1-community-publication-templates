# GenesisL1 Scientific Paper Template

A full-length, discipline-neutral scientific paper template. It supports experimental,
computational, theoretical, data, systems, replication, and negative-result papers.
GenesisL1-specific provenance fields are optional.

## Package contents

- `template.tex` - editable LaTeX source.
- `template.pdf` - compiled preview.
- `genesisl1-publication.sty` - shared GenesisL1 publication style.
- `references.bib` - starter bibliography.
- `SOURCES.md` - design and editorial basis.
- `assets/README.md` - official logo instructions.

## Compile

```bash
latexmk -pdf template.tex
```

Standard repeated `pdflatex` runs also work.

## Official logo

The template is wired for the official GenesisL1 navy lockup. Export the official SVG as
`assets/genesisl1-lockup-navy.pdf`. Until that file is present, the preview uses a text-only
GenesisL1 fallback and never draws an unofficial replacement mark.

## Editorial principle

This is a supportive structure, not a judgement about how contributors must think or write.
Delete sections that do not serve the document. Add disciplinary requirements where needed.
Clearly distinguish direct evidence, interpretation, limitations, and future work when that
distinction improves understanding.

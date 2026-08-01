# GenesisL1 Protocol and Method Description Template

A reproducibility-centred template for laboratory protocols, computational workflows, smart-contract methods, validation procedures and community procedures.

## Package contents

- `template.tex` - editable LaTeX source.
- `template.pdf` - compiled preview.
- `genesisl1-publication.sty` - shared GenesisL1 publication style.
- `references.bib` - starter bibliography.
- `SOURCES.md` - design and editorial basis.
- `assets/README.md` - official logo instructions.

## Compile

```bash
pdflatex template.tex
pdflatex template.tex
```

Use BibTeX or Biber only after adding citations.

## Official logo

The template is wired for the official GenesisL1 navy lockup. The build copies the official press-kit brand directory into `assets/brand/`. Until that file is present, the preview uses a text-only
GenesisL1 fallback and never draws an unofficial replacement mark.

## Editorial principle

This is a supportive structure, not a judgement about how contributors must think or write.
Delete sections that do not serve the document. Add disciplinary requirements where needed.
Clearly distinguish direct evidence, interpretation, limitations, and future work when that
distinction improves understanding.

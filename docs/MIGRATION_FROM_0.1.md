# Migration from the public 0.1 repository

The public repository already contains the six template families, a shared style,
documentation, a Makefile, and a web catalogue. Version 3.0 keeps that structure but
changes how the scientific paper and public release are built.

## Recommended Git workflow

Do not rewrite the public `main` history.

```bash
git clone https://github.com/JoMfN/genesisl1-community-publication-templates.git
cd genesisl1-community-publication-templates
git switch -c redesign/v3-scientific-paper
```

Copy the reviewed version-3 files into the branch, then run:

```bash
make all
git status
```

Review:

- source changes;
- compiled previews under `web/previews/`;
- ZIP contents under `web/templates/`;
- `web/SHA256SUMS`;
- `web/release.json`;
- the privacy-audit result.

Commit in reviewable stages:

```text
1. docs: record annotated scientific-writing feedback
2. assets: add official press-kit brand assets and guidance
3. paper: add two-column cross-field scientific-paper class
4. build: add isolated compilation, packaging, and audit
5. web: generate static deployment catalogue
```

Open a normal pull request into `main`.

## Compatibility notes

- The six public template directories remain.
- Non-paper formats remain single-column.
- The scientific paper changes from a shared article style to `genesisl1-paper.cls`.
- The official logo moves to `assets/brand/` and appears only on the first paper page.
- `web/` becomes generated deployment output; `site/` becomes its editable source.
- ZIP packages are generated from an allowlist and no longer copy LaTeX intermediates.
- The Nginx host receives only `web/`.

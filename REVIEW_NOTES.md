# Review notes for version 3.0

## Implemented

- Preserved the six public template families.
- Rebuilt the scientific paper as a two-column class.
- Limited the official logo to the first page.
- Added field profiles for blockchain, computer science, chemistry, biochemistry,
  and biology.
- Added structured abstracts and evidence-language guidance.
- Added standard numbered equations and `cleveref` references.
- Added `mhchem`, `chemfig`, `chemnum`, schemes, and persistent compound numbering.
- Added framed, language-aware code listings without shell escape.
- Added full-width figures and tables.
- Added optional content-hash and IPFS fields.
- Copied all official press-kit brand assets into every template during `make all`.
- Compiled in an isolated temporary directory.
- Removed LaTeX intermediates from the release.
- Created clean ZIP packages, previews, checksums, and a JSON release manifest.
- Added nested-ZIP privacy auditing.
- Documented a two-device build and Nginx deployment model.

## Intentionally not implemented

- No Git history was rewritten.
- No commit or pull request was made to the public repository.
- No publisher template was redistributed.
- No SMILES converter runs during `make all`.
- No IPFS upload is performed; fields are placeholders for later integration.
- No live Nginx host was modified.

## Validation performed

- `make all` completed successfully.
- All six template PDFs compiled with pdfLaTeX.
- The scientific field showcase compiled as a two-page, two-column PDF.
- Equation, scheme, listing, and wide-figure references resolved.
- The official logo appeared only in first-page front matter.
- The privacy/release audit passed for the complete generated `web/` tree and all
  nested ZIP packages.

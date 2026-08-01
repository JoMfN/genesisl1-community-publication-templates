# Repository architecture

## Source and output separation

```text
assets/       official source assets and guidance
templates/    editable manuscript sources
site/         static website source
tools/        build, packaging, chemistry preprocessing, and audit tools
build/        temporary local compilation tree
web/          complete static deployment artifact
```

`build/` is disposable. `web/` is reproducible.

## Template policy

- Scientific Paper: two columns by default.
- Community Letter: single column.
- Scientific Review: single column.
- Scientific Letter: single column.
- Protocol / Method: single column.
- Manual: single column.

## Field focus

Current scientific-paper profiles are limited to blockchain, computer science,
chemistry, biochemistry, and biology.

## Trust boundary

Exact identifiers, hashes, ledger references, or IPFS CIDs can make artifacts and
execution histories easier to inspect. They do not establish scientific validity, data
quality, lawful rights, safety, clinical relevance, or regulatory acceptance.

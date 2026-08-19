# Contributing

Contributions are welcome from scientists, developers, writers, designers, and
community members.

## Review principle

Review the document, not the dignity or competence of its author.

Suggested changes should explain the reader benefit. Do not present one journal,
discipline, statistical method, or writing style as universally correct.

## Scientific tone

Please read:

- `docs/SCIENTIFIC_TONE.md`
- `docs/AUTHORING_GUIDE.md`
- `docs/MANUSCRIPT_CHECKLIST.md`

## Repository changes

A pull request should state:

1. the document format or field affected;
2. the communication problem;
3. whether the change is required, recommended, or optional;
4. compatibility implications;
5. a minimal compiling example;
6. whether generated web packages change.

## Build requirements

Before requesting review:

```bash
make all
```

The build and privacy audit must pass. Do not commit LaTeX auxiliary files, private
datasets, credentials, wallet material, local environment files, or user-home paths.

## Publisher references

External publisher templates may inform the design, but should not be copied into this
repository unless redistribution rights are explicit. Implement publisher-neutral
features and cite the reference in documentation.

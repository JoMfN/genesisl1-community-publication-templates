# Publication architecture

## Purpose

The repository implements one shared publication layer and six document families.

The shared layer provides:

- visual identity;
- document metadata;
- lifecycle status;
- optional claim-status labels;
- evidence and interpretation blocks;
- limitations and uncertainty blocks;
- provenance and reproducibility blocks;
- verification-boundary language;
- official-logo handling.

The individual templates determine which modules appear by default.

## Core design rule

The system must distinguish between:

1. document identity;
2. evidence;
3. interpretation;
4. uncertainty;
5. reproducibility;
6. future work.

These distinctions are available when useful, not mandatory in every document.

## GenesisL1 trust boundary

GenesisL1 may establish public ordering, account authorisation, byte commitments, provenance, and deterministic execution under stated software and network assumptions.

These guarantees do not independently establish:

- scientific validity;
- data quality;
- lawful rights;
- safety;
- clinical efficacy;
- correctness of interpretation;
- off-chain availability.

## Shared component

The canonical shared style is:

```text
shared/genesisl1-publication.sty
```

Each template package contains a copy so it remains independently portable.

## Web catalogue

The standalone catalogue is:

```text
web/index.html
```

It is intentionally framework-free and can be opened directly in a browser.

# Annotated community feedback - August 2026

This document records the design intent behind repository version 3.0.

| Feedback | Interpretation | Implementation |
|---|---|---|
| “Our results provide evidence that…” | Supported interpretation, not proof | Evidence ladder in `SCIENTIFIC_TONE.md` |
| “This observation points towards…” | Preliminary indication only | Tone guide and manuscript examples |
| Do not diminish the techniques or results of others | Scientific comparison should be neutral and constructive | Literature-comparison examples |
| Start with a structured abstract | Improve consistency among purpose, methods, results, and conclusion | `GenesisStructuredAbstract` |
| Write Results in figure order | Improve traceability | Authoring guide and checklist |
| Methods and Results in past tense | Distinguish performed work from plans | Template prompts |
| Limitations near the end of Discussion | Keep limitations explicit without scattering them through the argument | Dedicated environment and guide |
| Logo only on the first page | Scientific manuscript first; GenesisL1 branding second | Text-only running headers |
| Scientific paper only is double column | Match dense scientific reading while preserving other document types | Separate `genesisl1-paper.cls` |
| Number equations and chemical compounds | Support mathematics and chemistry natively | `amsmath`, `cleveref`, `chemnum`, `mhchem`, `chemfig` |
| Format code by language | Support computer science and blockchain manuscripts | `GenesisCode` with `listings` |
| Figures may span both columns | Preserve legibility of complex diagrams | `figure*`, `GenesisWideFigure` |
| Leave room for IPFS | Future integration without requiring it | Optional CID and content-hash fields |
| Clean ZIP packages | Do not publish LaTeX debris or executor data | Isolated build, allowlisted package, audit |
| Use two devices | Separate trusted preprocessing from static serving | `DEPLOYMENT.md` |
| “A supportive container, not a Procrustean bed.” | Guidance must remain optional and field-sensitive | Repository-wide editorial principle |

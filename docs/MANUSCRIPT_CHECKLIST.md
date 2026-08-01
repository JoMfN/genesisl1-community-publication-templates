# Manuscript checklist

## Scientific question

- [ ] What is the central question or falsifiable hypothesis?
- [ ] What are aims 1, 2, and 3?
- [ ] How is the study distinct from the literature?
- [ ] What constitutes ground truth?

## Abstract and Results

- [ ] Is the abstract structured during drafting?
- [ ] Are the important numerical results included in the abstract?
- [ ] Do all abstract results appear in the Results section?
- [ ] Is their order consistent?
- [ ] Are Methods and Results written primarily in past tense?
- [ ] Are figures cited in numerical order?
- [ ] Are comparative claims supported by values and uncertainty?
- [ ] Are exclusions, dropouts, and failed runs stated?

## Discussion

- [ ] Are prior studies described neutrally?
- [ ] Is observation separated from interpretation?
- [ ] Does “provide evidence that” introduce an interpretation rather than a fact?
- [ ] Does “points towards” remain a preliminary indication?
- [ ] Are limitations near the end of the Discussion?
- [ ] Does the conclusion avoid new results or interpretations?

## Reproducibility

- [ ] Are exact data, software, model, and environment versions stated?
- [ ] Are code and data access conditions clear?
- [ ] Are content hashes, transaction references, or IPFS CIDs included only when useful?
- [ ] Is the scientific trust boundary stated where relevant?

## Release safety

- [ ] Were all `.aux`, `.log`, `.toc`, `.out`, `.bbl`, `.blg`, `.fls`,
      `.fdb_latexmk`, and SyncTeX files excluded?
- [ ] Does the ZIP contain no credentials, keys, wallets, local paths, or private datasets?
- [ ] Was `make all` run on the preprocessing device?
- [ ] Did the privacy audit pass?
- [ ] Is only the generated `/web/` directory transferred to the Nginx host?

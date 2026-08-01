# GenesisL1 Scientific Paper Template

A two-column scientific-paper template for work in:

- blockchain;
- computer science;
- chemistry;
- biochemistry;
- biology.

The official GenesisL1 lockup appears only in the first-page front matter. Subsequent
headers are text-only. The manuscript should remain a scientific paper, not a marketing
document.

## Compile

From this directory:

```bash
pdflatex template.tex
pdflatex template.tex
```

From the repository root:

```bash
make paper
```

The repository build is preferred because it copies the approved press-kit assets,
compiles in an isolated build directory, removes LaTeX intermediates, creates the ZIP
package, and audits the public `/web/` output.

## Class options

```latex
\documentclass[
  blockchain,
  computerscience,
  chemistry,
  biochemistry,
  biology
]{genesisl1-paper}
```

Remove unused options. The paper is two-column by default.

```latex
\documentclass[onecolumn,biology]{genesisl1-paper}
```

Use `onecolumn` only where the content or target journal requires it.

## Structured abstract

```latex
\begin{GenesisFrontMatter}
  \begin{GenesisStructuredAbstract}
    \AbstractBackground{...}
    \AbstractMethods{...}
    \AbstractResults{...}
    \AbstractConclusion{...}
  \end{GenesisStructuredAbstract}
\end{GenesisFrontMatter}
```

Draft toward approximately 250 words unless a target journal specifies another limit.

## Equations

Use ordinary numbered LaTeX equations and `cleveref` references:

```latex
\begin{equation}
  y = mx + c
  \label{eq:line}
\end{equation}

As shown in \cref{eq:line}, ...
```

## Code

The code boxes use `listings`; no shell escape is required.

```latex
\begin{GenesisCode}[
  language=Python,
  caption={Example analysis},
  label={lst:analysis}
]
result = analyse(data)
\end{GenesisCode}
```

Built-in examples include Python and Solidity. Standard `listings` languages such as
C++, Java, JavaScript, R, SQL, Bash, and Go may also be selected. JSON and Solidity
definitions are supplied by the class.

## Chemistry

The chemistry profile loads `mhchem`, `chemfig`, `chemnum`, and `chemmacros`.

```latex
\ce{ATP + H2O -> ADP + P_i + H+}
```

Persistent compound numbering:

```latex
\compound{candidate-a}
\compoundref{candidate-a}
```

Use `scheme` for a single-column scheme and `scheme*` for a scheme spanning both
columns.

### SMILES preprocessing

SMILES conversion is intentionally outside the default LaTeX build. It may invoke
external chemistry software and should remain a reviewable preprocessing step.

```bash
make chemistry-assets
```

This optional target uses Open Babel to create SVG files and a hash manifest. The
normal `make all` command never invokes Open Babel or shell escape.

## Figures

Single-column:

```latex
\begin{figure}
  \centering
  \includegraphics[width=\columnwidth]{figure.pdf}
  \caption{...}
  \label{fig:single}
\end{figure}
```

Double-column:

```latex
\begin{figure*}
  \centering
  \includegraphics[width=\textwidth]{wide-figure.pdf}
  \caption{...}
  \label{fig:wide}
\end{figure*}
```

The helper `GenesisWideFigure` is also available.

## Citations

The class uses numerical, sorted, compressed citations through `natbib` and readable
cross-references through `cleveref`.

```latex
Prior work established the method \citep{reference}.
\Cref{fig:wide} summarises the workflow.
```

## Optional IPFS fields

The class reserves optional fields without assuming that an IPFS publication already
exists:

```latex
\GenesisIPFSCID{bafy...}
\GenesisIPFSGateway{Optional resolver}
```

An IPFS CID identifies content; availability and scientific validity remain separate
questions.

## Principle

> A supportive container, not a Procrustean bed.

Delete modules that do not help the reader. Add field-specific reporting requirements
where appropriate.

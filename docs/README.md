# Documentation index

| Folder | What it is | Start at |
|---|---|---|
| [`guidelines/`](guidelines/README.md) | The project's coding standards for Unity 6000.3 — eleven documents, each with a ≤ 15-line TL;DR, rules with rationale, code examples, anti-patterns, a review checklist and links to the Unity sources. | [guidelines/README.md](guidelines/README.md) |
| [`reference/`](reference/README.md) | Offline Markdown snapshot of the official Unity documentation the guidelines are derived from: 6000.3 manual and Script Reference pages, Unity 6 e-books (extracted text), unity.com how-to articles, Unity Learn tutorials, Unity GitHub files. Grouped by topic; every file records its `source_url`. | [reference/README.md](reference/README.md) |
| [`reference/_tools/`](reference/_tools/README.md) | Scripts and the source manifest used to build and refresh the reference library. | [reference/_tools/README.md](reference/_tools/README.md) |

The entry point for agents and teammates is the repository root [`AGENTS.md`](../AGENTS.md) (`CLAUDE.md` includes it). It carries the 20 non-negotiable rules and links down to each guideline; each guideline links down to the reference files it is based on.

```
AGENTS.md  ──►  docs/guidelines/README.md  ──►  docs/guidelines/NN-*.md  ──►  docs/reference/<topic>/*.md  ──►  source_url (unity.com / docs.unity3d.com)
```

## Maintaining the docs

- A guideline changes only together with the code/asset convention it describes; update the owning guideline, then `AGENTS.md` if one of the non-negotiables moved.
- Keep every rule traceable: a normative rule links to a reference file or is marked **[project decision]**.
- To add Unity documentation to the reference library, edit `reference/_tools/manifest.json` and run the commands in [`reference/_tools/README.md`](reference/_tools/README.md); then regenerate `reference/README.md`.

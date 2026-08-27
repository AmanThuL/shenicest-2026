# Reference library tooling

Scripts that built [`docs/reference/`](../README.md). They need Python 3.11+ and [`uv`](https://docs.astral.sh/uv/) (for one-off dependencies) plus `pandoc` on the PATH.

| File | Purpose |
|---|---|
| `manifest.json` | The curated source list: URL, title, topic, priority (`must` / `should` / `nice`), whether the publisher is Unity, and why the page matters. Edit this to add or remove sources. |
| `results.json` | What the last run produced for each manifest entry (local path, word count, PDF page count, warnings). `build_index.py` reads it. |
| `fetch_doc.py` | Fetch one URL and convert it to Markdown with YAML front matter (HTML via pandoc → GFM; PDFs via `pypdf` text extraction). |
| `fetch_batch.py` | Fetch every manifest entry into `<topic>/<slug>.md`, skipping files that already exist. |
| `build_index.py` | Regenerate `docs/reference/README.md` from `results.json` (plus a static "Third-party references" section). |
| `build_odin_reference.py` | Generate `docs/reference/third-party/odin-inspector/{attributes,support-types,editor-api,serialization}.md` from the XML docs next to the Odin DLLs in `Assets/Plugins/Sirenix/Assemblies/`. Standard library only: `python3 docs/reference/_tools/build_odin_reference.py` from the repo root. Re-run after every Odin upgrade. |

## Refresh or extend the library

```bash
cd docs/reference/_tools
# 1. add entries to manifest.json (url, title, topic, kind, official, priority, why)
# 2. download anything that is missing (existing files are skipped; add --force to refetch everything)
uv run --quiet --with trafilatura,beautifulsoup4,lxml,requests,pypdf \
    fetch_batch.py manifest.json .. results.json --workers 4
# 3. rebuild the index
python3 build_index.py results.json ..
```

Notes from the original run (2026-08-23):

- `docs.unity3d.com` rate-limits bursts with HTTP 429 — keep `--workers` at 4–6.
- `unity.com`, `learn.unity.com` and `cdn.bfldr.com` require a browser `User-Agent`; the scripts send one.
- Unity e-books on `unity.com/resources/...` are behind a form, but the landing-page HTML embeds the direct `cdn.bfldr.com` PDF link (`grep -oE 'https://cdn\.bfldr\.com/[^"\\ ]+\.pdf'` after un-escaping `\/`).
- PDFs are written next to their `.md` text extraction; the original run moved them into `../_ebooks-pdf/` (git-ignored, ~300 MB). To get the PDFs again, run the batch with `--force` on the `kind: "pdf"` entries or download the `source_url` in each `ebook-*.md` front matter.

Notes from the HDRP run (2026-08-27, topic `rendering-hdrp`):

- Package manuals on `docs.unity3d.com/Packages/...` use the DocFX layout: the body is `<article id="_content">` (matched by the existing `article` selector) and the sidebar TOC lives in a separate `toc.html` next to `index.html` — fetch that to enumerate a package manual instead of guessing page names. Pages whose article is shorter than ~400 characters fall back to `<body>`, which leaked the DocFX "Show / Hide Table of Contents" toggle; `div.sidenav` was added to `NOISE_SELECTORS` for that.
- The topic was registered over three incremental batch runs with `--workers 4` (no 429s): run 1 fetched the initial 145 entries; run 2 refetched `getting-started-in-hdrp` after the selector fix and added the Manual's `class-TerrainLayer.html`; run 3 verified the new skipped-entry metadata carry-over in `fetch_batch.py`. Because run 2 predated that carry-over, the run-1 entries had lost their `kind`/`words` in `results.json` and were backfilled from the files on disk afterwards, so `results.json` records `kind` + `words` for every `rendering-hdrp` entry as if fetched fresh. Dropped after inspection: `Feature-Comparison.html` (65-word stub that only links to the Manual's `render-pipelines-feature-comparison.html`, already under `rendering-urp/`) and `getting-started-in-hdrp.html` (73-word landing table). Final count: 144 documents — 140 HTML pages plus four `com.unity.template-hd` assets from the Graphics repo.

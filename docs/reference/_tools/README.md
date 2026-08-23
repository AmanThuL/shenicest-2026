# Reference library tooling

Scripts that built [`docs/reference/`](../README.md). They need Python 3.11+ and [`uv`](https://docs.astral.sh/uv/) (for one-off dependencies) plus `pandoc` on the PATH.

| File | Purpose |
|---|---|
| `manifest.json` | The curated source list: URL, title, topic, priority (`must` / `should` / `nice`), whether the publisher is Unity, and why the page matters. Edit this to add or remove sources. |
| `results.json` | What the last run produced for each manifest entry (local path, word count, PDF page count, warnings). `build_index.py` reads it. |
| `fetch_doc.py` | Fetch one URL and convert it to Markdown with YAML front matter (HTML via pandoc → GFM; PDFs via `pypdf` text extraction). |
| `fetch_batch.py` | Fetch every manifest entry into `<topic>/<slug>.md`, skipping files that already exist. |
| `build_index.py` | Regenerate `docs/reference/README.md` from `results.json`. |

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

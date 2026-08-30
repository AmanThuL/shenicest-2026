#!/usr/bin/env python3
"""Download a manifest of documentation sources into docs/reference/<topic>/<slug>.md.

Usage:
    uv run --quiet --with trafilatura,beautifulsoup4,lxml,requests,pypdf \
        fetch_batch.py <manifest.json> <reference_root> <results.json> [--workers 6]

manifest.json: [{"url": ..., "title": ..., "topic": ..., "kind": ..., "slug": optional, ...}, ...]
Each entry is fetched with fetch_doc's logic; existing outputs are skipped unless --force.
"""
from __future__ import annotations

import datetime as _dt
import json
import re
import sys
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from urllib.parse import urlparse, unquote

sys.path.insert(0, str(Path(__file__).parent))
import fetch_doc  # noqa: E402


def slugify(text: str) -> str:
    text = unquote(text)
    text = re.sub(r"\.(html?|pdf|md)$", "", text, flags=re.I)
    text = re.sub(r"[^A-Za-z0-9]+", "-", text).strip("-").lower()
    return text[:80] or "page"


def slug_for(entry: dict) -> str:
    if entry.get("slug"):
        return slugify(entry["slug"])
    path = urlparse(entry["url"]).path.rstrip("/")
    parts = [p for p in path.split("/") if p]
    if "docs.unity3d.com" in entry["url"]:
        # Manual/ScriptReference/Packages pages: keep section + page name
        if "ScriptReference" in parts:
            return "scriptref-" + slugify(parts[-1])
        if "Packages" in parts:
            pkg_full = next((p for p in parts if p.startswith("com.unity")), "pkg@0")
            pkg, _, version = pkg_full.partition("@")
            pkg = pkg.replace("com.unity.", "")
            idx = parts.index(pkg_full)
            # keep sub-folders below manual/ (e.g. TextMeshPro/index.html) so names stay unique
            sub = [p for p in parts[idx + 1:-1] if p not in ("manual", "api")]
            return slugify("-".join([pkg, version] + sub + [parts[-1]]))
        return "manual-" + slugify(parts[-1])
    if "cdn.bfldr.com" in entry["url"]:
        return "ebook-" + slugify(parts[-1])[:70]
    if "raw.githubusercontent.com" in entry["url"]:
        return "github-" + slugify("-".join(parts[1:2] + parts[-1:]))
    if "unity.com" in entry["url"]:
        section = parts[0] if parts else "page"
        return slugify(section + "-" + parts[-1]) if len(parts) > 1 else slugify(parts[-1])
    return slugify(urlparse(entry["url"]).netloc.replace("www.", "") + "-" + (parts[-1] if parts else "index"))


def process(entry: dict, root: Path, force: bool) -> dict:
    topic = slugify(entry.get("topic") or "misc")
    slug = slug_for(entry)
    out = root / topic / slug
    md_path = out.with_suffix(".md")
    result = {"url": entry["url"], "title": entry.get("title"), "topic": topic, "slug": slug,
              "official": entry.get("official"), "priority": entry.get("priority"), "why": entry.get("why"),
              "md": str(md_path.relative_to(root))}
    if md_path.exists() and not force:
        result.update(ok=True, skipped=True)
        return result
    try:
        resp = fetch_doc.fetch(entry["url"])
    except Exception as exc:  # noqa: BLE001
        result.update(ok=False, error=str(exc))
        return result
    out.parent.mkdir(parents=True, exist_ok=True)
    today = _dt.date.today().isoformat()
    ctype = resp.headers.get("content-type", "").lower()
    is_pdf = "application/pdf" in ctype or resp.content[:5] == b"%PDF-"
    title = entry.get("title") or slug
    if is_pdf:
        pdf_path = out.with_suffix(".pdf")
        pdf_path.write_bytes(resp.content)
        try:
            text, n_pages = fetch_doc.pdf_to_text(resp.content)
        except Exception as exc:  # noqa: BLE001
            text, n_pages = f"(text extraction failed: {exc})\n", 0
        md_path.write_text(
            fetch_doc.frontmatter(title=title, source_url=entry["url"], final_url=resp.url, topic=topic,
                                  publisher="Unity Technologies" if entry.get("official", True) else "third-party",
                                  fetched=today, kind="pdf-text", pages=n_pages, pdf_file=pdf_path.name)
            + f"# {title}\n\n" + text, encoding="utf-8")
        result.update(ok=True, kind="pdf", pages=n_pages, bytes=len(resp.content), pdf=str(pdf_path.relative_to(root)),
                      words=len(text.split()))
    elif "raw.githubusercontent.com" in entry["url"] and not entry["url"].lower().endswith((".md", ".markdown")):
        # Source files (e.g. .cs style guide): wrap verbatim in a fenced block.
        lang = Path(urlparse(entry["url"]).path).suffix.lstrip(".") or "text"
        body = resp.text
        md_path.write_text(
            fetch_doc.frontmatter(title=title, source_url=entry["url"], final_url=resp.url, topic=topic,
                                  publisher="Unity Technologies" if entry.get("official", True) else "third-party",
                                  fetched=today, kind="source")
            + f"# {title}\n\n```{lang}\n{body}\n```\n", encoding="utf-8")
        result.update(ok=True, kind="source", words=len(body.split()))
    elif "raw.githubusercontent.com" in entry["url"]:
        body = resp.text
        md_path.write_text(
            fetch_doc.frontmatter(title=title, source_url=entry["url"], final_url=resp.url, topic=topic,
                                  publisher="Unity Technologies" if entry.get("official", True) else "third-party",
                                  fetched=today, kind="markdown")
            + body, encoding="utf-8")
        result.update(ok=True, kind="markdown", words=len(body.split()))
    else:
        page_title, md = fetch_doc.html_to_markdown(resp.text, entry["url"])
        body = md.strip()
        if not body.lstrip().startswith("#"):
            body = f"# {page_title or title}\n\n{body}"
        md_path.write_text(
            fetch_doc.frontmatter(title=title, page_title=page_title, source_url=entry["url"], final_url=resp.url,
                                  topic=topic,
                                  publisher="Unity Technologies" if entry.get("official", True) else "third-party",
                                  fetched=today, kind="html")
            + body + "\n", encoding="utf-8")
        words = len(body.split())
        result.update(ok=True, kind="html", words=words)
        if words < 150:
            result["warning"] = "thin content"
    return result


def main() -> int:
    args = sys.argv[1:]
    manifest_path, root, results_path = Path(args[0]), Path(args[1]), Path(args[2])
    workers = int(args[args.index("--workers") + 1]) if "--workers" in args else 6
    force = "--force" in args
    entries = json.loads(manifest_path.read_text())
    # Entries whose file already exists are skipped; keep the kind/words/pages recorded by the run that
    # fetched them so build_index.py does not lose e-book page counts on incremental runs.
    previous: dict[str, dict] = {}
    if results_path.exists():
        previous = {r["url"]: r for r in json.loads(results_path.read_text()) if r.get("ok")}
    results: list[dict] = []
    with ThreadPoolExecutor(max_workers=workers) as pool:
        futures = {pool.submit(process, e, root, force): e for e in entries}
        for fut in as_completed(futures):
            r = fut.result()
            if r.get("skipped") and r["url"] in previous:
                r = {**previous[r["url"]], **r}
            results.append(r)
            status = "ok" if r.get("ok") else "FAIL"
            extra = r.get("error") or r.get("warning") or ""
            print(f"[{status}] {r['topic']}/{r['slug']}  words={r.get('words', '-')} {extra}", flush=True)
    results.sort(key=lambda r: (r["topic"], r["slug"]))
    results_path.write_text(json.dumps(results, indent=2, ensure_ascii=False))
    ok = sum(1 for r in results if r.get("ok"))
    print(f"done: {ok}/{len(results)} ok")
    return 0


if __name__ == "__main__":
    sys.exit(main())

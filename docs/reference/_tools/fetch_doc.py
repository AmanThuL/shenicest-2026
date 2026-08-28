#!/usr/bin/env python3
"""Fetch a documentation URL and save it as clean Markdown (or PDF + extracted text).

Usage:
    uv run --quiet --with trafilatura,beautifulsoup4,lxml,requests,pypdf \
        fetch_doc.py <url> <out_path_without_extension> [--title "..."] [--topic "..."]

Writes:
    <out>.md            for HTML pages (frontmatter + markdown body)
    <out>.pdf + <out>.md  for PDFs (md = extracted text with frontmatter)

Prints a single JSON line describing the result.
"""
from __future__ import annotations

import datetime as _dt
import io
import json
import re
import subprocess
import sys
from pathlib import Path

import requests
from bs4 import BeautifulSoup

UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
    "(KHTML, like Gecko) Chrome/124.0 Safari/537.36"
)

# Content containers, tried in order, per host family.
CONTENT_SELECTORS = [
    "div#content-wrap div.content",  # docs.unity3d.com manual/scriptref
    "div.content-block",
    "main article",
    "article",
    "main",
    "div[role=main]",
]

NOISE_SELECTORS = [
    "nav",
    "header",
    "footer",
    "script",
    "style",
    "noscript",
    "svg",
    "iframe",
    "form",
    "div.sidebar",
    "div#sidebar",
    "div.sidenav",  # DocFX package docs: "Show / Hide Table of Contents" toggle + sidetoc
    "div.breadcrumbs",
    "div.feedbackbox",
    "div.footer-wrapper",
    "div.nextprev",
    "div.mCustomScrollbar",
    "div.otherversionscontent",
    "div.lang-switcher",
    "div.version-switcher",
    "[class*=cookie]",
    "[class*=Cookie]",
    "[id*=cookie]",
    "[class*=newsletter]",
    "[class*=Newsletter]",
    "[class*=share]",
    "[class*=Share]",
    "[class*=related-content]",
    "[class*=RelatedContent]",
]


def fetch(url: str) -> requests.Response:
    resp = requests.get(url, headers={"User-Agent": UA, "Accept": "*/*"}, timeout=60, allow_redirects=True)
    resp.raise_for_status()
    return resp


def html_to_markdown(html: str, url: str) -> tuple[str, str]:
    """Return (title, markdown). Extracts the main content container, strips noise,
    then converts with pandoc (gfm). Falls back to trafilatura when pandoc output is thin."""
    soup = BeautifulSoup(html, "lxml")
    title = (soup.title.string or "").strip() if soup.title and soup.title.string else ""
    title = re.sub(r"\s*[|\-–]\s*Unity.*$", "", title).strip() or title

    container = None
    for sel in CONTENT_SELECTORS:
        found = soup.select_one(sel)
        if found and len(found.get_text(" ", strip=True)) > 400:
            container = found
            break
    if container is None:
        container = soup.body or soup

    for sel in NOISE_SELECTORS:
        for node in container.select(sel):
            node.decompose()

    # docs.unity3d.com wraps glossary terms in tooltip spans; keep the term, drop the popup.
    for node in container.select("span.tooltiptext, a.tooltipMoreInfoLink, span.tooltipGlossaryLink"):
        node.decompose()
    for node in container.select("span.tooltip"):
        node.unwrap()

    # Make relative links absolute so references stay usable offline.
    from urllib.parse import urljoin

    for a in container.find_all("a", href=True):
        a["href"] = urljoin(url, a["href"])
    for img in list(container.find_all("img")):
        src = img.get("src", "")
        if not src or src.startswith("data:") or "_next/image" in src:
            img.decompose()
            continue
        alt = img.get("alt", "")
        img.attrs = {"src": urljoin(url, src), "alt": alt}

    fragment = str(container)
    md = pandoc(fragment)
    if len(md.strip()) < 400:
        md = trafilatura_md(html, url) or md
    return title, md


def pandoc(html_fragment: str) -> str:
    proc = subprocess.run(
        ["pandoc", "-f", "html", "-t", "gfm", "--wrap=none", "--strip-comments"],
        input=html_fragment.encode("utf-8"),
        capture_output=True,
        check=False,
    )
    out = proc.stdout.decode("utf-8", errors="replace")
    # pandoc emits {.class} attrs and <div> wrappers in gfm; tidy the common ones.
    out = re.sub(r"<div[^>]*>|</div>", "", out)
    out = re.sub(r"\{[^}]*\}\s*$", "", out, flags=re.M)
    out = re.sub(r"\n{3,}", "\n\n", out)
    return out.strip() + "\n"


def trafilatura_md(html: str, url: str) -> str | None:
    try:
        import trafilatura

        return trafilatura.extract(
            html,
            url=url,
            output_format="markdown",
            include_formatting=True,
            include_tables=True,
            include_links=True,
            include_images=False,
        )
    except Exception:  # noqa: BLE001
        return None


def pdf_to_text(data: bytes) -> tuple[str, int]:
    from pypdf import PdfReader

    reader = PdfReader(io.BytesIO(data))
    pages = []
    for i, page in enumerate(reader.pages, 1):
        text = page.extract_text() or ""
        pages.append(f"\n\n<!-- page {i} -->\n\n{text.strip()}")
    return "".join(pages).strip() + "\n", len(reader.pages)


def frontmatter(**fields: object) -> str:
    lines = ["---"]
    for key, value in fields.items():
        if value is None or value == "":
            continue
        text = str(value).replace('"', "'")
        lines.append(f'{key}: "{text}"')
    lines.append("---")
    return "\n".join(lines) + "\n\n"


def main() -> int:
    args = sys.argv[1:]
    if len(args) < 2:
        print(__doc__)
        return 2
    url, out = args[0], args[1]
    title_override = topic = None
    i = 2
    while i < len(args):
        if args[i] == "--title":
            title_override = args[i + 1]
            i += 2
        elif args[i] == "--topic":
            topic = args[i + 1]
            i += 2
        else:
            i += 1

    out_path = Path(out)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    today = _dt.date.today().isoformat()

    try:
        resp = fetch(url)
    except Exception as exc:  # noqa: BLE001
        print(json.dumps({"ok": False, "url": url, "error": str(exc)}))
        return 1

    ctype = resp.headers.get("content-type", "").lower()
    is_pdf = "application/pdf" in ctype or resp.content[:5] == b"%PDF-"
    result: dict[str, object] = {"ok": True, "url": url, "final_url": resp.url, "content_type": ctype}

    if is_pdf:
        pdf_path = out_path.with_suffix(".pdf")
        pdf_path.write_bytes(resp.content)
        try:
            text, n_pages = pdf_to_text(resp.content)
        except Exception as exc:  # noqa: BLE001
            text, n_pages = f"(text extraction failed: {exc})\n", 0
        title = title_override or pdf_path.stem.replace("-", " ").title()
        md_path = out_path.with_suffix(".md")
        md_path.write_text(
            frontmatter(title=title, source_url=url, final_url=resp.url, topic=topic, fetched=today,
                        kind="pdf-text", pages=n_pages, pdf_file=pdf_path.name)
            + f"# {title}\n\n" + text,
            encoding="utf-8",
        )
        result.update(kind="pdf", pdf=str(pdf_path), md=str(md_path), pages=n_pages, bytes=len(resp.content))
    else:
        html = resp.text
        title, md = html_to_markdown(html, url)
        title = title_override or title or out_path.stem
        md_path = out_path.with_suffix(".md")
        body = md.strip()
        if not body.lstrip().startswith("#"):
            body = f"# {title}\n\n{body}"
        md_path.write_text(
            frontmatter(title=title, source_url=url, final_url=resp.url, topic=topic, fetched=today, kind="html") + body + "\n",
            encoding="utf-8",
        )
        words = len(body.split())
        result.update(kind="html", md=str(md_path), title=title, words=words)
        if words < 150:
            result["warning"] = "very little text extracted; page may be JS-rendered or blocked"

    print(json.dumps(result, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    sys.exit(main())

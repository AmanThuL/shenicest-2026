#!/usr/bin/env python3
"""Generate docs/reference/third-party/odin-inspector/*.md from the XML documentation
files that ship with the Odin Inspector DLLs in Assets/Plugins/Sirenix/Assemblies/.

The output is version-exact for the Odin build installed in the project, which makes it
the source of truth for guideline 12 (docs/guidelines/12-odin-inspector.md). Re-run after
every Odin upgrade.

Usage (from the repository root):
    python3 docs/reference/_tools/build_odin_reference.py

Only the Python standard library is used.
"""
from __future__ import annotations

import datetime as _dt
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
ASSEMBLIES = ROOT / "Assets" / "Plugins" / "Sirenix" / "Assemblies"
VERSION_FILE = ROOT / "Assets" / "Plugins" / "Sirenix" / "Odin Inspector" / "Version.txt"
OUT = ROOT / "docs" / "reference" / "third-party" / "odin-inspector"

ATTRIBUTES_XML = ASSEMBLIES / "Sirenix.OdinInspector.Attributes.xml"
EDITOR_XML = ASSEMBLIES / "Sirenix.OdinInspector.Editor.xml"
SERIALIZATION_XML = ASSEMBLIES / "Sirenix.Serialization.xml"

# Editor types worth documenting for project editor tooling (SheNicest.Editor only).
EDITOR_TYPES = [
    "Sirenix.OdinInspector.Editor.OdinEditorWindow",
    "Sirenix.OdinInspector.Editor.OdinMenuEditorWindow",
    "Sirenix.OdinInspector.Editor.OdinMenuTree",
    "Sirenix.OdinInspector.Editor.OdinMenuItem",
    "Sirenix.OdinInspector.Editor.OdinMenuStyle",
    "Sirenix.OdinInspector.Editor.OdinMenuTreeSelection",
    "Sirenix.OdinInspector.Editor.OdinMenuTreeExtensions",
    "Sirenix.OdinInspector.Editor.OdinMenuTreeDrawingConfig",
    "Sirenix.OdinInspector.Editor.OdinEditor",
    "Sirenix.OdinInspector.Editor.OdinValueDrawer`1",
    "Sirenix.OdinInspector.Editor.OdinAttributeDrawer`1",
    "Sirenix.OdinInspector.Editor.OdinAttributeDrawer`2",
    "Sirenix.OdinInspector.Editor.OdinGroupDrawer`1",
    "Sirenix.OdinInspector.Editor.OdinAttributeProcessor",
    "Sirenix.OdinInspector.Editor.OdinAttributeProcessor`1",
    "Sirenix.OdinInspector.Editor.InspectorProperty",
    "Sirenix.OdinInspector.Editor.PropertyTree",
    "Sirenix.OdinInspector.Editor.Validation.RegisterValidatorAttribute",
]

# Serialization types: documented so agents can recognise what guideline 12 forbids.
SERIALIZATION_TYPES = [
    "Sirenix.OdinInspector.SerializedMonoBehaviour",
    "Sirenix.OdinInspector.SerializedScriptableObject",
    "Sirenix.OdinInspector.SerializedBehaviour",
    "Sirenix.OdinInspector.SerializedComponent",
    "Sirenix.OdinInspector.SerializedStateMachineBehaviour",
    "Sirenix.OdinInspector.SerializedUnityObject",
    "Sirenix.Serialization.OdinSerializeAttribute",
    "Sirenix.Serialization.PreviouslySerializedAsAttribute",
    "Sirenix.Serialization.SerializationUtility",
    "Sirenix.Serialization.UnitySerializationUtility",
]


def _text(node: ET.Element | None) -> str:
    """Render an XML doc node (summary/remarks/param/...) as Markdown."""
    if node is None:
        return ""
    parts: list[str] = []

    def walk(el: ET.Element, top: bool) -> None:
        if el.text:
            parts.append(el.text)
        for child in el:
            tag = child.tag
            if tag == "para":
                parts.append("\n\n")
                walk(child, False)
                parts.append("\n\n")
            elif tag in ("c", "paramref", "typeparamref"):
                name = child.get("name")
                parts.append(f"`{name}`" if name else f"`{(child.text or '').strip()}`")
            elif tag == "see":
                cref = child.get("cref") or child.get("langword") or ""
                cref = re.sub(r"^[A-Z]:", "", cref)
                label = (child.text or "").strip() or cref.split(".")[-1]
                parts.append(f"`{label}`")
            elif tag == "code":
                parts.append("\n\n```csharp\n" + _dedent(child.text or "") + "\n```\n\n")
            elif tag == "note":
                parts.append("\n\n> **Note:** ")
                walk(child, False)
                parts.append("\n\n")
            elif tag == "list":
                parts.append("\n\n")
                for item in child.iter("item"):
                    desc = item.find("description")
                    term = item.find("term")
                    label = ""
                    if term is not None and term.text:
                        label = f"**{term.text.strip()}** — "
                    parts.append("- " + label)
                    walk(desc if desc is not None else item, False)
                    parts.append("\n")
                parts.append("\n")
            elif tag in ("b", "strong"):
                parts.append("**")
                walk(child, False)
                parts.append("**")
            elif tag in ("i", "em"):
                parts.append("*")
                walk(child, False)
                parts.append("*")
            else:
                walk(child, False)
            if child.tail:
                parts.append(child.tail)

    walk(node, True)
    out = "".join(parts)
    # Collapse whitespace outside code fences.
    chunks = re.split(r"(```csharp\n.*?\n```)", out, flags=re.S)
    for i, chunk in enumerate(chunks):
        if chunk.startswith("```csharp"):
            continue
        chunk = re.sub(r"[ \t]*\n[ \t]*", "\n", chunk)
        chunk = re.sub(r"\n{3,}", "\n\n", chunk)
        chunk = re.sub(r"(?<!\n)\n(?!\n|- |> )", " ", chunk)
        chunk = re.sub(r"[ \t]{2,}", " ", chunk)
        chunks[i] = chunk
    return "".join(chunks).strip()


def _dedent(code: str) -> str:
    lines = code.replace("\t", "    ").split("\n")
    while lines and not lines[0].strip():
        lines.pop(0)
    while lines and not lines[-1].strip():
        lines.pop()
    indent = min((len(l) - len(l.lstrip()) for l in lines if l.strip()), default=0)
    return "\n".join(l[indent:].rstrip() for l in lines)


def _short_sig(name: str) -> str:
    """'M:Ns.Type.#ctor(System.String,System.Int32)' -> 'Type(string, int)'."""
    m = re.match(r"^M:(.+?)\.(#ctor|[^.(]+)(\((.*)\))?$", name)
    if not m:
        return name
    owner, member, _, params = m.groups()
    owner_short = owner.split(".")[-1].replace("`1", "<T>").replace("`2", "<T1, T2>")
    member = owner_short if member == "#ctor" else member
    plist = []
    for p in (params or "").split(",") if params else []:
        p = p.strip()
        if not p:
            continue
        p = re.sub(r"^System\.", "", p)
        p = {"String": "string", "Int32": "int", "Single": "float", "Boolean": "bool",
             "Double": "double", "Object": "object", "Type": "Type"}.get(p, p.split(".")[-1])
        plist.append(p)
    return f"{member}({', '.join(plist)})"


def load(xml_path: Path) -> dict[str, ET.Element]:
    tree = ET.parse(xml_path)
    return {m.get("name"): m for m in tree.getroot().iter("member")}


def members_of(all_members: dict[str, ET.Element], type_name: str) -> list[tuple[str, ET.Element]]:
    prefix = type_name + "."
    out = []
    for name, el in all_members.items():
        kind, rest = name[0], name[2:]
        if kind in ("M", "P", "F") and rest.startswith(prefix):
            tail = rest[len(prefix):]
            # Direct members only (no nested types).
            if kind == "M":
                head = tail.split("(")[0]
                if "." in head:
                    continue
            elif "." in tail:
                continue
            out.append((name, el))
    return out


def render_type(all_members: dict[str, ET.Element], type_name: str, level: int = 3) -> list[str]:
    el = all_members.get("T:" + type_name)
    short = type_name.split(".")[-1].replace("`1", "<T>").replace("`2", "<T1, T2>")
    h = "#" * level
    lines = [f"{h} `{short}`", "", f"*Full name:* `{type_name}`", ""]
    if el is None:
        lines.append("*(no XML documentation shipped for this type)*")
        lines.append("")
        return lines
    summary = _text(el.find("summary"))
    if summary:
        lines += [summary, ""]
    remarks = _text(el.find("remarks"))
    if remarks:
        lines += ["**Remarks.** " + remarks, ""]
    examples = [ex for ex in el.findall("example")]
    if examples:
        lines += ["**Examples**", ""]
        for ex in examples:
            lines += [_text(ex), ""]

    ctors, props, methods = [], [], []
    for name, mel in members_of(all_members, type_name):
        kind = name[0]
        if kind == "M" and ".#ctor" in name:
            ctors.append((name, mel))
        elif kind in ("P", "F"):
            props.append((name, mel))
        else:
            methods.append((name, mel))

    if ctors:
        lines += ["**Constructors**", ""]
        for name, mel in ctors:
            lines.append(f"- `{_short_sig(name)}`")
            params = [(p.get("name"), _text(p)) for p in mel.findall("param")]
            params = [(n, t) for n, t in params if t]
            if params:
                for pn, pt in params:
                    lines.append(f"  - `{pn}` — {pt}")
        lines.append("")
    if props:
        lines += ["**Fields / properties**", ""]
        for name, mel in props:
            pname = name.split(".")[-1]
            desc = _text(mel.find("summary"))
            lines.append(f"- `{pname}`" + (f" — {desc}" if desc else ""))
        lines.append("")
    if methods:
        public_methods = [(n, m) for n, m in methods if "CombineValuesWith" not in n]
        if public_methods:
            lines += ["**Methods**", ""]
            for name, mel in public_methods:
                desc = _text(mel.find("summary"))
                lines.append(f"- `{_short_sig(name)}`" + (f" — {desc}" if desc else ""))
            lines.append("")
    return lines


def front_matter(title: str, version: str, sources: list[Path], today: str) -> str:
    src = ", ".join(f'"{p.relative_to(ROOT).as_posix()}"' for p in sources)
    return (
        "---\n"
        f'title: "{title}"\n'
        f'source_files: [{src}]\n'
        f'odin_version: "{version}"\n'
        f'publisher: "Sirenix (Odin Inspector XML documentation shipped with the DLLs)"\n'
        f'generated: "{today}"\n'
        'generator: "docs/reference/_tools/build_odin_reference.py"\n'
        'topic: "third-party/odin-inspector"\n'
        "---\n\n"
        f"> Generated file — do not edit by hand. Re-run the generator after an Odin upgrade.\n\n"
    )


def main() -> int:
    if not ATTRIBUTES_XML.exists():
        print(f"missing {ATTRIBUTES_XML}", file=sys.stderr)
        return 1
    version = VERSION_FILE.read_text(encoding="utf-8").strip() if VERSION_FILE.exists() else "unknown"
    today = _dt.date.today().isoformat()
    OUT.mkdir(parents=True, exist_ok=True)

    # --- attributes.md ---------------------------------------------------------------
    attrs = load(ATTRIBUTES_XML)
    type_names = sorted(n[2:] for n in attrs if n.startswith("T:"))
    attribute_types = [t for t in type_names if t.endswith("Attribute") and ".Internal." not in t]
    support_types = [t for t in type_names if not t.endswith("Attribute") and ".Internal." not in t]

    lines = [front_matter(f"Odin Inspector {version}: attribute reference (Sirenix.OdinInspector)",
                          version, [ATTRIBUTES_XML], today)]
    lines += [f"# Odin Inspector {version} — attributes in `Sirenix.OdinInspector`", "",
              f"{len(attribute_types)} attribute types from `Sirenix.OdinInspector.Attributes.dll`. "
              "All of them are Editor-only drawing/validation hints: they never change what Unity serializes "
              "(see [serialization.md](serialization.md) for the separate Odin serializer, which this project does not use).", "",
              "## Index", ""]
    for t in attribute_types:
        short = t.split(".")[-1]
        anchor = short.lower()
        summary = _text(attrs["T:" + t].find("summary")).split("\n")[0]
        summary = re.sub(r"\s+", " ", summary)
        if len(summary) > 140:
            summary = summary[:137].rstrip() + "…"
        lines.append(f"- [`{short}`](#{anchor}) — {summary}")
    lines += ["", "## Attributes", ""]
    for t in attribute_types:
        lines += render_type(attrs, t)
    (OUT / "attributes.md").write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")

    # --- support-types.md ------------------------------------------------------------
    lines = [front_matter(f"Odin Inspector {version}: enums and helper types used by attributes",
                          version, [ATTRIBUTES_XML], today)]
    lines += [f"# Odin Inspector {version} — enums and helper types in `Sirenix.OdinInspector`", "",
              "Types referenced by attribute parameters (`TitleAlignments`, `ButtonSizes`, `InfoMessageType`, "
              "`ValueDropdownList<T>` …).", ""]
    for t in support_types:
        lines += render_type(attrs, t)
    (OUT / "support-types.md").write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")

    # --- editor-api.md ---------------------------------------------------------------
    if EDITOR_XML.exists():
        ed = load(EDITOR_XML)
        lines = [front_matter(f"Odin Inspector {version}: editor API (Sirenix.OdinInspector.Editor) — selected types",
                              version, [EDITOR_XML], today)]
        lines += [f"# Odin Inspector {version} — selected editor API", "",
                  "Types from `Sirenix.OdinInspector.Editor.dll` that project editor tooling may use "
                  "(only from the `SheNicest.Editor` assembly, per guideline 12). This is a curated subset; "
                  "the full list is in the XML file named in the front matter.", ""]
        for t in EDITOR_TYPES:
            lines += render_type(ed, t)
        (OUT / "editor-api.md").write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")

    # --- serialization.md ------------------------------------------------------------
    if SERIALIZATION_XML.exists():
        ser = load(SERIALIZATION_XML)
        lines = [front_matter(f"Odin Inspector {version}: Odin serializer types (not used in this project)",
                              version, [SERIALIZATION_XML], today)]
        lines += [f"# Odin Inspector {version} — Odin serializer types", "",
                  "Documented so that agents recognise them. **This project does not use the Odin serializer** — "
                  "guideline 12 forbids `SerializedMonoBehaviour`, `SerializedScriptableObject`, `[OdinSerialize]` "
                  "and everything in `Sirenix.Serialization`; Unity's own serializer is the source of truth.", ""]
        for t in SERIALIZATION_TYPES:
            lines += render_type(ser, t)
        (OUT / "serialization.md").write_text("\n".join(lines).rstrip() + "\n", encoding="utf-8")

    print(f"Odin {version}: wrote {len(attribute_types)} attributes, {len(support_types)} support types to {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

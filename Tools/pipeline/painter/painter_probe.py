"""Record what the connected Substance 3D Painter build actually offers.

Run this against a Painter started with --enable-remote-scripting; it writes a
JSON report describing that exact build: version, which substance_painter
submodules import, which of the calls this pipeline depends on exist, the
available export presets, and the bakers the installed version exposes.

    python3 Tools/pipeline/painter/painter_probe.py [--out report.json]

The point is that nobody has to guess. Painter's Python API moves between
releases: on 12.1.2 three names this pipeline was originally written against
do not exist (see WANTED below), and the probe is what caught them. Re-run it
after every Painter upgrade and diff the report before trusting the pipeline.

Standard library only.
"""

import argparse
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from painter_remote import PainterUnavailable, connect  # noqa: E402


# The calls the RootsDance pipeline depends on. Presence is *probed*, never
# assumed. Anything reported missing has to be redesigned around.
#
# Verified against 12.1.2 on 2026-08-26 — these three are absent there:
#   project.MeshCreationSettings   -> use project.Settings
#   layerstack.get_root_layer_stack -> renamed to get_root_layer_nodes
#   layerstack.add_mask            -> a method on the layer node, not a module
#                                     function (LayerNode.add_mask)
WANTED = [
    ("substance_painter.project", "create"),
    ("substance_painter.project", "open"),
    ("substance_painter.project", "close"),
    ("substance_painter.project", "save"),
    ("substance_painter.project", "save_as"),
    ("substance_painter.project", "is_open"),
    ("substance_painter.project", "is_busy"),
    ("substance_painter.project", "Settings"),
    ("substance_painter.project", "NormalMapFormat"),
    ("substance_painter.project", "TangentSpace"),
    ("substance_painter.project", "reload_mesh"),
    ("substance_painter.textureset", "all_texture_sets"),
    ("substance_painter.textureset", "TextureSet"),
    ("substance_painter.textureset", "Resolution"),
    ("substance_painter.textureset", "MeshMapUsage"),
    ("substance_painter.textureset", "Stack"),
    ("substance_painter.baking", "BakingParameters"),
    ("substance_painter.baking", "bake_async"),
    ("substance_painter.baking", "MeshMapUsage"),
    ("substance_painter.layerstack", "insert_fill"),
    ("substance_painter.layerstack", "insert_paint"),
    ("substance_painter.layerstack", "insert_group"),
    ("substance_painter.layerstack", "get_root_layer_nodes"),
    ("substance_painter.layerstack", "insert_generator_effect"),
    ("substance_painter.layerstack", "insert_smart_material"),
    ("substance_painter.layerstack", "insert_smart_mask"),
    ("substance_painter.layerstack", "MaskBackground"),
    ("substance_painter.export", "export_project_textures"),
    ("substance_painter.export", "list_resource_export_presets"),
    ("substance_painter.resource", "import_session_resource"),
    ("substance_painter.resource", "search"),
    ("substance_painter.js", "evaluate"),
]

# Methods the decal / mask workflow needs on a layer node.
WANTED_NODE_METHODS = [
    "add_mask",
    "remove_mask",
    "enable_mask",
    "set_mask_background",
    "mask_effects",
    "content_effects",
    "set_geometry_mask",
]

_SCRIPT = """
import importlib, json

wanted = {wanted!r}
node_methods = {node_methods!r}

out = {{"modules": {{}}, "calls": {{}}}}

for module_name in sorted({{name for name, _ in wanted}}):
    try:
        importlib.import_module(module_name)
        out["modules"][module_name] = True
    except Exception as error:
        out["modules"][module_name] = str(error)

for module_name, attribute in wanted:
    try:
        module = importlib.import_module(module_name)
        out["calls"][module_name + "." + attribute] = hasattr(module, attribute)
    except Exception:
        out["calls"][module_name + "." + attribute] = False

import substance_painter.application as application
out["version"] = application.version()
try:
    out["version_info"] = str(application.version_info())
except Exception as error:
    out["version_info"] = str(error)

from substance_painter import layerstack
node = getattr(layerstack, "LayerNode", None)
out["layer_node_methods"] = {{
    name: bool(node is not None and hasattr(node, name)) for name in node_methods
}}

from substance_painter import baking
out["bakers"] = sorted(
    name for name in dir(baking.MeshMapUsage) if not name.startswith("_")
    and name not in ("name", "value")
)

import substance_painter.export as export
try:
    out["export_presets"] = sorted(
        str(preset.resource_id.url()).split("?")[0].split("/")[-1]
        for preset in export.list_resource_export_presets()
    )
except Exception as error:
    out["export_presets"] = "ERR " + str(error)

import substance_painter.project as project
out["project_open"] = project.is_open()

RESULT = json.dumps(out)
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", help="write the report here (default: stdout)")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=60041)
    args = parser.parse_args()

    try:
        painter = connect(host=args.host, port=args.port, timeout=120)
    except PainterUnavailable as error:
        print(error, file=sys.stderr)
        return 2

    report = painter.run_python(
        _SCRIPT.format(wanted=WANTED, node_methods=WANTED_NODE_METHODS)
    )

    missing = sorted(name for name, ok in report["calls"].items() if not ok)
    report["missing_calls"] = missing

    text = json.dumps(report, indent=2, sort_keys=True)

    if args.out:
        directory = os.path.dirname(os.path.abspath(args.out))

        if directory:
            os.makedirs(directory, exist_ok=True)

        with open(args.out, "w", encoding="utf-8") as handle:
            handle.write(text + "\n")

        print("wrote {}".format(args.out))
    else:
        print(text)

    print(
        "\nPainter {} — {}/{} probed calls present".format(
            report["version"],
            len(report["calls"]) - len(missing),
            len(report["calls"]),
        ),
        file=sys.stderr,
    )

    if missing:
        print("MISSING: " + ", ".join(missing), file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())

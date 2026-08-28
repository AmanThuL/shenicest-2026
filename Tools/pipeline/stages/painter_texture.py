"""Stage: bake_maps + export_textures -- the Substance 3D Painter stage.

Drives a running Painter over its remote-scripting server (no GUI automation,
no simulated input): creates the project from the exported FBX, bakes the mesh
maps the preset asks for, exports through a Painter export preset, and renames
the results to the project's own texture naming convention.

Painter must be running with remote scripting enabled:

    "<Painter>.app/Contents/MacOS/Adobe Substance 3D Painter" --enable-remote-scripting

Run:
    python3 Tools/pipeline/stages/painter_texture.py \
        --asset Helmet --preset psx_prop \
        --mesh Assets/RootsDance/Meshes/Props/Helmet.fbx \
        --out Assets/RootsDance/Textures/Props \
        --project SourceArt/Painter/Helmet.spp \
        --report Build/pipeline/Helmet/painter_texture.json

Everything it claims is checked from the filesystem afterwards, never from a
screenshot: the report records each exported file with its size and SHA-256.
"""

import argparse
import os
import shutil
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

from rdpipe import presets as presetlib  # noqa: E402
from rdpipe import report as rep  # noqa: E402
from painter.painter_remote import PainterError, PainterUnavailable, connect  # noqa: E402


# preset["bake"] key -> Painter MeshMapUsage member name.
BAKERS = {
    "normal": "Normal",
    "world_space_normal": "WorldSpaceNormal",
    "position": "Position",
    "thickness": "Thickness",
    "ambient_occlusion": "AO",
    "curvature": "Curvature",
    "id": "ID",
    "bent_normals": "BentNormals",
    "height": "Height",
    "opacity": "Opacity",
}

# What a Painter export preset calls a map -> what guideline 02 calls it.
# Keys are matched against the tail of the exported file stem.  The HDRP preset
# below exports the channel-packed MaskMap instead of the separate
# MetallicSmoothness / AmbientOcclusion pair the old URP preset produced, so
# those two names are gone: there is no map kind left for them to become.
# The BaseColor / AlbedoTransparency spellings are kept because Painter's
# presets disagree with each other about which one they use.
MAP_ALIASES = [
    ("AlbedoTransparency", "BaseMap"),
    ("BaseColor", "BaseMap"),
    ("BaseMap", "BaseMap"),
    ("MaskMap", "Mask"),
    ("Mask", "Mask"),
    ("Normal", "Normal"),
    ("Emissive", "Emission"),
    ("Emission", "Emission"),
    ("Height", "Height"),
]

# Painter's built-in HDRP metallic preset. Re-run painter/painter_probe.py
# after a Painter upgrade: the export-preset names are not part of any stable
# API, and the stage fails loudly ("export preset not found") if this drifts.
DEFAULT_EXPORT_PRESET = "Unity HD Render Pipeline (Metallic Standard)"

# Painter refuses to export without an explicit padding algorithm, so the
# pipeline has to state its padding policy rather than inherit a default.
# "infinite" dilates the island outwards indefinitely, which is what stops
# mip-mapping pulling background pixels into island edges.
DEFAULT_TEMPLATE = "Unity HD Render Pipeline (Metallic Standard)"
DEFAULT_PADDING = "infinite"


def enabled_bakers(preset):
    bake = preset.get("bake", {})
    return [BAKERS[key] for key, on in sorted(bake.items()) if on and key in BAKERS]


def project_map_name(stem):
    """Translate an exported file stem's map suffix to the project's name."""
    for painter_name, project_name in MAP_ALIASES:
        if stem.endswith("_" + painter_name):
            return stem[: -len(painter_name) - 1], project_name

    return None, None


def wait_for_texture_sets(painter, timeout=300, interval=2):
    """Block until the project reports at least one texture set.

    Painter creates the project asynchronously; querying too early returns an
    empty list, and every later stage then operates on nothing.
    """
    deadline = time.time() + timeout

    while time.time() < deadline:
        idle = not painter.eval_python(
            "__import__('substance_painter.project', fromlist=['x']).is_busy()"
        )
        sets = painter.run_python(_TEXTURE_SETS)

        if idle and sets:
            return sets

        time.sleep(interval)

    return painter.run_python(_TEXTURE_SETS)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--asset", required=True)
    parser.add_argument("--preset", required=True)
    parser.add_argument("--mesh", required=True, help="the FBX to texture")
    parser.add_argument("--out", required=True, help="final texture folder")
    parser.add_argument("--project", help="save the .spp here (recommended)")
    parser.add_argument("--report", required=True)
    parser.add_argument("--export-preset", default=DEFAULT_EXPORT_PRESET)
    parser.add_argument("--padding", default=DEFAULT_PADDING)
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=60041)
    parser.add_argument(
        "--layer", action="append", default=[], dest="layers",
        metavar="MATERIAL[|MASK]",
        help="author a smart material into every texture set, bottom-up, "
             "between bake and export. 'Iron Old' lays a base; "
             "'Steel Rust Surface|Edge Rust' lays a material behind a smart "
             "mask. Names are resolved against Painter's shelf. Omit to leave "
             "the stack empty, which is what every asset did before.")
    parser.add_argument(
        "--template", default=DEFAULT_TEMPLATE, metavar="NAME_OR_PATH",
        help="project template (.spt) to create from, by name or absolute "
             "path. Without one Painter builds a legacy colour-managed "
             "project, and shelf smart materials -- which are authored in a "
             "modern colour space -- refuse to contribute colour, so every "
             "export comes out grey. Resolved against Painter's own shelves, "
             "so no machine-specific path belongs in an asset config.")
    parser.add_argument(
        "--fill", action="append", default=[], dest="fills",
        metavar="NAME:CHANNEL=PATH[;CHANNEL=PATH][|MASK]",
        help="author a fill layer from image files, e.g. "
             "'Rust:basecolor=a.jpg;normal=b.jpg;roughness=c.jpg|Edge Rust'. "
             "Channels: basecolor, normal, roughness, metallic, height. "
             "Unlike --layer this actually carries colour: shelf smart "
             "materials insert their structure but contribute nothing in a "
             "legacy colour-managed project.")
    parser.add_argument("--bake-timeout", type=int, default=900)
    args = parser.parse_args()

    preset = presetlib.load(args.preset)
    resolution = int(preset["texture"]["resolution"])
    wanted_maps = list(preset["texture"]["maps"])
    bakers = enabled_bakers(preset)

    mesh = os.path.abspath(args.mesh)
    out_dir = os.path.abspath(args.out)

    report = rep.Report(
        "painter_texture",
        asset=args.asset,
        inputs={
            "mesh": args.mesh,
            "preset": preset["_name"],
            "resolution": resolution,
            "maps": wanted_maps,
            "bakers": bakers,
            "export_preset": args.export_preset,
            "padding": args.padding,
        },
    )

    if not os.path.isfile(mesh):
        report.error("mesh.missing", args.mesh, "mesh to texture does not exist")
        report.emit(args.report, exit_on_error=True)
        return

    try:
        painter = connect(host=args.host, port=args.port, timeout=300)
    except PainterUnavailable as error:
        report.error("painter.unreachable", "remote", str(error))
        report.emit(args.report, exit_on_error=True)
        return

    version = painter.version()
    report.info("painter.version", "remote", "Painter %s" % version, version=version)

    staging = os.path.join(
        os.path.dirname(os.path.abspath(args.report)), "painter_raw"
    )
    shutil.rmtree(staging, ignore_errors=True)
    os.makedirs(staging, exist_ok=True)

    # --- create project ---------------------------------------------------
    try:
        template = None
        if args.template:
            template = painter.run_python(
                _TEMPLATE_PATH.format(name=args.template))
            if template:
                report.info("painter.template", args.asset,
                            "creating from template %s" % os.path.basename(template))
            else:
                report.warn(
                    "painter.template_missing", args.template,
                    "no such template on any shelf; falling back to a legacy "
                    "colour-managed project, whose exports come out grey")

        painter.run_python(_CREATE.format(mesh=repr(mesh),
                                          template=repr(template)))
    except PainterError as error:
        report.error("painter.create_failed", args.asset, str(error).strip())
        report.emit(args.report, exit_on_error=True)
        return

    # project.create() returns before the mesh has finished importing, and a
    # project that is still loading reports zero texture sets. Baking against
    # that empty list silently bakes nothing, so wait for the sets to appear
    # rather than for is_busy() alone.
    sets = wait_for_texture_sets(painter, timeout=args.bake_timeout)

    if not sets:
        report.error("painter.no_texture_sets", args.asset,
                     "project opened but no texture set appeared; the mesh has "
                     "no material slot with faces assigned")
        report.emit(args.report, exit_on_error=True)
        return

    painter.run_python(_RESOLUTION.format(resolution=resolution))
    report.info(
        "painter.project", args.asset,
        "project created from %s with texture set(s): %s"
        % (os.path.basename(mesh), ", ".join(sets)),
        texture_sets=sets,
    )

    declared = preset.get("_texture_sets")

    if declared and sorted(declared) != sorted(sets):
        report.warn(
            "painter.texture_set_mismatch", args.asset,
            "asset config expects texture sets %s but the mesh yields %s -- a "
            "material slot with no faces assigned produces no texture set"
            % (sorted(declared), sorted(sets)),
            expected=sorted(declared), actual=sorted(sets),
        )

    # --- bake -------------------------------------------------------------
    if bakers:
        try:
            painter.run_python(_BAKE.format(bakers=repr(bakers)))
        except PainterError as error:
            report.error("painter.bake_failed", args.asset, str(error).strip())
            report.emit(args.report, exit_on_error=True)
            return

        # is_busy() alone is not enough: it reads False in the window between
        # bake_async() returning and the bake actually starting, and the stage
        # then walks on and finds no mesh maps. Wait for the maps themselves.
        deadline = time.time() + args.bake_timeout
        baked = {}

        while time.time() < deadline:
            time.sleep(2)
            if painter.eval_python(
                "__import__('substance_painter.project', fromlist=['x']).is_busy()"
            ):
                continue
            baked = painter.run_python(_BAKED.format(bakers=repr(bakers)))
            if all(baked.get(name) for name in bakers):
                break
        else:
            report.error(
                "painter.bake_timeout", args.asset,
                "baking did not finish within %ds" % args.bake_timeout,
            )
            report.emit(args.report, exit_on_error=True)
            return

        for name in bakers:
            if baked.get(name):
                report.info("bake.ok", name, "%s baked" % name)
            else:
                report.error("bake.missing", name,
                             "%s was requested but no mesh map came back" % name)
    else:
        report.info("bake.skipped", args.asset, "preset enables no bakers")

    # --- author -----------------------------------------------------------
    # The bake gives curvature/AO/thickness; those are what the rust masks read,
    # so authoring has to sit after the bake and before the export.
    if args.fills:
        fill_spec = []
        for item in args.fills:
            body, _, mask = item.partition("|")
            name, _, channel_part = body.partition(":")
            channels = []
            for pair in channel_part.split(";"):
                if not pair.strip():
                    continue
                channel, _, path = pair.partition("=")
                channels.append([channel.strip().lower(),
                                 os.path.abspath(path.strip())])
            tri = 0.0
            if name.strip().endswith(")") and "(" in name:
                head, _, tail = name.strip().rpartition("(")
                try:
                    tri = float(tail[:-1]); name = head
                except ValueError:
                    tri = 0.0
            fill_spec.append([name.strip(), channels, mask.strip(), tri])

        try:
            filled = painter.run_python(_FILL.replace("__SPEC__", repr(fill_spec)))
        except PainterError as error:
            report.error("painter.fill_failed", args.asset, str(error).strip())
            report.emit(args.report, exit_on_error=True)
            return

        for row in filled:
            subject = "%s / %s" % (row["texture_set"], row["layer"])
            if row["status"].startswith("ok"):
                report.info("author.fill", subject,
                            "fill layer from %s%s" % (
                                ", ".join(row["channels"]) or "no channels",
                                " masked by %r" % row["mask"] if row["mask"] else ""),
                            **row)
            else:
                report.error("author.fill_%s" % row["status"].split(":")[0].replace("-", "_"),
                             subject, "fill layer problem: %s" % row["status"], **row)

    if args.layers or args.fills:
        spec = []
        for item in args.layers:
            material, _, mask = item.partition("|")
            spec.append([material.strip(), mask.strip()])

        try:
            authored = painter.run_python(
                _AUTHOR.replace("__SPEC__", repr(spec))
            )
        except PainterError as error:
            report.error("painter.author_failed", args.asset, str(error).strip())
            report.emit(args.report, exit_on_error=True)
            return

        for row in authored:
            subject = "%s / %s" % (row["texture_set"], row["material"])
            if row["status"] in ("ok", "ok-masked"):
                report.info("author.layer", subject,
                            "inserted %r%s" % (
                                row.get("layer", row["material"]),
                                " masked by %r" % row["mask"] if row["mask"] else ""),
                            **row)
            else:
                report.error("author.%s" % row["status"].replace("-", "_"), subject,
                             "could not resolve %r on the shelf"
                             % (row["mask"] if "mask" in row["status"] else row["material"]),
                             **row)
        # Inserting a smart material kicks off an async recompute. Exporting
        # before it settles writes the pre-authoring stack -- grey, not rusty,
        # and silently so. Same trap as project.create() in 6.3.
        deadline = time.time() + args.bake_timeout
        while time.time() < deadline:
            if not painter.eval_python(
                "__import__('substance_painter.project', fromlist=['x']).is_busy()"
            ):
                break
            time.sleep(2)
        else:
            report.error(
                "painter.author_timeout", args.asset,
                "layer computation did not settle within %ds" % args.bake_timeout,
            )
            report.emit(args.report, exit_on_error=True)
            return
        time.sleep(3)  # is_busy drops before the last tiles land
        report.info("author.settled", args.asset,
                    "layer stack finished computing before export")
    else:
        report.info("author.skipped", args.asset,
                    "no --layer given; exporting the bare stack")

    # --- export -----------------------------------------------------------
    try:
        exported = painter.run_python(
            _EXPORT.format(
                out=repr(staging),
                preset=repr(args.export_preset),
                resolution=resolution,
                padding=repr(args.padding),
            )
        )
    except PainterError as error:
        report.error("painter.export_failed", args.asset, str(error).strip())
        report.emit(args.report, exit_on_error=True)
        return

    if exported["status"] != "ExportStatus.Success":
        report.error("painter.export_status", args.asset,
                     "Painter reported %s" % exported["status"])

    report.info("export.preset", args.asset,
                "exported through %s" % exported["preset"])

    # --- rename into the project convention -------------------------------
    os.makedirs(out_dir, exist_ok=True)
    kept = 0

    for name in sorted(os.listdir(staging)):
        if not name.lower().endswith(".png"):
            continue

        stem = os.path.splitext(name)[0]
        _, map_name = project_map_name(stem)

        if map_name is None:
            report.warn("export.unmapped", name,
                        "exported map has no entry in MAP_ALIASES; left in staging")
            continue

        if map_name not in wanted_maps:
            report.info("export.dropped", name,
                        "%s is not in the preset's map list %s"
                        % (map_name, wanted_maps))
            continue

        # Painter names files <mesh>_<textureset>_<map>; the project wants
        # <TextureSet>_<Map>, so the texture set carries the identity.
        texture_set = None

        for candidate in sets:
            if "_" + candidate + "_" in stem or stem.startswith(candidate + "_"):
                texture_set = candidate
                break

        if texture_set is None:
            report.warn("export.unknown_set", name,
                        "cannot tell which texture set this file belongs to")
            continue

        final = os.path.join(out_dir, "%s_%s.png" % (texture_set, map_name))
        shutil.copyfile(os.path.join(staging, name), final)
        report.output("%s_%s" % (texture_set, map_name), final)
        kept += 1

    for wanted in wanted_maps:
        for texture_set in sets:
            expected = os.path.join(out_dir, "%s_%s.png" % (texture_set, wanted))

            if not os.path.isfile(expected):
                report.error(
                    "export.map_missing", "%s_%s" % (texture_set, wanted),
                    "preset requires %s for %s but it was not produced"
                    % (wanted, texture_set),
                )

    # --- save the .spp ----------------------------------------------------
    if args.project:
        spp = os.path.abspath(args.project)
        os.makedirs(os.path.dirname(spp), exist_ok=True)

        try:
            painter.run_python(_SAVE.format(path=repr(spp)))
            report.output("project", spp)
        except PainterError as error:
            report.error("painter.save_failed", args.project, str(error).strip())
    else:
        report.warn(
            "painter.not_saved", args.asset,
            "no --project given, so the layer stack is lost when Painter closes; "
            "non-destructive re-authoring needs the .spp",
        )

    report.info("summary", args.asset,
                "%d texture(s) written to %s at %dpx" % (kept, args.out, resolution))

    report.emit(args.report, exit_on_error=True)


_TEMPLATE_PATH = """
import os
import substance_painter.resource as R

name = {name!r}
found = None
if os.path.isabs(name) and os.path.isfile(name):
    found = name
else:
    stem = name[:-4] if name.endswith(".spt") else name
    for shelf in R.Shelves.all():
        candidate = os.path.join(shelf.path(), "templates", stem + ".spt")
        if os.path.isfile(candidate):
            found = candidate
            break

RESULT = found
"""


_CREATE = """
import substance_painter.project as P

if P.is_open():
    P.close()

P.create(mesh_file_path={mesh}, template_file_path={template}, settings=P.Settings(
    normal_map_format=P.NormalMapFormat.OpenGL,
    tangent_space_mode=P.TangentSpace.PerFragment,
))

RESULT = "created"
"""

_TEXTURE_SETS = """
import json
import substance_painter.project as P
import substance_painter.textureset as TS

sets = [ts.name() for ts in TS.all_texture_sets()] if P.is_open() else []
RESULT = json.dumps(sets)
"""

_RESOLUTION = """
import substance_painter.textureset as TS

for ts in TS.all_texture_sets():
    ts.set_resolution(TS.Resolution({resolution}, {resolution}))

RESULT = "set"
"""

_FILL = """
import os
import substance_painter.layerstack as L
import substance_painter.resource as R
import substance_painter.textureset as TS

CHANNELS = {
    "basecolor": L.ChannelType.BaseColor,
    "normal": L.ChannelType.Normal,
    "roughness": L.ChannelType.SpecularRoughness,
    "metallic": L.ChannelType.BaseMetalness,
    "height": L.ChannelType.Height,
}


def _mask(query):
    for hit in R.search(query):
        try:
            rid = hit.identifier()
            stem = rid.url().rsplit("/", 1)[-1].split("?")[0].rsplit(".", 1)[0]
        except Exception:
            continue
        if stem.lower() == query.lower():
            return rid
    return None


spec = __SPEC__
out = []

for ts in TS.all_texture_sets():
    stack = ts.get_stack()
    for name, channels, mask_query, triplanar in spec:
        entry = {"texture_set": ts.name(), "layer": name, "channels": [],
                 "mask": mask_query or "", "status": "ok"}
        fill = L.insert_fill(L.InsertPosition.from_textureset_stack(stack))
        fill.set_name(name)

        # A unique unwrap breaks a tiling source into disconnected islands, and
        # UV projection makes every island edge a seam. Triplanar keeps the
        # material continuous in 3D and the bake resolves it onto the unwrap.
        if triplanar:
            try:
                fill.set_projection_mode(L.ProjectionMode.Triplanar)
                params = fill.get_projection_parameters()
                if hasattr(params, "scale"):
                    params.scale = triplanar
                    fill.set_projection_parameters(params)
            except Exception as exc:
                entry["projection"] = "triplanar-failed: %s" % exc
            else:
                entry["projection"] = "triplanar"

        for channel, path in channels:
            if channel not in CHANNELS:
                entry["status"] = "unknown-channel:" + channel
                continue
            if not os.path.isfile(path):
                entry["status"] = "missing-file"
                continue
            res = R.import_project_resource(path, R.Usage.TEXTURE)
            fill.set_source(CHANNELS[channel], res.identifier())
            entry["channels"].append(channel)

        if mask_query:
            rid = _mask(mask_query)
            if rid is None:
                entry["status"] = "mask-not-found"
            else:
                fill.add_mask(L.MaskBackground.Black)
                L.insert_smart_mask(
                    L.InsertPosition.inside_node(fill, L.NodeStack.Mask), rid)
                entry["status"] = "ok-masked"
        out.append(entry)

RESULT = out
"""


_AUTHOR = """
import substance_painter.layerstack as L
import substance_painter.resource as R
import substance_painter.textureset as TS


def _resolve(query):
    '''Shelf lookup: exact filename stem wins, else the first hit.'''
    fallback = None
    for hit in R.search(query):
        try:
            rid = hit.identifier()
            stem = rid.url().rsplit("/", 1)[-1].split("?")[0].rsplit(".", 1)[0]
        except Exception:
            continue
        if stem.lower() == query.lower():
            return rid
        if fallback is None:
            fallback = rid
    return fallback


spec = __SPEC__
out = []

for ts in TS.all_texture_sets():
    stack = ts.get_stack()
    for material_query, mask_query in spec:
        entry = {"texture_set": ts.name(), "material": material_query,
                 "mask": mask_query or ""}
        rid = _resolve(material_query)
        if rid is None:
            entry["status"] = "material-not-found"
            out.append(entry)
            continue

        group = L.insert_smart_material(
            L.InsertPosition.from_textureset_stack(stack), rid)
        entry["layer"] = group.get_name()
        entry["status"] = "ok"

        if mask_query:
            mask_rid = _resolve(mask_query)
            if mask_rid is None:
                entry["status"] = "mask-not-found"
            else:
                group.add_mask(L.MaskBackground.Black)
                L.insert_smart_mask(
                    L.InsertPosition.inside_node(group, L.NodeStack.Mask),
                    mask_rid)
                entry["status"] = "ok-masked"
        out.append(entry)

RESULT = out
"""


_BAKE = """
import substance_painter.textureset as TS
from substance_painter import baking as B

for ts in TS.all_texture_sets():
    params = B.BakingParameters.from_texture_set(ts)
    params.set_enabled_bakers([getattr(B.MeshMapUsage, n) for n in {bakers}])
    B.bake_async(ts)

RESULT = "started"
"""

_BAKED = """
import json
import substance_painter.textureset as TS

out = {{}}
for name in {bakers}:
    usage = getattr(TS.MeshMapUsage, name)
    got = True
    for ts in TS.all_texture_sets():
        if ts.get_mesh_map_resource(usage) is None:
            got = False
    out[name] = got

RESULT = json.dumps(out)
"""

_EXPORT = """
import json
import substance_painter.export as E
import substance_painter.textureset as TS

preset = None
for resource in E.list_resource_export_presets():
    if {preset} in str(resource.resource_id.url()):
        preset = resource.resource_id.url()
        break

if preset is None:
    raise RuntimeError("export preset not found: " + {preset})

import math
size_log2 = int(math.log({resolution}, 2))

config = {{
    "exportPath": {out},
    "exportShaderParams": False,
    "defaultExportPreset": preset,
    "exportList": [{{"rootPath": ts.name()}} for ts in TS.all_texture_sets()],
    "exportParameters": [{{"parameters": {{
        "fileFormat": "png",
        "bitDepth": "8",
        "dithering": False,
        "sizeLog2": size_log2,
        "paddingAlgorithm": {padding},
    }}}}],
}}

result = E.export_project_textures(config)
RESULT = json.dumps({{"preset": str(preset), "status": str(result.status)}})
"""

_SAVE = """
import substance_painter.project as P
P.save_as({path}, P.ProjectSaveMode.Full)
RESULT = "saved"
"""


if __name__ == "__main__":
    main()

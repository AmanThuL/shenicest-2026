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
# Keys are matched against the tail of the exported file stem.
MAP_ALIASES = [
    ("AlbedoTransparency", "BaseMap"),
    ("BaseColor", "BaseMap"),
    ("MetallicSmoothness", "Metallic"),
    ("Normal", "Normal"),
    ("AmbientOcclusion", "Occlusion"),
    ("Occlusion", "Occlusion"),
    ("Emissive", "Emission"),
    ("Emission", "Emission"),
    ("Height", "Height"),
]

DEFAULT_EXPORT_PRESET = "Unity Universal Render Pipeline (Metallic Standard)"

# Painter refuses to export without an explicit padding algorithm, so the
# pipeline has to state its padding policy rather than inherit a default.
# "infinite" dilates the island outwards indefinitely, which is what stops
# mip-mapping pulling background pixels into island edges.
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
        painter.run_python(_CREATE.format(mesh=repr(mesh)))
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

        deadline = time.time() + args.bake_timeout

        while time.time() < deadline:
            if not painter.eval_python(
                "__import__('substance_painter.project', fromlist=['x']).is_busy()"
            ):
                break
            time.sleep(2)
        else:
            report.error(
                "painter.bake_timeout", args.asset,
                "baking did not finish within %ds" % args.bake_timeout,
            )
            report.emit(args.report, exit_on_error=True)
            return

        baked = painter.run_python(_BAKED.format(bakers=repr(bakers)))

        for name in bakers:
            if baked.get(name):
                report.info("bake.ok", name, "%s baked" % name)
            else:
                report.error("bake.missing", name,
                             "%s was requested but no mesh map came back" % name)
    else:
        report.info("bake.skipped", args.asset, "preset enables no bakers")

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


_CREATE = """
import substance_painter.project as P

if P.is_open():
    P.close()

P.create(mesh_file_path={mesh}, settings=P.Settings(
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

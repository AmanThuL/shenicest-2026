"""Stage: export_mesh  --  deterministic FBX export + round-trip verification.

The FBX settings are not invented here.  They are the ones already round-trip
tested for this project and written up in
docs/architecture/tooling/Blender到Unity导出管线.md section 4.  The two that
matter most:

* bake_space_transform (the UI's "Apply Transform") is FORCED OFF.  Blender's
  own tooltip marks it "known to be broken with armatures/animations", and the
  project's answer to axis conversion is Unity's Bake Axis Conversion instead.
* add_leaf_bones is forced off, so no '_end' bones pollute the Unity hierarchy.

After writing the file the stage re-imports it into an empty scene and checks
that what came back is what was meant to go out.  That check is the stage's
verification -- not a screenshot.

Run:
    blender -b SourceArt/Blender/Helmet/Helmet.blend \
        --python Tools/pipeline/stages/export_mesh.py -- \
        --object Helmet --asset Helmet --preset psx_prop \
        --out Assets/RootsDance/Meshes/Props/Helmet.fbx \
        --report Build/pipeline/Helmet/export_mesh.json
"""

import argparse
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

import bpy

from rdpipe import report as rep
from rdpipe import presets as presetlib
from rdpipe import blendutil as bu

# Blender's mesh_smooth_type values mapped to the names the UI shows.
SMOOTHING = {"face": "FACE", "edge": "EDGE", "off": "OFF", "normals": "CUSTOM"}


def parse_args():
    p = argparse.ArgumentParser(prog="export_mesh")
    p.add_argument("--object", action="append", required=True, dest="objects")
    p.add_argument("--asset", required=True)
    p.add_argument("--preset", default="realistic_prop")
    p.add_argument("--out", required=True, help="path of the .fbx to write")
    p.add_argument("--smoothing", choices=sorted(SMOOTHING), default="face")
    p.add_argument("--armature", action="store_true",
                   help="asset has a rig: include ARMATURE and bake animation "
                        "per the export doc section 4")
    p.add_argument("--report", default=None)
    p.add_argument("--no-verify", action="store_true",
                   help="skip the FBX round-trip check (not recommended)")
    return p.parse_args(bu.stage_argv())


def expected_state(objs):
    """Snapshot of what the FBX should contain, taken before export."""
    out = {}
    for o in objs:
        me = o.data
        out[o.name] = {
            "tris": sum(len(p.vertices) - 2 for p in me.polygons),
            "uv_layers": [l.name for l in me.uv_layers],
            "material_slots": [s.name for s in o.material_slots],
            "location": [round(v, 5) for v in o.location],
            "rotation_deg": [round(a * 57.2957795, 3) for a in o.rotation_euler],
            "scale": [round(v, 5) for v in o.scale],
        }
    return out


def export(objs, path, args, report):
    bpy.ops.object.select_all(action="DESELECT")
    for o in objs:
        o.select_set(True)
    bpy.context.view_layer.objects.active = objs[0]

    types = {"MESH"}
    if args.armature:
        types.add("ARMATURE")

    settings = dict(
        filepath=path,
        use_selection=True,
        object_types=types,
        # --- Transform (export doc section 4) ---
        global_scale=1.0,
        apply_unit_scale=True,
        apply_scale_options="FBX_SCALE_NONE",
        use_space_transform=True,
        bake_space_transform=False,      # NEVER True -- see module docstring
        axis_forward="-Z",
        axis_up="Y",
        # --- Geometry ---
        use_mesh_modifiers=True,
        mesh_smooth_type=SMOOTHING[args.smoothing],
        use_triangles=False,
        use_custom_props=False,
        # --- Armature ---
        add_leaf_bones=False,            # NEVER True -- pollutes Unity hierarchy
        primary_bone_axis="Y",
        secondary_bone_axis="X",
        armature_nodetype="NULL",
        use_armature_deform_only=False,
        # --- Animation ---
        bake_anim=bool(args.armature),
        bake_anim_use_all_actions=False,
        bake_anim_use_nla_strips=False,
        bake_anim_force_startend_keying=True,
        bake_anim_step=1.0,
        bake_anim_simplify_factor=0.0,   # 0 = no curve decimation
        # --- Paths ---
        path_mode="STRIP",               # no embedded texture paths
        embed_textures=False,
    )
    bpy.ops.export_scene.fbx(**settings)
    report.info("fbx.settings", os.path.basename(path),
                "exported with bake_space_transform=False, add_leaf_bones=False, "
                "axis -Z/Y, smoothing %s, bake_anim=%s"
                % (SMOOTHING[args.smoothing], settings["bake_anim"]),
                settings={k: (sorted(v) if isinstance(v, set) else v)
                          for k, v in settings.items() if k != "filepath"})


def verify_roundtrip(path, expected, report):
    """Re-import the FBX into an empty scene and diff against expectations."""
    bpy.ops.wm.read_homefile(use_empty=True)
    try:
        bpy.ops.import_scene.fbx(filepath=path)
    except Exception as e:                                  # noqa: BLE001
        report.error("fbx.reimport_failed", os.path.basename(path),
                     "Blender could not read back the FBX it just wrote: %s" % e)
        return

    got = {o.name: o for o in bpy.data.objects if o.type == "MESH"}
    if len(got) != len(expected):
        report.error("fbx.object_count", os.path.basename(path),
                     "expected %d mesh object(s), FBX contains %d (%s)"
                     % (len(expected), len(got), ", ".join(sorted(got))),
                     expected=sorted(expected), got=sorted(got))

    for name, exp in expected.items():
        o = got.get(name)
        if o is None:
            report.error("fbx.object_missing", name,
                         "%r is not in the exported FBX; objects present: %s"
                         % (name, ", ".join(sorted(got))))
            continue

        loc = [round(v, 4) for v in o.location]
        rot = [round(a * 57.2957795, 2) for a in o.rotation_euler]
        scl = [round(v, 4) for v in o.scale]
        if any(abs(v) > 1e-3 for v in loc) or any(abs(v) > 1e-2 for v in rot) \
                or any(abs(v - 1.0) > 1e-3 for v in scl):
            report.error(
                "fbx.root_transform", name,
                "re-imported root transform is loc %s rot %s scale %s, not "
                "0/0/1; contract D14 requires a clean root" % (loc, rot, scl),
                location=loc, rotation_deg=rot, scale=scl)
        else:
            report.info("fbx.root_transform", name,
                        "re-imported root transform is clean (0 / 0 / 1)")

        tris = sum(len(p.vertices) - 2 for p in o.data.polygons)
        if tris != exp["tris"]:
            report.error("fbx.triangle_count", name,
                         "%d triangles in, %d out" % (exp["tris"], tris),
                         expected=exp["tris"], got=tris)
        else:
            report.info("fbx.triangle_count", name, "%d triangles preserved" % tris,
                        tris=tris)

        uvs = [l.name for l in o.data.uv_layers]
        if not uvs:
            report.error("fbx.uv_missing", name,
                         "the exported FBX has no UV map; Painter cannot bake it")
        else:
            report.info("fbx.uv", name, "%d UV layer(s): %s" % (len(uvs), ", ".join(uvs)),
                        uv_layers=uvs)

        slots = [s.name for s in o.material_slots]
        if len(slots) != len(exp["material_slots"]):
            report.warn(
                "fbx.material_slots", name,
                "%d material slot(s) in (%s), %d out (%s); Painter creates one "
                "texture set per slot, and a slot with no faces assigned to it "
                "does not survive the FBX round trip"
                % (len(exp["material_slots"]), ", ".join(exp["material_slots"]),
                   len(slots), ", ".join(slots)),
                expected=exp["material_slots"], got=slots)
        else:
            report.info("fbx.material_slots", name,
                        "%d material slot(s) preserved: %s" % (len(slots), ", ".join(slots)),
                        slots=slots)

        leaf = [b for b in bpy.data.armatures for b in b.bones if b.name.endswith("_end")]
        if leaf:
            report.error("fbx.leaf_bones", name,
                         "%d '_end' leaf bone(s) present; add_leaf_bones leaked" % len(leaf))


def main():
    args = parse_args()
    preset = presetlib.load(args.preset)
    out = os.path.abspath(args.out)

    r = rep.Report("export_mesh", asset=args.asset, inputs={
        "blend": bpy.data.filepath,
        "objects": args.objects,
        "preset": preset["_name"],
        "smoothing": args.smoothing,
        "armature": args.armature,
    })

    objs = bu.resolve_objects(args.objects, r)
    if not objs:
        r.emit(args.report, exit_on_error=True)
        return

    for o in objs:
        if not o.data.uv_layers:
            r.error("uv.missing", o.name,
                    "refusing to export %r without a UV map -- run uv_prepare" % o.name)
    if r.errors:
        r.emit(args.report, exit_on_error=True)
        return

    expected = expected_state(objs)
    d = os.path.dirname(out)
    if d and not os.path.isdir(d):
        os.makedirs(d)

    export(objs, out, args, r)
    r.output("fbx", out)

    if not args.no_verify and r.outputs["fbx"]["exists"]:
        verify_roundtrip(out, expected, r)

    r.emit(args.report, exit_on_error=True)


if __name__ == "__main__":
    main()

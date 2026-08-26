"""Stage: asset_prepare  --  explicit, opt-in repair into a DERIVED file.

asset_inspect reports; this stage is the only thing that changes geometry, and
it does so under three hard rules:

1. It never writes to the input .blend.  It always saves to --out, which is
   expected to live under SourceArt/Blender/<Asset>/.
2. Every repair is opt-in by flag.  With no repair flags it just isolates the
   object and copies it -- nothing is "fixed" behind the artist's back.
3. It records the before/after of every transform it applied in the report, so
   the change is reviewable after the fact.

Run:
    blender -b <source.blend> --python Tools/pipeline/stages/asset_prepare.py -- \
        --object Helmet_Placeholder --asset Helmet \
        --apply-rotation --apply-scale \
        --slot HelmetShell --slot Visor \
        --out SourceArt/Blender/Helmet/Helmet.blend \
        --report Build/pipeline/Helmet/asset_prepare.json
"""

import argparse
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

import bpy

from rdpipe import report as rep
from rdpipe import presets as presetlib
from rdpipe import naming
from rdpipe import blendutil as bu


def parse_args():
    p = argparse.ArgumentParser(prog="asset_prepare")
    p.add_argument("--object", required=True)
    p.add_argument("--asset", required=True,
                   help="PascalCase asset name; the isolated object is renamed to it")
    p.add_argument("--preset", default="realistic_prop")
    p.add_argument("--out", required=True, help="derived .blend to write")
    p.add_argument("--report", default=None)
    p.add_argument("--apply-rotation", action="store_true")
    p.add_argument("--apply-scale", action="store_true")
    p.add_argument("--to-origin", action="store_true",
                   help="move the object to the world origin so the exported "
                        "FBX root sits at position 0 (contract D14). This moves "
                        "the object, it does NOT bake the offset into the mesh "
                        "-- baking it would leave the pivot metres away from the "
                        "geometry. Pivot placement itself is a D15 decision.")
    p.add_argument("--slot", action="append", default=[], dest="slots",
                   help="material slot to guarantee exists; repeatable. Each "
                        "becomes one Painter texture set.")
    p.add_argument("--strip-animation", action="store_true",
                   help="remove the object's action, drivers and constraints. "
                        "Required when the transform is animated or "
                        "constrained: without it, an applied transform reverts "
                        "on the next file load and every downstream stage is "
                        "working from a lie.")
    p.add_argument("--overwrite", action="store_true",
                   help="allow replacing an existing --out file")
    return p.parse_args(bu.stage_argv())


def isolate(obj_name, asset, report):
    """Delete everything except the target object, then rename it to the asset.

    Runs in a throwaway headless session, so 'delete everything' only affects
    memory -- the file on disk is never saved back.
    """
    src = bpy.data.objects.get(obj_name)
    if src is None:
        report.error("object.missing", obj_name,
                     "no object named %r in %s" % (obj_name, bpy.data.filepath))
        return None
    if src.type != "MESH":
        report.error("object.not_mesh", obj_name,
                     "%r is a %s, not a MESH" % (obj_name, src.type))
        return None

    keep = {src}
    for o in list(bpy.data.objects):
        if o not in keep:
            bpy.data.objects.remove(o, do_unlink=True)

    src.parent = None
    if src.name != asset:
        report.info("object.renamed", obj_name,
                    "renamed %r -> %r so the texture-set name is stable"
                    % (obj_name, asset), old=obj_name, new=asset)
        src.name = asset
        src.data.name = asset
    return src


def strip_animation(obj, args, report):
    """Remove whatever would re-drive the transform after it is applied.

    Returns False when the object needs stripping but --strip-animation was not
    given, so the caller can fail instead of producing a file whose transform
    silently reverts.
    """
    ad = obj.animation_data
    driving = set()
    if ad and ad.action:
        driving = {fc.data_path for fc in ad.action.fcurves
                   if fc.data_path in ("location", "rotation_euler",
                                       "rotation_quaternion", "scale")}
    constrained = list(obj.constraints)

    if not driving and not constrained:
        return True

    if not args.strip_animation:
        report.error(
            "transform.driven", obj.name,
            "transform is driven by %s%s%s -- applying it would revert on the "
            "next load. Re-run with --strip-animation to remove them from the "
            "derived texturing copy (the source file is not affected)."
            % ("action %r" % ad.action.name if driving else "",
               " and " if driving and constrained else "",
               "constraint(s) %s" % ", ".join(c.name for c in constrained)
               if constrained else ""),
            action=ad.action.name if driving else None,
            constraints=[c.name for c in constrained])
        return False

    if ad:
        name = ad.action.name if ad.action else None
        obj.animation_data_clear()
        report.info("animation.stripped", obj.name,
                    "removed animation data (action %r) from the texturing copy"
                    % name, action=name)
    for c in constrained:
        report.info("constraint.stripped", obj.name,
                    "removed constraint %r (%s)" % (c.name, c.type))
        obj.constraints.remove(c)
    return True


def verify_applied(obj, args, report):
    """Re-assert the transform after every mutation, so the stage cannot
    report success on a file that will load differently."""
    if args.to_origin and any(abs(v) > 1e-4 for v in obj.location):
        report.error("transform.origin_reverted", obj.name,
                     "location is %s at save time, not the origin"
                     % ([round(v, 4) for v in obj.location],))
    if args.apply_rotation and not bu.is_identity_rotation(obj, tol=1e-3):
        report.error("transform.rotation_reverted", obj.name,
                     "rotation is %s degrees at save time, not zero"
                     % ([round(a * 57.2957795, 3) for a in obj.rotation_euler],))
    if args.apply_scale and not bu.is_unit_scale(obj, tol=1e-3):
        report.error("transform.scale_reverted", obj.name,
                     "scale is %s at save time, not unit"
                     % ([round(s, 4) for s in obj.scale],))
    if obj.animation_data or obj.constraints:
        report.error("transform.still_driven", obj.name,
                     "object still carries animation data or constraints at "
                     "save time; the saved transform is not trustworthy")


def apply_transforms(obj, args, report):
    """Apply the requested transforms via the real operator, recording deltas."""
    before = {
        "location": [round(v, 6) for v in obj.location],
        "rotation_deg": [round(a * 57.2957795, 4) for a in obj.rotation_euler],
        "scale": [round(v, 6) for v in obj.scale],
    }
    if args.to_origin and any(abs(v) > 1e-6 for v in obj.location):
        report.info("transform.to_origin", obj.name,
                    "moved object from %s to the world origin so the FBX root "
                    "exports at position 0 (D14)"
                    % ([round(v, 4) for v in obj.location],),
                    from_location=[round(v, 6) for v in obj.location])
        obj.location = (0.0, 0.0, 0.0)

    wanted = {
        "rotation": args.apply_rotation,
        "scale": args.apply_scale,
    }
    if not any(wanted.values()):
        report.info("transform.not_applied", obj.name,
                    "no --apply-rotation/--apply-scale given; rotation and scale "
                    "left exactly as authored", **before)
        return

    bpy.ops.object.select_all(action="DESELECT")
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj
    bpy.ops.object.transform_apply(
        location=False,
        rotation=args.apply_rotation,
        scale=args.apply_scale,
    )
    after = {
        "location": [round(v, 6) for v in obj.location],
        "rotation_deg": [round(a * 57.2957795, 4) for a in obj.rotation_euler],
        "scale": [round(v, 6) for v in obj.scale],
    }
    applied = [k for k, v in wanted.items() if v]
    report.info("transform.applied", obj.name,
                "applied %s -- before %s, after %s"
                % ("+".join(applied), before, after),
                applied=applied, before=before, after=after)

    if args.apply_scale and not bu.is_unit_scale(obj):
        report.error("transform.apply_failed", obj.name,
                     "scale is still %s after transform_apply"
                     % ([round(s, 4) for s in obj.scale],))
    if args.apply_rotation and not bu.is_identity_rotation(obj):
        report.error("transform.apply_failed", obj.name,
                     "rotation is still non-zero after transform_apply")


def ensure_slots(obj, asset, slot_names, preset, report):
    """Guarantee the requested material slots exist, in the given order.

    Materials are created empty-but-named; look development happens in Painter,
    not here.  The names matter because they become Painter texture-set names
    and therefore texture file names.
    """
    if not slot_names:
        if not obj.material_slots:
            report.error(
                "material.no_slots", obj.name,
                "object has no material slots and no --slot was given; Painter "
                "would produce zero texture sets. Pass --slot <Name> per surface.")
        return

    if len(slot_names) > preset["mesh"].get("max_material_slots", 6):
        report.warn("material.too_many_slots", obj.name,
                    "%d slots requested; each is a texture set and a draw call"
                    % len(slot_names))

    existing = {s.name for s in obj.material_slots}
    for nm in slot_names:
        try:
            ts = naming.texture_set_for_material(asset, nm)
        except naming.NameError_ as e:
            report.error("material.bad_slot_name", nm, str(e))
            continue
        if nm in existing:
            report.info("material.slot_kept", nm,
                        "slot %r already present -> texture set %s" % (nm, ts))
            continue
        mat = bpy.data.materials.get(nm) or bpy.data.materials.new(nm)
        mat.use_nodes = True
        obj.data.materials.append(mat)
        report.info("material.slot_added", nm,
                    "added material slot %r -> Painter texture set %s, "
                    "textures %s_*.png" % (nm, ts, ts), texture_set=ts)

    got = [s.name for s in obj.material_slots]
    report.info("material.slots", obj.name,
                "%d slot(s) after prepare: %s" % (len(got), ", ".join(got)), slots=got)


def main():
    args = parse_args()
    preset = presetlib.load(args.preset)
    out = os.path.abspath(args.out)

    r = rep.Report("asset_prepare", asset=args.asset, inputs={
        "blend": bpy.data.filepath,
        "object": args.object,
        "preset": preset["_name"],
        "repairs_requested": {
            "to_origin": args.to_origin,
            "strip_animation": args.strip_animation,
            "apply_rotation": args.apply_rotation,
            "apply_scale": args.apply_scale,
            "slots": args.slots,
        },
    })

    source = bpy.data.filepath
    if os.path.abspath(source) == out:
        r.error("output.would_overwrite_source", out,
                "--out is the source file; asset_prepare never writes back to "
                "source artwork")
        r.emit(args.report, exit_on_error=True)
        return
    if os.path.exists(out) and not args.overwrite:
        r.error("output.exists", out,
                "%s already exists; pass --overwrite to replace it" % out)
        r.emit(args.report, exit_on_error=True)
        return

    obj = isolate(args.object, args.asset, r)
    if obj is None:
        r.emit(args.report, exit_on_error=True)
        return

    if not strip_animation(obj, args, r):
        r.emit(args.report, exit_on_error=True)
        return

    apply_transforms(obj, args, r)
    ensure_slots(obj, args.asset, args.slots, preset, r)
    verify_applied(obj, args, r)

    if r.errors:
        r.warn("output.skipped", out,
               "errors were raised; refusing to write a derived file from a "
               "broken prepare")
        r.emit(args.report, exit_on_error=True)
        return

    d = os.path.dirname(out)
    if d and not os.path.isdir(d):
        os.makedirs(d)
    bpy.ops.wm.save_as_mainfile(filepath=out, copy=True, compress=True)
    r.output("blend", out)
    r.info("source.untouched", source,
           "input file was opened read-only and never saved back")

    r.emit(args.report, exit_on_error=True)


if __name__ == "__main__":
    main()

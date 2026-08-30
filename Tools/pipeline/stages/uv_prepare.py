"""Stage: uv_prepare  --  packing and (opt-in) unwrapping.

Default mode is 'preserve': the artist's UV seams and islands are kept, and the
stage only repacks them to the preset's padding.  --mode unwrap throws the
existing layout away and is therefore opt-in, never automatic.

Padding comes from the preset and is resolution-relative (see
rdpipe/presets.padding_px): 4px at 256 is the same gutter as 16px at 1024, so
raising the texture resolution does not silently halve the bleed margin.

Run:
    blender -b SourceArt/Blender/Helmet/Helmet.blend \
        --python Tools/pipeline/stages/uv_prepare.py -- \
        --object Helmet --preset psx_prop --mode preserve \
        --out SourceArt/Blender/Helmet/Helmet.blend \
        --report Build/pipeline/Helmet/uv_prepare.json
"""

import argparse
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

import bpy

from rdpipe import report as rep
from rdpipe import presets as presetlib
from rdpipe import blendutil as bu


def parse_args():
    p = argparse.ArgumentParser(prog="uv_prepare")
    p.add_argument("--object", required=True)
    p.add_argument("--preset", default="realistic_prop")
    p.add_argument("--mode", choices=("preserve", "unwrap"), default="preserve",
                   help="preserve = keep seams and islands, repack only. "
                        "unwrap = discard the existing layout (destructive to "
                        "the UV map, so it is opt-in).")
    p.add_argument("--angle-limit", type=float, default=66.0,
                   help="Smart UV Project angle limit, --mode unwrap only")
    p.add_argument("--resolution", type=int, default=0,
                   help="override the preset texture resolution for padding maths")
    p.add_argument("--out", required=True)
    p.add_argument("--report", default=None)
    return p.parse_args(bu.stage_argv())


def measure(obj, resolution):
    """UV coverage + texel density on the evaluated mesh."""
    depsgraph = bpy.context.evaluated_depsgraph_get()
    mesh = bu.evaluated_mesh(obj, depsgraph)
    try:
        uvl = mesh.uv_layers.active
        if uvl is None:
            return None
        import numpy as np
        d = bu.per_face_texel_density(mesh, obj.matrix_world, uvl, resolution)
        arr = np.array(d) if d else None
        return {
            "uv_area": round(bu.uv_area(mesh, uvl), 6),
            "median_px_per_m": round(float(np.median(arr)), 2) if arr is not None else None,
            "spread": round(float(arr.std() / arr.mean()), 4)
            if arr is not None and arr.mean() else None,
        }
    finally:
        bu.free_evaluated(obj, depsgraph)


def main():
    args = parse_args()
    preset = presetlib.load(args.preset)
    res = args.resolution or preset["texture"]["resolution"]
    margin = presetlib.padding_normalized(preset, res)
    margin_px = presetlib.padding_px(preset, res)
    out = os.path.abspath(args.out)

    r = rep.Report("uv_prepare", asset=args.object, inputs={
        "blend": bpy.data.filepath,
        "object": args.object,
        "preset": preset["_name"],
        "mode": args.mode,
        "resolution": res,
        "padding_px": margin_px,
        "padding_uv": round(margin, 6),
    })

    objs = bu.resolve_objects([args.object], r)
    if not objs:
        r.emit(args.report, exit_on_error=True)
        return
    obj = objs[0]

    before = measure(obj, res)
    if before:
        r.info("uv.before", obj.name,
               "before: coverage %.1f%%, median %s px/m, spread %s"
               % (before["uv_area"] * 100.0, before["median_px_per_m"],
                  before["spread"]), **before)

    if not obj.data.uv_layers and args.mode == "preserve":
        r.error("uv.missing", obj.name,
                "no UV map to preserve; re-run with --mode unwrap to create one")
        r.emit(args.report, exit_on_error=True)
        return

    bpy.ops.object.select_all(action="DESELECT")
    obj.select_set(True)
    bpy.context.view_layer.objects.active = obj

    bpy.ops.object.mode_set(mode="EDIT")
    bpy.ops.mesh.select_all(action="SELECT")
    try:
        if args.mode == "unwrap":
            r.warn("uv.unwrap_destructive", obj.name,
                   "--mode unwrap discarded the authored UV layout and "
                   "re-projected with Smart UV Project (angle limit %.1f)"
                   % args.angle_limit)
            bpy.ops.uv.smart_project(
                angle_limit=args.angle_limit * 0.0174532925,
                island_margin=margin,
                correct_aspect=True,
                scale_to_bounds=False,
            )
        else:
            bpy.ops.uv.select_all(action="SELECT")
            bpy.ops.uv.pack_islands(margin=margin, rotate=True)
            r.info("uv.packed", obj.name,
                   "repacked existing islands with margin %.5f UV (%d px at %dpx)"
                   % (margin, margin_px, res))
    finally:
        bpy.ops.object.mode_set(mode="OBJECT")

    after = measure(obj, res)
    if after:
        r.info("uv.after", obj.name,
               "after: coverage %.1f%%, median %s px/m, spread %s"
               % (after["uv_area"] * 100.0, after["median_px_per_m"],
                  after["spread"]), **after)
        if after["uv_area"] < 0.25:
            r.warn("uv.low_coverage", obj.name,
                   "UV shells still cover only %.1f%% of the sheet"
                   % (after["uv_area"] * 100.0))
        tol = preset["uv"]["texel_density_tolerance"]
        if after["spread"] is not None and after["spread"] > tol:
            r.warn("uv.texel_density_uneven", obj.name,
                   "texel density spread %.0f%% exceeds tolerance %.0f%%"
                   % (after["spread"] * 100.0, tol * 100.0))

    d = os.path.dirname(out)
    if d and not os.path.isdir(d):
        os.makedirs(d)
    bpy.ops.wm.save_as_mainfile(filepath=out, copy=True, compress=True)
    r.output("blend", out)
    r.emit(args.report, exit_on_error=True)


if __name__ == "__main__":
    main()

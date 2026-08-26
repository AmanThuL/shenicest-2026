"""Stage: asset_inspect  --  READ ONLY.

Inspect a mesh and report everything that would make texturing or the Unity
import go wrong.  This stage NEVER modifies the .blend and never saves.  That
is the whole point: inspect -> report -> explicit repair, not inspect ->
silently modify.

Run:
    blender -b <file.blend> --python Tools/pipeline/stages/asset_inspect.py -- \
        --object Helmet_Placeholder --preset psx_prop \
        --report Build/pipeline/helmet/asset_inspect.json

Exit code 1 if any ERROR finding was raised.
"""

import argparse
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))

import bpy
import numpy as np
from mathutils import Vector

from rdpipe import report as rep
from rdpipe import presets as presetlib
from rdpipe import naming
from rdpipe import blendutil as bu


def parse_args():
    p = argparse.ArgumentParser(prog="asset_inspect")
    p.add_argument("--object", action="append", default=[], dest="objects",
                   help="object to inspect; repeatable")
    p.add_argument("--asset", default=None,
                   help="asset name used for texture naming (default: first object)")
    p.add_argument("--preset", default="realistic_prop")
    p.add_argument("--report", default=None, help="path to write the JSON report")
    p.add_argument("--overlap-resolution", type=int, default=0,
                   help="UV overlap raster size; 0 = preset texture resolution")
    return p.parse_args(bu.stage_argv())


# ---------------------------------------------------------------- UV overlap
def uv_overlap_ratio(mesh, uv_layer, resolution):
    """Fraction of covered texels that more than one triangle lands on.

    Rasterises every UV triangle into an integer coverage grid and counts
    texels with coverage > 1.  Deterministic, and it measures the thing that
    actually breaks baking, unlike a pairwise island test.

    Returns (overlap_ratio, covered_texels, overlapping_texels).
    """
    res = max(16, min(int(resolution), 2048))
    grid = np.zeros((res, res), dtype=np.int32)
    data = uv_layer.data

    for poly in mesh.polygons:
        uvs = [Vector(data[li].uv) for li in poly.loop_indices]
        for i in range(1, len(uvs) - 1):
            tri = (uvs[0], uvs[i], uvs[i + 1])
            _raster_tri(grid, tri, res)

    covered = int((grid > 0).sum())
    overlapping = int((grid > 1).sum())
    ratio = (overlapping / float(covered)) if covered else 0.0
    return ratio, covered, overlapping


def _raster_tri(grid, tri, res):
    xs = [p.x * res for p in tri]
    ys = [p.y * res for p in tri]
    x0 = max(0, int(np.floor(min(xs))))
    x1 = min(res - 1, int(np.ceil(max(xs))))
    y0 = max(0, int(np.floor(min(ys))))
    y1 = min(res - 1, int(np.ceil(max(ys))))
    if x1 < x0 or y1 < y0:
        return
    ax, ay = xs[0], ys[0]
    bx, by = xs[1], ys[1]
    cx, cy = xs[2], ys[2]
    denom = (by - cy) * (ax - cx) + (cx - bx) * (ay - cy)
    if abs(denom) < 1e-12:
        return
    yy, xx = np.mgrid[y0:y1 + 1, x0:x1 + 1]
    px = xx + 0.5
    py = yy + 0.5
    l1 = ((by - cy) * (px - cx) + (cx - bx) * (py - cy)) / denom
    l2 = ((cy - ay) * (px - cx) + (ax - cx) * (py - cy)) / denom
    l3 = 1.0 - l1 - l2
    inside = (l1 >= 0) & (l2 >= 0) & (l3 >= 0)
    if inside.any():
        grid[y0:y1 + 1, x0:x1 + 1] += inside.astype(np.int32)


# ------------------------------------------------------------------- checks
def inspect_object(obj, preset, report, overlap_res):
    name = obj.name
    res = preset["texture"]["resolution"]
    mesh_rules = preset["mesh"]

    # --- transforms -----------------------------------------------------
    if mesh_rules.get("require_applied_scale", True) and not bu.is_unit_scale(obj):
        report.error(
            "transform.unapplied_scale", name,
            "object scale is %s, not (1,1,1); FBX/Painter/Unity will each "
            "interpret this differently -- apply it (Ctrl+A > Scale) or run "
            "asset_prepare --apply-scale"
            % ([round(s, 4) for s in obj.scale],),
            scale=[round(s, 6) for s in obj.scale],
        )
    if not bu.is_uniform_scale(obj):
        report.error(
            "transform.non_uniform_scale", name,
            "non-uniform scale %s skews texel density per axis"
            % ([round(s, 4) for s in obj.scale],),
            scale=[round(s, 6) for s in obj.scale],
        )
    if mesh_rules.get("require_applied_rotation", True) and not bu.is_identity_rotation(obj):
        deg = [round(a * 57.2957795, 3) for a in obj.rotation_euler]
        report.error(
            "transform.unapplied_rotation", name,
            "object rotation is %s degrees, not zero; contract D14 requires the "
            "exported root to arrive in Unity at rotation 0" % (deg,),
            rotation_deg=deg,
        )
    if bu.has_delta_transform(obj):
        report.warn("transform.delta", name,
                    "object has a non-identity delta transform; these are "
                    "invisible in the N-panel and are baked into the export")

    # --- animation / constraints driving the transform -------------------
    # A textured prop must have a transform that means the same thing every
    # time the file is opened.  An action or a constraint on the object breaks
    # that: applying the transform changes the current value, but the F-curve
    # or constraint re-drives it on the next load, so the "applied" transform
    # silently reverts.  Found the hard way -- see the pipeline doc, section 6.
    ad = obj.animation_data
    driving = set()
    if ad and ad.action:
        driving = {fc.data_path for fc in ad.action.fcurves
                   if fc.data_path in ("location", "rotation_euler",
                                       "rotation_quaternion", "scale")}
    if driving:
        report.error(
            "transform.animated", name,
            "object transform is animated by action %r on %s; applying a "
            "transform will not stick, because the F-curves re-drive it when "
            "the file is reloaded. Strip the animation for the texturing copy "
            "(asset_prepare --strip-animation)."
            % (ad.action.name, ", ".join(sorted(driving))),
            action=ad.action.name, driven=sorted(driving))
    elif ad and ad.action:
        report.warn("transform.has_action", name,
                    "object carries action %r (not driving the transform)"
                    % ad.action.name)
    if obj.constraints:
        report.error(
            "transform.constrained", name,
            "object has %d constraint(s) (%s); constraints are evaluated on "
            "load and override the object transform, and they do not survive "
            "FBX export. Strip them for the texturing copy."
            % (len(obj.constraints),
               ", ".join("%s:%s" % (c.name, c.type) for c in obj.constraints)),
            constraints=[[c.name, c.type] for c in obj.constraints])

    # --- duplicates -----------------------------------------------------
    if "." in name and name.rsplit(".", 1)[-1].isdigit():
        report.warn("object.duplicate_suffix", name,
                    "name ends in a numeric duplicate suffix (.001); Unity will "
                    "keep it and the texture-set name becomes unstable")

    # --- geometry -------------------------------------------------------
    nm = bu.non_manifold_edges(obj)
    if nm:
        report.warn("mesh.non_manifold", name,
                    "%d non-manifold edge(s); acceptable for a game asset, but "
                    "it makes thickness/AO bakes leak" % nm, non_manifold_edges=nm)
    lv, le = bu.loose_geometry(obj)
    if lv or le:
        report.warn("mesh.loose_geometry", name,
                    "%d loose vert(s), %d wire edge(s); these export to FBX and "
                    "show up as stray geometry" % (lv, le),
                    loose_verts=lv, loose_edges=le)
    dg = bu.degenerate_faces(obj)
    if dg:
        report.error("mesh.degenerate_faces", name,
                     "%d zero-area face(s); these produce black texels in a bake" % dg,
                     degenerate_faces=dg)
    if obj.data.has_custom_normals:
        report.info("mesh.custom_normals", name,
                    "mesh carries custom split normals -- FBX Smoothing must be "
                    "'Normals Only', not 'Face' (export pipeline doc section 4)")

    # --- material slots -------------------------------------------------
    slots = [s.name for s in obj.material_slots]
    empty = [i for i, s in enumerate(obj.material_slots) if s.material is None]
    if not slots:
        if mesh_rules.get("require_material_slots", True):
            report.error(
                "material.no_slots", name,
                "object has zero material slots; Painter derives one texture set "
                "per slot, so with none there is nothing to texture. Add one "
                "meaningful slot per distinct surface.")
    else:
        if empty:
            report.error("material.empty_slot", name,
                         "material slot(s) %s are empty" % (empty,), slots=empty)
        if len(slots) > mesh_rules.get("max_material_slots", 6):
            report.warn("material.too_many_slots", name,
                        "%d material slots; each one is a separate Painter "
                        "texture set and a separate Unity draw call" % len(slots))
        report.info("material.slots", name,
                    "%d material slot(s): %s" % (len(slots), ", ".join(slots)),
                    slots=slots)

    # --- UV -------------------------------------------------------------
    uvs = obj.data.uv_layers
    if not uvs:
        report.error("uv.missing", name,
                     "mesh has no UV map; baking and texturing are impossible "
                     "until it is unwrapped -- run uv_prepare")
        return
    if len(uvs) > 1:
        report.warn("uv.multiple_layers", name,
                    "%d UV layers (%s); FBX exports all of them and Unity maps "
                    "the first to uv0 -- confirm which one is the texture UV"
                    % (len(uvs), ", ".join(l.name for l in uvs)))

    depsgraph = bpy.context.evaluated_depsgraph_get()
    mesh = bu.evaluated_mesh(obj, depsgraph)
    try:
        uv_layer = mesh.uv_layers.active
        if uv_layer is None:
            report.error("uv.no_active", name, "no active UV layer after modifiers")
            return

        # outside 0-1
        coords = np.array([tuple(d.uv) for d in uv_layer.data], dtype=np.float64)
        eps = 1e-6
        out_of_bounds = int(((coords < -eps) | (coords > 1.0 + eps)).any(axis=1).sum())
        if out_of_bounds and not preset["uv"].get("allow_udim", False):
            report.error(
                "uv.outside_0_1", name,
                "%d of %d UV coords fall outside the 0-1 square and the preset "
                "does not allow UDIM; Painter bakes only the 0-1 tile"
                % (out_of_bounds, len(coords)),
                out_of_bounds=out_of_bounds, total=len(coords),
                u_range=[float(coords[:, 0].min()), float(coords[:, 0].max())],
                v_range=[float(coords[:, 1].min()), float(coords[:, 1].max())])

        # degenerate islands
        total_uv_area = bu.uv_area(mesh, uv_layer)
        if total_uv_area < 1e-6:
            report.error("uv.degenerate", name,
                         "total UV area is ~0; the UV map exists but is collapsed")
            return
        report.info("uv.coverage", name,
                    "UV shells cover %.1f%% of the 0-1 square" % (total_uv_area * 100.0),
                    uv_area=round(total_uv_area, 6))
        if total_uv_area < 0.25:
            report.warn("uv.low_coverage", name,
                        "UV layout uses only %.1f%% of the sheet; most texels are "
                        "wasted -- repack" % (total_uv_area * 100.0))

        # overlap
        ores = overlap_res or res
        ratio, covered, overlapping = uv_overlap_ratio(mesh, uv_layer, ores)
        if preset["uv"].get("allow_overlap", False):
            report.info("uv.overlap", name,
                        "%.2f%% of covered texels overlap (allowed by preset)"
                        % (ratio * 100.0), overlap_ratio=round(ratio, 6))
        elif ratio > 0.005:
            report.error(
                "uv.overlap", name,
                "%.2f%% of covered texels have more than one triangle on them "
                "(%d of %d, rasterised at %dpx); overlapping UVs corrupt a bake"
                % (ratio * 100.0, overlapping, covered, ores),
                overlap_ratio=round(ratio, 6), overlapping_texels=overlapping,
                covered_texels=covered, raster_resolution=ores)
        else:
            report.info("uv.overlap", name, "no significant UV overlap (%.3f%%)"
                        % (ratio * 100.0), overlap_ratio=round(ratio, 6))

        # texel density
        densities = bu.per_face_texel_density(mesh, obj.matrix_world, uv_layer, res)
        if densities:
            arr = np.array(densities)
            med = float(np.median(arr))
            target = preset["uv"]["target_texel_density_px_per_m"]
            tol = preset["uv"]["texel_density_tolerance"]
            spread = float(arr.std() / arr.mean()) if arr.mean() else 0.0
            report.info(
                "uv.texel_density", name,
                "median %.0f px/m at %dpx (target %d, spread %.0f%%)"
                % (med, res, target, spread * 100.0),
                median_px_per_m=round(med, 2),
                min_px_per_m=round(float(arr.min()), 2),
                max_px_per_m=round(float(arr.max()), 2),
                target_px_per_m=target, coefficient_of_variation=round(spread, 4))
            if spread > tol:
                report.warn(
                    "uv.texel_density_uneven", name,
                    "texel density varies by %.0f%% across faces (tolerance %.0f%%); "
                    "some surfaces will look sharper than others"
                    % (spread * 100.0, tol * 100.0))
            if target and (med < target * (1 - tol) or med > target * (1 + tol)):
                report.warn(
                    "uv.texel_density_off_target", name,
                    "median texel density %.0f px/m is outside %.0f%% of the "
                    "preset target %d px/m" % (med, tol * 100.0, target))

        # stats
        report.info("mesh.stats", name,
                    "%d verts / %d faces / %d tris, %.3f x %.3f x %.3f m"
                    % (len(mesh.vertices), len(mesh.polygons),
                       sum(len(p.vertices) - 2 for p in mesh.polygons),
                       obj.dimensions[0], obj.dimensions[1], obj.dimensions[2]),
                    verts=len(mesh.vertices), faces=len(mesh.polygons),
                    tris=sum(len(p.vertices) - 2 for p in mesh.polygons),
                    world_area_m2=round(bu.world_area(mesh, obj.matrix_world), 6),
                    dimensions_m=[round(d, 4) for d in obj.dimensions])
    finally:
        bu.free_evaluated(obj, depsgraph)


def main():
    args = parse_args()
    preset = presetlib.load(args.preset)
    asset = args.asset or (args.objects[0] if args.objects else "UnknownAsset")

    r = rep.Report("asset_inspect", asset=asset, inputs={
        "blend": bpy.data.filepath,
        "objects": args.objects,
        "preset": preset["_name"],
        "texture_resolution": preset["texture"]["resolution"],
    })

    # Prove we did not touch the file.
    r.info("scene.units", "scene",
           "unit system %s, scale_length %s"
           % (bpy.context.scene.unit_settings.system,
              bpy.context.scene.unit_settings.scale_length),
           unit_system=bpy.context.scene.unit_settings.system,
           scale_length=bpy.context.scene.unit_settings.scale_length)

    objs = bu.resolve_objects(args.objects, r)
    if not objs and not r.errors:
        r.error("input.no_objects", asset, "no --object given and nothing resolved")

    for o in objs:
        inspect_object(o, preset, r, args.overlap_resolution)

    r.emit(args.report, exit_on_error=True)


if __name__ == "__main__":
    main()

"""Make each panel's glazing left-right symmetric by construction.

Measuring the asymmetry and chasing it pane by pane kept turning up new
cases: some panes sat at the wrong depth, others differ in size from their
twin across the arch. The panels themselves are symmetric, so the glazing
should be too, and the cheapest way to guarantee it is to mirror the set
and add whatever the reflection is missing.

A mirrored pane is only added where the ironwork actually has an opening --
a ray from outside has to reach the plane without meeting iron -- so this
cannot paste glass over solid frame.
"""
import bmesh
import bpy
import numpy as np
from mathutils import Vector
from mathutils.bvhtree import BVHTree

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
TOL = 0.03                # a twin this close counts as already present
MIN_AREA = 0.001          # ignore the degenerate slivers
SEARCH = 0.20             # how far to scan for the true mirror axis

bpy.ops.wm.open_mainfile(filepath=BLEND)
col = bpy.data.collections["GlassRecovered"]
added_total = 0

for obj in sorted(col.objects, key=lambda o: o.name):
    frame = bpy.data.objects.get(obj.name[:-6])
    if frame is None or obj.name.startswith("STAIR"):
        continue
    mesh = obj.data
    if not len(mesh.polygons):
        continue

    fmw = np.array(frame.matrix_world)
    fv = np.empty((len(frame.data.vertices), 3))
    frame.data.vertices.foreach_get("co", fv.ravel())
    fv = fv @ fmw[:3, :3].T + fmw[:3, 3]
    normal = np.linalg.svd(fv - fv.mean(0), full_matrices=False)[2][2]
    across = np.cross(normal, [0.0, 0.0, 1.0])
    across /= np.linalg.norm(across)
    tree = BVHTree.FromPolygons(
        [Vector(v) for v in fv],
        [tuple(p.vertices) for p in frame.data.polygons], all_triangles=False)
    half = (fv @ normal).ptp() / 2

    mw = np.array(obj.matrix_world)
    inv = np.linalg.inv(mw[:3, :3])
    n = len(mesh.polygons)
    centres = np.empty((n, 3)); mesh.polygons.foreach_get("center", centres.ravel())
    centres = centres @ mw[:3, :3].T + mw[:3, 3]
    areas = np.empty(n); mesh.polygons.foreach_get("area", areas)
    real = np.where(areas > MIN_AREA)[0]
    if not len(real):
        continue
    lat = centres @ across

    # the axis is whichever value pairs the most panes
    guess = 0.5 * ((fv @ across).min() + (fv @ across).max())
    best_mid, best_missing = guess, None
    for cand in np.arange(guess - SEARCH, guess + SEARCH, 0.005):
        mirrored = centres[real] + np.outer(2 * (cand - lat[real]), across)
        d = np.linalg.norm(centres[real][None, :, :] - mirrored[:, None, :], axis=2)
        missing = np.where(d.min(1) > TOL)[0]
        if best_missing is None or len(missing) < len(best_missing):
            best_mid, best_missing = cand, missing

    verts = np.empty((len(mesh.vertices), 3))
    mesh.vertices.foreach_get("co", verts.ravel())
    world = verts @ mw[:3, :3].T + mw[:3, 3]

    bm = bmesh.new(); bm.from_mesh(mesh)
    bm.faces.ensure_lookup_table()
    made = skipped = 0
    for k in best_missing:
        src = real[k]
        target = centres[src] + 2 * (best_mid - lat[src]) * across
        # only where daylight reaches: no iron between outside and the plane
        origin = Vector(target + normal * (half + 0.5))
        if tree.ray_cast(origin, Vector(-normal), half + 0.5 - 0.004)[0] is not None:
            skipped += 1
            continue
        loop = list(mesh.polygons[src].vertices)
        new_verts = []
        for vi in loop:
            p = world[vi]
            p = p + 2 * (best_mid - float(p @ across)) * across
            new_verts.append(bm.verts.new(Vector(inv @ (p - mw[:3, 3]))))
        try:
            # mirroring reverses orientation, so wind the copy the other way
            bm.faces.new(tuple(reversed(new_verts)))
            made += 1
        except ValueError:
            for v in new_verts:
                bm.verts.remove(v)
    bm.to_mesh(mesh); bm.free()
    mesh.update()
    added_total += made
    print("### %-14s panes=%3d  mirrored in %2d  skipped behind iron %2d"
          % (obj.name, len(real), made, skipped))

print("### total panes added by mirroring: %d" % added_total)
bpy.ops.wm.save_mainfile()
print("### saved")

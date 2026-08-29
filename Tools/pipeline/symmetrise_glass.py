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
    # A twin has to match in size as well as position. Position alone calls a
    # leftover twinned whenever it overlaps a smaller pane that is itself
    # correctly mirrored -- the mirrored centroid lands a millimetre away --
    # and that is exactly the pane the cull forgot.
    ratio = areas[real][None, :] / np.maximum(areas[real][:, None], 1e-9)
    same_size = (ratio > 0.7) & (ratio < 1.43)
    guess = 0.5 * ((fv @ across).min() + (fv @ across).max())
    best_mid, best_missing = guess, None
    for cand in np.arange(guess - SEARCH, guess + SEARCH, 0.005):
        mirrored = centres[real] + np.outer(2 * (cand - lat[real]), across)
        d = np.linalg.norm(centres[real][None, :, :] - mirrored[:, None, :], axis=2)
        d = np.where(same_size, d, np.inf)
        missing = np.where(d.min(1) > TOL)[0]
        if best_missing is None or len(missing) < len(best_missing):
            best_mid, best_missing = cand, missing

    # Leftovers first, mirrors second. A pane the cull forgot sits on top of
    # one that was kept, and the kept one has a twin across the arch; mirror
    # it and the leftover gets copied to the good side instead of removed,
    # which is the wrong half of the fix.
    twinned = np.zeros(n, bool)
    twinned[real] = True
    twinned[real[best_missing]] = False
    leftovers = []
    for k in best_missing:
        i = real[k]
        near = np.linalg.norm(centres[real] - centres[i], axis=1)
        near[list(real).index(i)] = 1e9
        overlaps = (near < 0.06) & twinned[real]
        if np.any(overlaps):
            leftovers.append(int(i))
    if leftovers:
        bm = bmesh.new(); bm.from_mesh(mesh)
        bm.faces.ensure_lookup_table()
        bmesh.ops.delete(bm, geom=[bm.faces[i] for i in leftovers], context='FACES')
        bm.to_mesh(mesh); bm.free()
        mesh.update()
        # positions shifted, so everything downstream is recomputed
        n = len(mesh.polygons)
        centres = np.empty((n, 3)); mesh.polygons.foreach_get("center", centres.ravel())
        centres = centres @ mw[:3, :3].T + mw[:3, 3]
        areas = np.empty(n); mesh.polygons.foreach_get("area", areas)
        real = np.where(areas > MIN_AREA)[0]
        lat = centres @ across
        mirrored = centres[real] + np.outer(2 * (best_mid - lat[real]), across)
        d = np.linalg.norm(centres[real][None, :, :] - mirrored[:, None, :], axis=2)
        best_missing = np.where(d.min(1) > TOL)[0]

    verts = np.empty((len(mesh.vertices), 3))
    mesh.vertices.foreach_get("co", verts.ravel())
    world = verts @ mw[:3, :3].T + mw[:3, 3]
    half = (fv @ normal).ptp() / 2

    bm = bmesh.new(); bm.from_mesh(mesh)
    bm.faces.ensure_lookup_table()
    made = skipped = 0
    for k in best_missing:
        src = real[k]
        loop = list(mesh.polygons[src].vertices)
        # Sample the whole pane, not just its centre. A small pane's centroid
        # often lands right behind a glazing bar, and a single ray there
        # called the opening solid and dropped the pane -- which is what left
        # one square of the upper band's row unglazed while its twin was fine.
        probes = [centres[src]] + [world[vi] for vi in loop]
        probes = [p + 2 * (best_mid - float(p @ across)) * across for p in probes]
        reach = half + 0.5
        open_samples = sum(
            1 for p in probes
            if tree.ray_cast(Vector(p + normal * reach), Vector(-normal),
                             reach - 0.004)[0] is None)
        if open_samples == 0:
            skipped += 1
            continue
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
    print("### %-14s panes=%3d  leftovers deleted %2d  mirrored in %2d  "
          "skipped behind iron %2d"
          % (obj.name, len(real), len(leftovers), made, skipped))

print("### total panes added by mirroring: %d" % added_total)
bpy.ops.wm.save_mainfile()
print("### saved")

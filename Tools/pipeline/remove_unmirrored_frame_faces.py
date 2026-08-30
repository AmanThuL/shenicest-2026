"""Delete the frame faces the source forgot to remove on one side.

The upper window band is asymmetric in the ironwork itself: two openings on
the right still carry the face that was cut away on the left, so those
squares read solid while their twins across the arch are glazed. The lower
wall does not have this -- 6100 asymmetric pixels against 264 in a flat
mirror-compared render.

A face is deleted when it faces outwards, has no mirror twin on its panel,
and the mirror position is empty of frame altogether: that is an opening on
one side and iron on the other, which is the defect. Faces whose twin is
merely triangulated differently keep their partner nearby and stay.

    remove_unmirrored_frame_faces.py -- <file.blend> [<file.blend> ...]
"""
import bmesh
import bpy
import sys
import numpy as np
from mathutils import Vector
from mathutils.bvhtree import BVHTree

MIN_AREA = 0.02           # ignore slivers
TWIN = 0.05               # a twin this close counts as present
CLEAR = 0.12              # mirror position must be this empty of frame


def clean(path):
    bpy.ops.wm.open_mainfile(filepath=path)
    removed_total = 0
    # the extracted modules carry the panel under their own asset name, so
    # matching only the L-/M-/R- placements would leave the mesh that Unity
    # actually receives untouched
    def is_panel(n):
        core = n[:-2] if n.endswith("_T") else n
        if "COLUMN" in core:
            return False
        return core[:2] in ("L-", "M-", "R-") or core in (
            "GreenHouse1Wall", "GreenHouse1Window")

    for name in sorted(o.name for o in bpy.data.objects
                       if o.type == "MESH" and is_panel(o.name)):
        obj = bpy.data.objects[name]
        mesh = obj.data
        if len(mesh.polygons) < 100:
            continue
        mw = np.array(obj.matrix_world)
        v = np.empty((len(mesh.vertices), 3))
        mesh.vertices.foreach_get("co", v.ravel())
        world = v @ mw[:3, :3].T + mw[:3, 3]
        normal = np.linalg.svd(world - world.mean(0), full_matrices=False)[2][2]
        if normal @ np.array([world[:, 0].mean(), world[:, 1].mean(), 0.0]) < 0:
            normal = -normal
        across = np.cross(normal, [0.0, 0.0, 1.0])
        across /= np.linalg.norm(across)

        n = len(mesh.polygons)
        c = np.empty((n, 3)); mesh.polygons.foreach_get("center", c.ravel())
        c = c @ mw[:3, :3].T + mw[:3, 3]
        nr = np.empty((n, 3)); mesh.polygons.foreach_get("normal", nr.ravel())
        nr = nr @ mw[:3, :3].T
        ar = np.empty(n); mesh.polygons.foreach_get("area", ar)
        lat = c @ across

        guess = 0.5 * (lat.min() + lat.max())
        best_mid, fewest = guess, None
        for cand in np.arange(guess - 0.2, guess + 0.2, 0.005):
            m = c + np.outer(2 * (cand - lat), across)
            d = np.linalg.norm(c[None, :, :] - m[:, None, :], axis=2).min(1)
            lone = np.where((d > TWIN) & (ar > MIN_AREA))[0]
            if fewest is None or len(lone) < len(fewest):
                best_mid, fewest = cand, lone

        tree = BVHTree.FromPolygons(
            [Vector(p) for p in world],
            [tuple(p.vertices) for p in mesh.polygons], all_triangles=False)
        # "is the mirror position an opening?" is a line-of-sight question,
        # not a proximity one: on a mesh this dense the nearest surface is
        # always a few centimetres away, so find_nearest answers everything
        # the same. Fire through the panel instead.
        half = float((world @ normal).ptp()) / 2 + 0.5
        doomed = []
        for i in fewest:
            if float(nr[i] @ normal) < 0.5:        # only the outward skin
                continue
            target = c[i] + 2 * (best_mid - lat[i]) * across
            origin = Vector(target + normal * half)
            if tree.ray_cast(origin, Vector(-normal), 2 * half)[0] is None:
                doomed.append(int(i))
        if doomed:
            bm = bmesh.new(); bm.from_mesh(mesh)
            bm.faces.ensure_lookup_table()
            bmesh.ops.delete(bm, geom=[bm.faces[i] for i in doomed], context='FACES')
            bm.to_mesh(mesh); bm.free()
            mesh.update()
            removed_total += len(doomed)
            print("###   %-10s removed %d unmirrored faces (%.3f m2)"
                  % (name, len(doomed), float(ar[doomed].sum())))
    bpy.ops.wm.save_mainfile()
    print("### %s: %d faces removed" % (path.rsplit("/", 1)[-1], removed_total))


for target in sys.argv[sys.argv.index("--") + 1:]:
    clean(target)

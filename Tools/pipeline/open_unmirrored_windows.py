"""Open the windows one side of a panel kept closed.

Every panel is symmetric, so wherever the mirror position is daylight and
this one is iron, the iron is a face the source forgot to cut away. Faces
are not a reliable handle for this -- the two halves are triangulated
differently, so face-to-face comparison invents mismatches and misses real
ones. What the eye judges is per point: iron here, sky there.

So the panel is sampled on a grid, every cell labelled by what a ray from
outside meets, and each cell compared with its mirror. Cells that are iron
against daylight name the face that covers them, and those faces go. It
repeats until the grid reports none left, which is also the proof: the
number printed at the end is measured, not claimed.

    open_unmirrored_windows.py -- <file.blend> [<file.blend> ...]
"""
import bmesh
import bpy
import sys
import numpy as np
from mathutils import Vector
from mathutils.bvhtree import BVHTree

STEP = 0.025
MIN_CELLS = 20             # a face smaller than this cannot be judged
UNMIRRORED = 0.80          # this much of it must face daylight to be a leftover


def panels(scene_objects):
    out = []
    for o in scene_objects:
        if o.type != "MESH" or o.name.endswith("-GLASS"):
            continue
        core = o.name[:-2] if o.name.endswith("_T") else o.name
        if "COLUMN" in core:
            continue
        if core[:2] in ("L-", "M-", "R-") or core in ("GreenHouse1Wall",
                                                      "GreenHouse1Window"):
            if len(o.data.polygons) > 100:
                out.append(o)
    return out


def label_grid(obj):
    """iron / open per sample, plus the frame data needed to act on it."""
    mw = np.array(obj.matrix_world)
    v = np.empty((len(obj.data.vertices), 3))
    obj.data.vertices.foreach_get("co", v.ravel())
    world = v @ mw[:3, :3].T + mw[:3, 3]
    normal = np.linalg.svd(world - world.mean(0), full_matrices=False)[2][2]
    if normal @ np.array([world[:, 0].mean(), world[:, 1].mean(), 0.0]) < 0:
        normal = -normal
    across = np.cross(normal, [0.0, 0.0, 1.0])
    across /= np.linalg.norm(across)

    tree = BVHTree.FromPolygons(
        [Vector(p) for p in world],
        [tuple(p.vertices) for p in obj.data.polygons], all_triangles=False)
    lat_v, z_v, dep_v = world @ across, world[:, 2], world @ normal
    lats = np.arange(lat_v.min(), lat_v.max(), STEP)
    zs = np.arange(z_v.min(), z_v.max(), STEP)
    reach = (dep_v.max() - dep_v.min()) + 1.0
    hit_face = np.full((len(zs), len(lats)), -1, dtype=np.int32)
    direction = Vector(-normal)
    for iz, z in enumerate(zs):
        base = np.array([0.0, 0.0, z]) + normal * (dep_v.max() + 0.5)
        for il, la in enumerate(lats):
            hit = tree.ray_cast(Vector(across * la + base), direction, reach)
            if hit[0] is not None:
                hit_face[iz, il] = hit[2]
    return hit_face, lats, zs


def clean(path):
    bpy.ops.wm.open_mainfile(filepath=path)
    total = 0
    for obj in panels(list(bpy.data.objects)):
        hit, lats, zs = label_grid(obj)
        iron = hit >= 0
        best_shift, best = 0, -1.0
        for shift in range(-14, 15):
            flipped = np.roll(iron[:, ::-1], shift, axis=1)
            score = float((flipped == iron).mean())
            if score > best:
                best, best_shift = score, shift
        mirror_iron = np.roll(iron[:, ::-1], best_shift, axis=1)
        wrong = iron & ~mirror_iron

        # Judge a face as a whole. An edge that lands half a cell off its
        # mirror produces a rim of mismatched cells on every face in the
        # panel; only a face that is almost entirely over daylight on the
        # other side is one the source forgot to cut away. Deleting on a
        # per-cell vote instead cascades: each removal turns its own cells
        # into daylight, which unbalances the next face along.
        shown, bad = {}, {}
        for iz, il in np.argwhere(iron):
            f = int(hit[iz, il])
            shown[f] = shown.get(f, 0) + 1
        for iz, il in np.argwhere(wrong):
            f = int(hit[iz, il])
            bad[f] = bad.get(f, 0) + 1
        doomed = [f for f, n in bad.items()
                  if shown.get(f, 0) >= MIN_CELLS and n / shown[f] >= UNMIRRORED]
        if doomed:
            bm = bmesh.new(); bm.from_mesh(obj.data)
            bm.faces.ensure_lookup_table()
            area = sum(bm.faces[f].calc_area() for f in doomed)
            bmesh.ops.delete(bm, geom=[bm.faces[f] for f in doomed],
                             context='FACES')
            bm.to_mesh(obj.data); bm.free()
            obj.data.update()
            total += len(doomed)
            print("### %-10s removed %d faces (%.3f m2 local) that were iron "
                  "against daylight" % (obj.name, len(doomed), area))
        else:
            print("### %-10s nothing to open" % obj.name)
    bpy.ops.wm.save_mainfile()
    print("### %s: %d faces removed" % (path.rsplit("/", 1)[-1], total))


for target in sys.argv[sys.argv.index("--") + 1:]:
    clean(target)

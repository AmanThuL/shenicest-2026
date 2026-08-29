"""Map every disagreement between a panel's two halves, in one pass.

Chasing individual faces kept missing cases, because a face is not what the
eye judges -- what it judges is, at this point on the wall, do I see iron,
glass, or straight through? So the panel is sampled on a grid, each sample
labelled by what a ray from outside meets first, and each label compared
with its mirror. Everything that disagrees comes out at once, with its
position and both labels, so a fix can be decided per case instead of
per guess.

    audit_panel_symmetry.py -- <panel> [<panel> ...]
"""
import bpy
import sys
import numpy as np
from mathutils import Vector
from mathutils.bvhtree import BVHTree

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
GLASS = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
STEP = 0.03
NOTHING, IRON, GLASSY = 0, 1, 2
LABEL = {NOTHING: "open", IRON: "iron", GLASSY: "glass"}

bpy.ops.wm.open_mainfile(filepath=GLASS)


def bvh(obj):
    mw = obj.matrix_world
    return BVHTree.FromPolygons(
        [mw @ v.co for v in obj.data.vertices],
        [tuple(p.vertices) for p in obj.data.polygons], all_triangles=False)


for name in sys.argv[sys.argv.index("--") + 1:]:
    frame = bpy.data.objects[name]
    glass = bpy.data.objects.get(name + "-GLASS")
    fmw = np.array(frame.matrix_world)
    fv = np.empty((len(frame.data.vertices), 3))
    frame.data.vertices.foreach_get("co", fv.ravel())
    fv = fv @ fmw[:3, :3].T + fmw[:3, 3]
    normal = np.linalg.svd(fv - fv.mean(0), full_matrices=False)[2][2]
    if normal @ np.array([fv[:, 0].mean(), fv[:, 1].mean(), 0.0]) < 0:
        normal = -normal
    across = np.cross(normal, [0.0, 0.0, 1.0])
    across /= np.linalg.norm(across)

    ftree, gtree = bvh(frame), bvh(glass) if glass else None
    lat_v, z_v, dep_v = fv @ across, fv[:, 2], fv @ normal
    lat0, lat1 = lat_v.min(), lat_v.max()
    z0, z1 = z_v.min(), z_v.max()
    standoff = (dep_v.max() - dep_v.min()) + 1.0
    origin_base = np.outer(np.ones(1), normal * (dep_v.max() + 0.5))[0]

    lats = np.arange(lat0, lat1, STEP)
    zs = np.arange(z0, z1, STEP)
    grid = np.zeros((len(zs), len(lats)), dtype=np.uint8)
    direction = Vector(-normal)
    for iz, z in enumerate(zs):
        for il, la in enumerate(lats):
            p = across * la + np.array([0.0, 0.0, z]) + normal * (dep_v.max() + 0.5)
            # the in-plane origin needs the panel's own offset along its normal
            p = p + normal * 0.0
            o = Vector(p)
            fh = ftree.ray_cast(o, direction, standoff)
            gh = gtree.ray_cast(o, direction, standoff) if gtree else (None,)
            if fh[0] is None and gh[0] is None:
                grid[iz, il] = NOTHING
            elif gh[0] is not None and (fh[0] is None or gh[3] < fh[3]):
                grid[iz, il] = GLASSY
            else:
                grid[iz, il] = IRON

    # the mirror axis is whichever column offset agrees best
    best_shift, best_score = 0, -1
    for shift in range(-12, 13):
        flipped = np.roll(grid[:, ::-1], shift, axis=1)
        score = float((flipped == grid).mean())
        if score > best_score:
            best_score, best_shift = score, shift
    flipped = np.roll(grid[:, ::-1], best_shift, axis=1)
    bad = np.argwhere(flipped != grid)
    print("### %-8s grid %dx%d  agreement %.3f%%  mismatched cells %d"
          % (name, len(zs), len(lats), 100 * best_score, len(bad)))

    seen = set()
    clusters = []
    bad_set = {(int(a), int(b)) for a, b in bad}
    for cell in sorted(bad_set):
        if cell in seen:
            continue
        stack, group = [cell], []
        seen.add(cell)
        while stack:
            iz, il = stack.pop(); group.append((iz, il))
            for dz in (-1, 0, 1):
                for dl in (-1, 0, 1):
                    nb = (iz + dz, il + dl)
                    if nb in bad_set and nb not in seen:
                        seen.add(nb); stack.append(nb)
        clusters.append(group)
    clusters.sort(key=len, reverse=True)
    for group in clusters[:8]:
        izs = [g[0] for g in group]; ils = [g[1] for g in group]
        iz, il = int(np.mean(izs)), int(np.mean(ils))
        area = len(group) * STEP * STEP
        print("###    %5.3f m2 at lat=%+.2f z=%6.2f   here=%-5s mirror=%-5s"
              % (area, lats[il] - (lat0 + lat1) / 2, zs[iz],
                 LABEL[int(grid[iz, il])], LABEL[int(flipped[iz, il])]))
    if len(clusters) > 8:
        print("###    ... %d more clusters, largest of them %.3f m2"
              % (len(clusters) - 8, len(clusters[8]) * STEP * STEP))

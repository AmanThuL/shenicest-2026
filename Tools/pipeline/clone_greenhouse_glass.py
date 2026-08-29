"""Give M-W1 and M-WIN1 their glass back by cloning a congruent twin's.

Those two panels were the friend's hand-cleaned originals, so the export has
no glass for them. The panels themselves are congruent copies, so the rigid
motion taking twin panel -> target panel carries the twin's glass along.
"""
import bpy
import math
import numpy as np
from mathutils import Matrix, Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
PAIRS = (("L-W1", "M-W1"), ("L-WIN1", "M-WIN1"))

bpy.ops.wm.open_mainfile(filepath=BLEND)


def wfaces(obj):
    mw = np.array(obj.matrix_world)
    n = len(obj.data.polygons)
    c = np.empty((n, 3)); obj.data.polygons.foreach_get("center", c.ravel())
    return c @ mw[:3, :3].T + mw[:3, 3]


col = bpy.data.collections["GlassRecovered"]
for src_name, dst_name in PAIRS:
    src_panel = bpy.data.objects[src_name]
    dst_panel = bpy.data.objects[dst_name]
    sc = wfaces(src_panel); dc = wfaces(dst_panel)
    s_piv, d_piv = sc.mean(0), dc.mean(0)
    best, best_err = None, 1e9
    for k in range(8):
        for mirror in (False, True):
            R = Matrix.Rotation(math.radians(45 * k), 3, 'Z')
            if mirror:
                R = R @ Matrix.Diagonal(Vector((-1, 1, 1))).to_3x3()
            Rn = np.array(R)
            moved = (sc - s_piv) @ Rn.T + d_piv
            err = 0.0
            for p in moved[::37]:
                err += np.linalg.norm(dc - p, axis=1).min()
            if err < best_err:
                best_err, best = err, Matrix.Translation(Vector(d_piv)) @ \
                    R.to_4x4() @ Matrix.Translation(Vector(-s_piv))
    glass_src = bpy.data.objects[src_name + "-GLASS"]
    mesh = glass_src.data.copy()
    ob = bpy.data.objects.new(dst_name + "-GLASS", mesh)
    ob.matrix_world = best @ glass_src.matrix_world
    col.objects.link(ob)
    print("###   %s-GLASS <- %s  err=%.4f" % (dst_name, src_name, best_err))

bpy.ops.wm.save_mainfile()
count = sum(1 for o in col.objects)
faces = sum(len(o.data.polygons) for o in col.objects)
print("### glass objects now: %d, %d faces" % (count, faces))

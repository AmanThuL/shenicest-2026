"""Recover the deleted glazing: original export minus today's master.

The building only moved between the two epochs -- same size, same rotation --
so a single translation aligns them, taken from TOP, the one object with no
repeats and no deletions. Per-object nearest-neighbour estimates are what
failed before: congruent repeating parts pair with the wrong instance.
"""
import bmesh
import bpy
import os
import numpy as np
from mathutils import Vector

S = "/private/tmp/claude-501/-Users-yawen-projects-SheNicest-shenicest-2026/f5835c69-7672-4f75-a730-dd648b58b8eb/scratchpad"
ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
OUT = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"

bpy.ops.wm.open_mainfile(filepath=ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1.blend")
master = {o.name: o for o in bpy.data.objects if o.type == "MESH"}


def wverts(obj):
    mw = np.array(obj.matrix_world)
    n = len(obj.data.vertices)
    v = np.empty((n, 3)); obj.data.vertices.foreach_get("co", v.ravel())
    return v @ mw[:3, :3].T + mw[:3, 3]


def wfaces(obj):
    mw = np.array(obj.matrix_world)
    n = len(obj.data.polygons)
    c = np.empty((n, 3)); obj.data.polygons.foreach_get("center", c.ravel())
    return c @ mw[:3, :3].T + mw[:3, 3]


bpy.ops.import_scene.fbx(filepath=S + "/GREENHOUSE1_original.fbx")
imported = [o for o in bpy.context.selected_objects if o.type == "MESH"]

itop = next(o for o in imported if o.name.split(".")[0] == "TOP")
shift = Vector(wverts(master["TOP"]).mean(0) - wverts(itop).mean(0))
print("### global shift: (%.4f, %.4f, %.4f)" % tuple(shift))

# every master face centre in one tree, so a pane can be checked against the
# whole building rather than trusting the name mapping
all_centres = np.concatenate([wfaces(o) for o in master.values()])
from mathutils.kdtree import KDTree
tree = KDTree(len(all_centres))
for i, p in enumerate(all_centres):
    tree.insert(Vector(p), i)
tree.balance()

collection = bpy.data.collections.new("GlassRecovered")
bpy.context.scene.collection.children.link(collection)
total = kept_objects = 0
for orig in imported:
    base = orig.name.split(".")[0]
    if base.startswith("Niraj") or "已删" in base:
        continue
    centres = wfaces(orig) + np.array(shift)
    missing = [i for i, p in enumerate(centres)
               if tree.find(Vector(p))[2] > 0.005]
    matched = len(centres) - len(missing)
    # some panels were repositioned on their own after the export, so the
    # global shift misses them: realign those to their named twin by bounding
    # box corner and only trust the result when most faces then land
    if matched < 0.5 * len(centres) and base in master:
        ov = wverts(orig); tv = wverts(master[base])
        local = Vector(tv.min(0) - ov.min(0))
        candidate = wfaces(orig) + np.array(local)
        cand_missing = [i for i, p in enumerate(candidate)
                        if tree.find(Vector(p))[2] > 0.005]
        if len(candidate) - len(cand_missing) > 0.5 * len(candidate):
            centres, missing = candidate, cand_missing
            matched = len(centres) - len(missing)
            shift_used = local
            print("###   %-14s realigned by its own twin (%.2f, %.2f, %.2f)"
                  % (base, *local))
        else:
            shift_used = shift
    else:
        shift_used = shift
    if not missing:
        continue
    print("###   %-14s faces=%5d matched=%5d glass=%4d"
          % (base, len(centres), matched, len(missing)))
    total += len(missing)
    bm = bmesh.new(); bm.from_mesh(orig.data)
    bm.faces.ensure_lookup_table()
    keep = set(missing)
    bmesh.ops.delete(bm, geom=[f for f in bm.faces if f.index not in keep],
                     context='FACES')
    mesh = bpy.data.meshes.new(base + "-GLASS")
    bm.to_mesh(mesh); bm.free()
    ob = bpy.data.objects.new(base + "-GLASS", mesh)
    ob.matrix_world = orig.matrix_world.copy()
    ob.location = ob.location + shift_used
    collection.objects.link(ob)
    kept_objects += 1

for orig in imported:
    bpy.data.objects.remove(orig, do_unlink=True)
for name in ("Niraj_Hair_Dark.001",):
    pass

print("### glazing recovered: %d faces on %d objects" % (total, kept_objects))
os.makedirs(os.path.dirname(OUT), exist_ok=True)
bpy.ops.wm.save_as_mainfile(filepath=OUT)
print("### saved")

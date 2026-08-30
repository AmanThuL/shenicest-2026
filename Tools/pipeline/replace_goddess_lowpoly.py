"""Swap the 669k-face goddess in GAIA1 v9 for the 30k-face Tripo rebuild.

The replacement is matched to the original by its bounding box, not by any
stored transform: scaled so both stand the same height, then placed so the
footprint centres and the base heights agree. That keeps her where she was
staged regardless of how either mesh carries its own origin -- the old one
is centred on its middle, the new one on its feet.
"""
import bpy
import numpy as np
from mathutils import Matrix, Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
V9 = ROOT + "/SourceArt/Blender/GAIA1/GAIA1_v9.blend"
NEW = (ROOT + "/SourceArt/Blender/goddess-lowpoly/"
       "tripo_convert_c96173da-3f00-4b63-8528-7d9008bf61fd.fbx")


def world_bounds(objs):
    pts = []
    for o in objs:
        mw = np.array(o.matrix_world)
        v = np.empty((len(o.data.vertices), 3))
        o.data.vertices.foreach_get("co", v.ravel())
        pts.append(v @ mw[:3, :3].T + mw[:3, 3])
    a = np.vstack(pts)
    return a.min(0), a.max(0)


bpy.ops.wm.open_mainfile(filepath=V9)

old = [o for o in bpy.data.objects if o.type == "MESH"
       and any(c.name == "Goddess" for c in o.users_collection)]
if not old:
    raise RuntimeError("no Goddess objects in v9")
old_min, old_max = world_bounds(old)
old_faces = sum(len(o.data.polygons) for o in old)
if old_faces < 60000:
    # already swapped: matching the replacement to itself would rescale her by
    # the ratio of her own height to itself and drift her every run
    print("### already low-poly (%d faces) -- nothing to do" % old_faces)
    raise SystemExit(0)
collections = [c for c in old[0].users_collection]
print("### old: %d objects, %d faces, height %.3f m, base z %.3f"
      % (len(old), old_faces, old_max[2] - old_min[2], old_min[2]))

before = set(bpy.data.objects)
bpy.ops.import_scene.fbx(filepath=NEW)
fresh = [o for o in set(bpy.data.objects) - before if o.type == "MESH"]
print("### new: %d objects, %d faces"
      % (len(fresh), sum(len(o.data.polygons) for o in fresh)))

new_min, new_max = world_bounds(fresh)
scale = (old_max[2] - old_min[2]) / (new_max[2] - new_min[2])
pivot = np.array([(new_min[0] + new_max[0]) / 2,
                  (new_min[1] + new_max[1]) / 2, new_min[2]])
target = np.array([(old_min[0] + old_max[0]) / 2,
                   (old_min[1] + old_max[1]) / 2, old_min[2]])

# bake the placement into the vertices and leave the object at identity.
# Object-level scale and location only take effect once the depsgraph
# evaluates them, and it skips anything outside the view layer -- the
# Goddess collection is not linked into the scene, so a scaled object there
# silently keeps its original size.
for o in fresh:
    mesh = o.data
    mw = np.array(o.matrix_world)
    v = np.empty((len(mesh.vertices), 3))
    mesh.vertices.foreach_get("co", v.ravel())
    world = v @ mw[:3, :3].T + mw[:3, 3]
    world = (world - pivot) * scale + target
    mesh.vertices.foreach_set("co", world.ravel())
    mesh.update()
    o.matrix_world = Matrix.Identity(4)
    o.name = "Goddess_LowPoly" if len(fresh) == 1 else "Goddess_LowPoly_" + o.name
    # a viewport-disabled object never evaluates its world matrix, which is
    # how the stair ended up stranded at the origin in the first v9 pass
    o.hide_viewport = False
    for c in list(o.users_collection):
        c.objects.unlink(o)
    for c in collections:
        c.objects.link(o)
bpy.context.view_layer.update()

for o in old:
    bpy.data.objects.remove(o, do_unlink=True)

final_min, final_max = world_bounds(fresh)
print("### scale x%.4f  baked into the mesh" % scale)
print("### result: %d faces, height %.3f m, base z %.3f, centre (%.3f, %.3f)"
      % (sum(len(o.data.polygons) for o in fresh),
         final_max[2] - final_min[2], final_min[2],
         (final_min[0] + final_max[0]) / 2, (final_min[1] + final_max[1]) / 2))
print("### collections: %s" % [c.name for c in fresh[0].users_collection])

bpy.ops.wm.save_mainfile()
print("### saved")

"""Turn the lower bay's four sunken panels into a glazed double door.

The bay is a single-sided sheet with four recessed rectangles separated by
three raised mullions. A double door wants two leaves, so the mullions
flanking the centre go and each pair of recesses becomes one opening: the
iron keeps the outer stiles, the centre stile and the head and sill, and
the two leaves become glass.

Everything is derived from the geometry -- the recesses are the large
faces sitting at the bay's shallowest depth -- so the same pass fits every
panel without a table of coordinates.

    build_greenhouse_doors.py -- [--dry-run]
"""
import bmesh
import bpy
import sys
import numpy as np
from mathutils import Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
MASTER = ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1.blend"
GLASS = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
LEAF_MIN_M2 = 5.0          # a recess panel is this big; nothing else in the bay is
EDGE = 0.02                # keep faces sitting exactly on the leaf boundary
DRY = "--dry-run" in sys.argv


def frame_axes(obj):
    mw = np.array(obj.matrix_world)
    v = np.empty((len(obj.data.vertices), 3))
    obj.data.vertices.foreach_get("co", v.ravel())
    world = v @ mw[:3, :3].T + mw[:3, 3]
    normal = np.linalg.svd(world - world.mean(0), full_matrices=False)[2][2]
    if normal @ np.array([world[:, 0].mean(), world[:, 1].mean(), 0.0]) < 0:
        normal = -normal
    across = np.cross(normal, [0.0, 0.0, 1.0])
    across /= np.linalg.norm(across)
    return mw, world, normal, across


bpy.ops.wm.open_mainfile(filepath=GLASS)
col = bpy.data.collections["GlassRecovered"]
panels = sorted(o.name for o in bpy.data.objects
                if o.type == "MESH" and o.name[:2] in ("L-", "M-", "R-")
                and "-W" in o.name and "WIN" not in o.name
                and "COLUMN" not in o.name and not o.name.endswith("-GLASS"))

for name in panels:
    obj = bpy.data.objects[name]
    mesh = obj.data
    mw, world, normal, across = frame_axes(obj)
    mid = 0.5 * ((world @ across).min() + (world @ across).max())

    n = len(mesh.polygons)
    centres = np.empty((n, 3)); mesh.polygons.foreach_get("center", centres.ravel())
    centres = centres @ mw[:3, :3].T + mw[:3, 3]
    areas = np.empty(n); mesh.polygons.foreach_get("area", areas)
    lat = centres @ across - mid
    dep = centres @ normal

    # The four recesses are the only quartet of big faces that share a depth;
    # picking the shallowest big face instead catches the pilaster returns
    # further out along the panel, which sit deeper still.
    big = np.where(areas > LEAF_MIN_M2)[0]
    recess = []
    for i in big:
        group = [j for j in big if abs(dep[j] - dep[i]) < 0.01]
        if len(group) == 4:
            recess = sorted(group)
            break
    if not recess:
        print("### %-6s no quartet of recesses; big faces: %s"
              % (name, ["a=%.2f d=%.3f lat=%+.2f" % (areas[i], dep[i], lat[i])
                        for i in big]))
        continue
    floor = float(np.mean(dep[recess]))
    recess.sort(key=lambda i: lat[i])

    def extent(i):
        pts = world[list(mesh.polygons[i].vertices)]
        return ((pts @ across - mid).min(), (pts @ across - mid).max(),
                pts[:, 2].min(), pts[:, 2].max())

    ext = [extent(i) for i in recess]
    leaves = []
    for a, b in ((0, 1), (2, 3)):
        leaves.append((min(ext[a][0], ext[b][0]), max(ext[a][1], ext[b][1]),
                       min(ext[a][2], ext[b][2]), max(ext[a][3], ext[b][3])))
    # the surrounding face the reveal steps up to
    # the surface the reveal steps up to: the bay's face just outside a recess
    neighbours = [dep[i] for i in range(n)
                  if areas[i] > 0.3 and abs(centres[i][2] - centres[recess[0]][2]) < 3.0
                  and dep[i] > floor + 0.02]
    outer = float(np.median(neighbours)) if neighbours else floor + 0.105

    doomed = []
    for i in range(n):
        for l0, l1, z0, z1 in leaves:
            if (l0 + EDGE < lat[i] < l1 - EDGE
                    and z0 + EDGE < centres[i][2] < z1 - EDGE):
                doomed.append(i)
                break
    print("### %-6s leaves %s  removing %d iron faces"
          % (name, ["%.2f..%.2f" % (l[0], l[1]) for l in leaves], len(doomed)))
    if DRY:
        continue

    bm = bmesh.new(); bm.from_mesh(mesh)
    bm.faces.ensure_lookup_table()
    bmesh.ops.delete(bm, geom=[bm.faces[i] for i in doomed], context='FACES')

    def at(l, z, d):
        return Vector(across * (mid + l) + np.array([0.0, 0.0, z]) + normal * d)

    for l0, l1, z0, z1 in leaves:
        # rebuild the reveal all the way round, so no notch is left where a
        # mullion used to meet the head and the sill
        for p0, p1 in (((l0, z0), (l1, z0)), ((l1, z1), (l0, z1)),
                       ((l0, z1), (l0, z0)), ((l1, z0), (l1, z1))):
            quad = [at(p0[0], p0[1], floor), at(p1[0], p1[1], floor),
                    at(p1[0], p1[1], outer), at(p0[0], p0[1], outer)]
            try:
                bm.faces.new([bm.verts.new(p) for p in quad])
            except ValueError:
                pass
    bm.to_mesh(mesh); bm.free()
    mesh.update()

    glass = bpy.data.objects.get(name + "-GLASS")
    gm = np.array(glass.matrix_world)
    inv = np.linalg.inv(gm[:3, :3])
    gbm = bmesh.new(); gbm.from_mesh(glass.data)
    for l0, l1, z0, z1 in leaves:
        corners = [at(l0, z0, floor), at(l1, z0, floor),
                   at(l1, z1, floor), at(l0, z1, floor)]
        gbm.faces.new([gbm.verts.new(Vector(inv @ (np.array(p) - gm[:3, 3])))
                       for p in corners])
    gbm.to_mesh(glass.data); gbm.free()
    glass.data.update()

if not DRY:
    bpy.ops.wm.save_mainfile()
    print("### saved")

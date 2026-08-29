"""Glaze the four sunken panels of the upper band, leaving the ironwork as is.

The upper band repeats the lower bay's arrangement -- four recesses between
three mullions -- but it is not a door, so nothing merges. Each recess
simply stops being iron and becomes a pane: the frame keeps all three
mullions, the stiles, and the head and sill exactly as modelled.

    glaze_upper_bays.py -- [--dry-run]
"""
import bmesh
import bpy
import sys
import numpy as np
from mathutils import Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
GLASS = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
RECESS_MIN_M2 = 1.0
DRY = "--dry-run" in sys.argv

bpy.ops.wm.open_mainfile(filepath=GLASS)
panels = sorted(o.name for o in bpy.data.objects
                if o.type == "MESH" and o.name[:2] in ("L-", "M-", "R-")
                and "WIN" in o.name and "COLUMN" not in o.name
                and not o.name.endswith("-GLASS"))

for name in panels:
    obj = bpy.data.objects[name]
    mesh = obj.data
    mw = np.array(obj.matrix_world)
    v = np.empty((len(mesh.vertices), 3))
    mesh.vertices.foreach_get("co", v.ravel())
    world = v @ mw[:3, :3].T + mw[:3, 3]
    normal = np.linalg.svd(world - world.mean(0), full_matrices=False)[2][2]
    if normal @ np.array([world[:, 0].mean(), world[:, 1].mean(), 0.0]) < 0:
        normal = -normal

    n = len(mesh.polygons)
    areas = np.empty(n); mesh.polygons.foreach_get("area", areas)
    centres = np.empty((n, 3)); mesh.polygons.foreach_get("center", centres.ravel())
    centres = centres @ mw[:3, :3].T + mw[:3, 3]
    dep = centres @ normal

    # the four recesses are the only quartet of sizeable faces sharing a depth
    big = np.where(areas > RECESS_MIN_M2)[0]
    recess = []
    for i in big:
        group = [j for j in big if abs(dep[j] - dep[i]) < 0.01]
        if len(group) == 4:
            recess = sorted(group)
            break
    if not recess:
        print("### %-8s no recessed bay" % name)
        continue

    rings = [[world[k] for k in mesh.polygons[i].vertices] for i in recess]
    print("### %-8s glazing %d recesses (%.2f m2 each)"
          % (name, len(recess), float(areas[recess[0]])))
    if DRY:
        continue

    bm = bmesh.new(); bm.from_mesh(mesh)
    bm.faces.ensure_lookup_table()
    bmesh.ops.delete(bm, geom=[bm.faces[i] for i in recess], context='FACES')
    bm.to_mesh(mesh); bm.free()
    mesh.update()

    glass = bpy.data.objects[name + "-GLASS"]
    gm = np.array(glass.matrix_world)
    inv = np.linalg.inv(gm[:3, :3])
    gbm = bmesh.new(); gbm.from_mesh(glass.data)
    for ring in rings:
        try:
            gbm.faces.new([gbm.verts.new(Vector(inv @ (p - gm[:3, 3])))
                           for p in ring])
        except ValueError:
            pass
    gbm.to_mesh(glass.data); gbm.free()
    glass.data.update()

if not DRY:
    bpy.ops.wm.save_mainfile()
    print("### saved")

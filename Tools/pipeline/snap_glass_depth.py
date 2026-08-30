"""Put every pane on its panel's glazing plane.

The source seats most panes flush against one face of the ironwork but
leaves a handful a few centimetres off, and because the strays are not
mirrored the window reads as lopsided: one small pane framed, its twin
across the arch bare.

The fix keeps the position the model already establishes rather than
inventing one. Per panel, the glazing plane is the depth where most of the
glass area already sits; anything further than a centimetre off is moved
onto it. Nothing moves sideways, so coverage cannot change.
"""
import bpy
import numpy as np

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
TOLERANCE = 0.01          # a pane this close to the plane is already seated
BIN = 0.005               # histogram resolution when finding the plane

bpy.ops.wm.open_mainfile(filepath=BLEND)
col = bpy.data.collections["GlassRecovered"]
moved_total = 0

for obj in sorted(col.objects, key=lambda o: o.name):
    frame = bpy.data.objects.get(obj.name[:-6])
    if frame is None or obj.name.startswith("STAIR"):
        continue

    fmw = np.array(frame.matrix_world)
    fv = np.empty((len(frame.data.vertices), 3))
    frame.data.vertices.foreach_get("co", fv.ravel())
    fv = fv @ fmw[:3, :3].T + fmw[:3, 3]
    normal = np.linalg.svd(fv - fv.mean(0), full_matrices=False)[2][2]

    mesh = obj.data
    if not len(mesh.polygons):
        continue
    mw = np.array(obj.matrix_world)
    n = len(mesh.polygons)
    centres = np.empty((n, 3)); mesh.polygons.foreach_get("center", centres.ravel())
    centres = centres @ mw[:3, :3].T + mw[:3, 3]
    areas = np.empty(n); mesh.polygons.foreach_get("area", areas)
    depth = centres @ normal

    # the glazing plane is where the glass already is, weighted by area so a
    # scatter of slivers cannot outvote the panes
    real = areas > 0.001
    if not real.any():
        continue
    bins = np.round(depth[real] / BIN).astype(int)
    weights = {}
    for b, a in zip(bins, areas[real]):
        weights[b] = weights.get(b, 0.0) + float(a)
    plane = max(weights, key=weights.get) * BIN

    stray = np.where(real & (np.abs(depth - plane) > TOLERANCE))[0]
    if not len(stray):
        print("### %-14s already flush (%d panes on the plane)" % (obj.name, int(real.sum())))
        continue

    # move whole faces, so a vertex shared with a seated pane is left alone
    verts = np.empty((len(mesh.vertices), 3))
    mesh.vertices.foreach_get("co", verts.ravel())
    world = verts @ mw[:3, :3].T + mw[:3, 3]
    shift = {}
    for i in stray:
        delta = plane - depth[i]
        for v in mesh.polygons[i].vertices:
            shift[v] = delta
    for v, delta in shift.items():
        world[v] += normal * delta
    verts = (world - mw[:3, 3]) @ np.linalg.inv(mw[:3, :3]).T
    mesh.vertices.foreach_set("co", verts.ravel())
    mesh.update()
    moved_total += len(stray)
    print("### %-14s plane=%.3f  moved %d of %d panes (max %.3f m)"
          % (obj.name, plane, len(stray), int(real.sum()),
             float(np.abs(depth[stray] - plane).max())))

print("### total panes re-seated: %d" % moved_total)
bpy.ops.wm.save_mainfile()
print("### saved")

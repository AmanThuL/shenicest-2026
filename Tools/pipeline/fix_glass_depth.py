"""Seat every pane in the glazing groove, mid-way through its frame.

The source put none of the glass in the groove: on a wall panel the panes
sit flush with the outer skin and the two bay sheets sit on the inner skin,
so from inside the bays read as a glass wall pasted over the frame relief.
Glass belongs between the frame's two faces.

Per panel: take the frame's thin axis, and move every glass vertex to the
frame's mid-depth along it. Coverage cannot change -- the move is along the
axis the panes are viewed down -- so the audit stays at zero uncovered
openings, and the frame now reads in front of the glass from both sides.
"""
import bpy
import numpy as np

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"

bpy.ops.wm.open_mainfile(filepath=BLEND)
col = bpy.data.collections["GlassRecovered"]

for obj in sorted(col.objects, key=lambda o: o.name):
    frame = bpy.data.objects.get(obj.name[:-6])
    if frame is None:
        print("### %-14s no frame -- left alone" % obj.name)
        continue

    fmw = np.array(frame.matrix_world)
    fv = np.empty((len(frame.data.vertices), 3))
    frame.data.vertices.foreach_get("co", fv.ravel())
    fv = fv @ fmw[:3, :3].T + fmw[:3, 3]
    # the panels stand at 45 degrees round an octagon, so a world-axis bbox
    # measures a diagonal, not the thickness: take the plane normal from the
    # frame's own least-variance direction
    centred = fv - fv.mean(0)
    normal = np.linalg.svd(centred, full_matrices=False)[2][2]
    fdepth = fv @ normal
    thickness = fdepth.max() - fdepth.min()
    if thickness > 2.0:
        print("### %-14s not a flat panel (thickness %.2f m) -- left alone"
              % (obj.name, thickness))
        continue
    mid = 0.5 * (fdepth.min() + fdepth.max())

    mesh = obj.data
    mw = np.array(obj.matrix_world)
    v = np.empty((len(mesh.vertices), 3))
    mesh.vertices.foreach_get("co", v.ravel())
    world = v @ mw[:3, :3].T + mw[:3, 3]
    gdepth = world @ normal
    before_lo, before_hi = gdepth.min(), gdepth.max()
    world += np.outer(mid - gdepth, normal)
    v = (world - mw[:3, 3]) @ np.linalg.inv(mw[:3, :3]).T
    mesh.vertices.foreach_set("co", v.ravel())
    mesh.update()

    print("### %-14s thickness=%.3f  frame %.3f..%.3f  glass %.3f..%.3f -> %.3f"
          % (obj.name, thickness, fdepth.min(), fdepth.max(),
             before_lo, before_hi, mid))

bpy.ops.wm.save_mainfile()
print("### saved")

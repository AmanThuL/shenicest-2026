"""Drop the backdrop sheets SketchUp drew behind each bay.

The source glazes every bay twice: panes seated in the ironwork, and one
sheet spanning the whole bay behind them. Both were deleted by hand, so the
difference recovered both, and the sheet is what reads from inside as a
glass wall with the frame barely in front of it.

The panes are the real glazing and stay exactly where they are, flush with
the iron. Area separates the two cleanly: no true pane here exceeds 1.1 m2
and the sheets run 4.4 to 14.3 m2.

Run before the breakage pass, which carves everything into cells and would
leave nothing to tell them apart by.
"""
import bmesh
import bpy
import numpy as np

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
SHEET_M2 = 3.0

bpy.ops.wm.open_mainfile(filepath=BLEND)
col = bpy.data.collections["GlassRecovered"]
kept = dropped = 0.0

for obj in sorted(col.objects, key=lambda o: o.name):
    mesh = obj.data
    n = len(mesh.polygons)
    areas = np.empty(n)
    mesh.polygons.foreach_get("area", areas)
    sheets = [i for i in range(n) if areas[i] > SHEET_M2]
    sheet_area = float(areas[sheets].sum()) if sheets else 0.0
    kept += float(areas.sum()) - sheet_area
    dropped += sheet_area
    if not sheets:
        continue
    bm = bmesh.new(); bm.from_mesh(mesh)
    bm.faces.ensure_lookup_table()
    bmesh.ops.delete(bm, geom=[bm.faces[i] for i in sheets], context='FACES')
    bm.to_mesh(mesh); bm.free()
    mesh.update()
    print("### %-14s dropped %d sheets (%5.1f m2), kept %3d panes (%5.1f m2)"
          % (obj.name, len(sheets), sheet_area, n - len(sheets),
             areas.sum() - sheet_area))

print("### kept %.1f m2 of panes, dropped %.1f m2 of backdrop" % (kept, dropped))
bpy.ops.wm.save_mainfile()
print("### saved")

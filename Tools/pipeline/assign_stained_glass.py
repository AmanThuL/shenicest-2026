"""Mark the lower arches' panes as stained glass (material slot 3).

The art direction: the round-arched lights of the lower walls -- the tall
side windows and the central fan -- carry stained glass, like a chapel row.
The rectangular bays stay plain. Panels are congruent, so the regions are
stated once in L-W1's frame and carried to the others by rigid alignment.
"""
import bpy
import math
import sys
from mathutils import Matrix, Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
STAINED = "GreenHouse1GlassStained"

# in L-W1's frame: lateral offset from the panel midline, and height
REGIONS = (
    {"name": "tall side arches", "lat": (4.30, 7.35), "z": (2.30, 9.40)},
    {"name": "central fan",      "lat": (0.00, 3.75), "z": (9.80, 13.90)},
)

bpy.ops.wm.open_mainfile(filepath=BLEND)
col = bpy.data.collections["GlassRecovered"]


def wfaces(obj):
    mw = obj.matrix_world
    return [mw @ p.center for p in obj.data.polygons]


ref = bpy.data.objects["L-W1"]
ref_c = wfaces(ref)
ref_pivot = sum(ref_c, Vector()) / len(ref_c)
mid_lat = 0.021           # the panel midline in L-W1's y

mat = bpy.data.materials.get(STAINED) or bpy.data.materials.new(STAINED)

total = {r["name"]: 0 for r in REGIONS}
for obj in sorted(col.objects, key=lambda o: o.name):
    base = obj.name[:-6]
    if "WIN" in base or not ("-W" in base) or "COLUMN" in base:
        continue                        # lower walls only
    panel = bpy.data.objects[base]
    pc = wfaces(panel)
    pivot = sum(pc, Vector()) / len(pc)
    best, best_err = None, 1e18
    for k in range(8):
        for mirror in (False, True):
            R = Matrix.Rotation(math.radians(45 * k), 3, 'Z')
            if mirror:
                R = R @ Matrix.Diagonal(Vector((-1, 1, 1))).to_3x3()
            err = 0.0
            for c in pc[::41]:
                moved = R @ (c - pivot) + ref_pivot
                err += min((moved - rc).length for rc in ref_c[::7])
            if err < best_err:
                best_err, best = err, R
    # ensure slot 3 is the stained material
    while len(obj.data.materials) < 4:
        obj.data.materials.append(None)
    obj.data.materials[3] = mat
    hit = 0
    for poly in obj.data.polygons:
        c = obj.matrix_world @ poly.center
        local = best @ (c - pivot) + ref_pivot
        lat = abs(local.y - mid_lat)
        for region in REGIONS:
            if region["lat"][0] <= lat <= region["lat"][1] and \
               region["z"][0] <= local.z <= region["z"][1]:
                poly.material_index = 3
                total[region["name"]] += 1
                hit += 1
                break
    obj.data.update()
    print("###   %-12s stained faces=%d (align err %.3f)" % (base, hit, best_err))

print("### stained: %s" % total)
bpy.ops.wm.save_mainfile()
print("### saved")

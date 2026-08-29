"""Break the recovered glazing the way glass actually breaks: contagiously.

Panes do not fail independently -- an impact starts somewhere and the damage
spreads, and a pane whose neighbours are gone is likelier to be gone too
(nothing braces it, and whatever broke the first one reached it). So seeds
are drawn where impacts happen -- low, reachable panes far more than high
ones -- and damage diffuses through the pane adjacency graph, decaying with
distance and reinforced by broken neighbours.

Each pane lands in one of four states:
    missing    -> deleted outright
    shattered  -> remnant shards material
    cracked    -> cracked-glass material
    intact     -> plain glass material

Deterministic: a fixed seed, so re-running reproduces the same ruin.

    break_greenhouse_glass.py -- [seed]
"""
import bmesh
import bpy
import random
import sys
import numpy as np
from mathutils import Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"

SEED = int(sys.argv[sys.argv.index("--") + 1]) if "--" in sys.argv and \
    len(sys.argv) > sys.argv.index("--") + 1 else 20260829
N_SEEDS = 0   # 0 = scale with the pane count              # impact points across the building
NEIGHBOUR_M = 0.85         # panes closer than this brace each other
DECAY = 0.68              # damage lost per hop from the impact
REINFORCE = 0.12          # extra damage per already-broken neighbour
THRESH_MISSING = 0.80
THRESH_SHATTER = 0.48
THRESH_CRACK = 0.16

MAT_NAMES = ("GreenHouse1GlassIntact", "GreenHouse1GlassCracked",
             "GreenHouse1GlassShattered")

CELL_M = 0.6              # target pane-cell size when carving up big sheets

rng = random.Random(SEED)
bpy.ops.wm.open_mainfile(filepath=BLEND)
col = bpy.data.collections["GlassRecovered"]

# --- carve the big sheets into pane cells -----------------------------------
# The source glazing is not one pane per opening: SketchUp modelled whole
# sheets, the largest 10 m2. Broken per loose part, a sheet either vanishes
# entirely or stays entirely -- so anything bigger than a hand span is
# subdivided first, and each resulting face is a breakable cell.
for obj in list(col.objects):
    bm = bmesh.new(); bm.from_mesh(obj.data)
    for _ in range(6):
        long_edges = [e for e in bm.edges if e.calc_length() > CELL_M * 1.6]
        if not long_edges:
            break
        bmesh.ops.subdivide_edges(bm, edges=long_edges, cuts=1,
                                  use_grid_fill=True)
    bm.to_mesh(obj.data); bm.free()

# --- cells: every face is a pane cell ---------------------------------------
panes = []
for obj in list(col.objects):
    mw = obj.matrix_world
    for poly in obj.data.polygons:
        panes.append({"obj": obj.name, "faces": [poly.index],
                      "centre": mw @ poly.center, "area": poly.area})
print("### pane cells: %d" % len(panes))

# --- a stray pane far from the building is extraction debris ----------------
centres = np.array([tuple(p["centre"]) for p in panes])
radii = np.linalg.norm(centres[:, :2], axis=1)
strays = [i for i, p in enumerate(panes)
          if radii[i] > 26.0 or p["area"] < 0.002]
degenerate = [i for i in strays if panes[i]["area"] < 0.002]
far = [i for i in strays if panes[i]["area"] >= 0.002]
print("### culled: %d slivers (%.3f m2 total), %d far strays (%.2f m2) %s"
      % (len(degenerate), sum(panes[i]["area"] for i in degenerate),
         len(far), sum(panes[i]["area"] for i in far),
         sorted({panes[i]["obj"] for i in far})))
kept_area = sum(panes[i]["area"] for i in range(len(panes)) if i not in set(strays))
print("### glass area kept for breakage: %.1f m2" % kept_area)

# --- adjacency --------------------------------------------------------------
alive = [i for i in range(len(panes)) if i not in set(strays)]
neighbours = {i: [] for i in alive}
for a_pos, i in enumerate(alive):
    for j in alive[a_pos + 1:]:
        if np.linalg.norm(centres[i] - centres[j]) < NEIGHBOUR_M:
            neighbours[i].append(j); neighbours[j].append(i)

# --- seeds: stratified per panel, reachable panes first ---------------------
# One global draw piles every impact onto whichever panel is densest and the
# rest of the building stays pristine. Every panel takes its share instead,
# and within a panel the low panes -- the reachable ones -- break first.
z = centres[:, 2]
by_panel = {}
for i in alive:
    by_panel.setdefault(panes[i]["obj"], []).append(i)
seeds = []
for name, cells in sorted(by_panel.items()):
    quota = max(1, round((N_SEEDS or len(alive) // 16) * len(cells) / len(alive)))
    lo = min(z[i] for i in cells)
    weights = [0.15 + max(0.0, 1.0 - (z[i] - lo) / 8.0) for i in cells]
    seeds += rng.choices(cells, weights=weights, k=quota)
print("### seeds: %d across %d panels" % (len(seeds), len(by_panel)))

damage = {i: 0.0 for i in alive}
for s in seeds:
    frontier = {s: 1.0}
    visited = set()
    while frontier:
        nxt = {}
        for i, d in frontier.items():
            if i in visited:
                continue
            visited.add(i)
            damage[i] = min(1.5, damage[i] + d * rng.uniform(0.7, 1.0))
            spread = d * DECAY
            if spread > 0.08:
                for j in neighbours[i]:
                    if j not in visited:
                        nxt[j] = max(nxt.get(j, 0.0), spread)
        frontier = nxt

# broken neighbours pull a pane down with them
for _ in range(2):
    for i in alive:
        broken = sum(1 for j in neighbours[i] if damage[j] > THRESH_SHATTER)
        damage[i] += REINFORCE * broken * rng.uniform(0.5, 1.0)

states = {}
tally = {"missing": 0, "shattered": 0, "cracked": 0, "intact": 0}
for i in alive:
    d = damage[i]
    state = ("missing" if d > THRESH_MISSING else
             "shattered" if d > THRESH_SHATTER else
             "cracked" if d > THRESH_CRACK else "intact")
    states[i] = state
    tally[state] += 1
for i in strays:
    states[i] = "missing"
print("### states: %s of %d panes" % (tally, len(alive)))

# --- apply: three material slots, missing panes deleted ---------------------
mats = []
for name in MAT_NAMES:
    m = bpy.data.materials.get(name) or bpy.data.materials.new(name)
    mats.append(m)

slot_of = {"intact": 0, "cracked": 1, "shattered": 2}
for obj in list(col.objects):
    mine = [(i, states[i]) for i in range(len(panes)) if panes[i]["obj"] == obj.name]
    obj.data.materials.clear()
    for m in mats:
        obj.data.materials.append(m)
    bm = bmesh.new(); bm.from_mesh(obj.data)
    bm.faces.ensure_lookup_table()
    doomed = []
    for i, state in mine:
        for fi in panes[i]["faces"]:
            if state == "missing":
                doomed.append(bm.faces[fi])
            else:
                bm.faces[fi].material_index = slot_of[state]
    if doomed:
        bmesh.ops.delete(bm, geom=doomed, context='FACES')
    bm.to_mesh(obj.data); bm.free()
    if len(obj.data.polygons) == 0:
        bpy.data.objects.remove(obj, do_unlink=True)

remaining = sum(len(o.data.polygons) for o in col.objects)
print("### remaining glass faces: %d on %d objects" % (remaining, len(col.objects)))
bpy.ops.wm.save_mainfile()
print("### saved")

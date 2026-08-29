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
NEIGHBOUR_M = 1.35         # panes closer than this brace each other
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

# --- units of breakage: the panes the eye sees ------------------------------
# The muntin grid lives in the frame mesh, not in the glass: behind it the
# source keeps whole sheets. Damage bitten out of a sheet on an arbitrary
# grid crosses the muntins and reads as wrong. So the sheet is subdivided
# fine, each cell is classified by whether a frame bar sits in front of it,
# and the open cells flood-fill into the apparent panes -- the units glass
# actually breaks in, frame to frame.
from mathutils.bvhtree import BVHTree

FINE_M = 0.28             # subdivision for classifying against the muntins
COVER_M = 0.55            # a frame face this close in front covers the cell

panes = []
for obj in list(col.objects):
    base = obj.name[:-6]                       # strip -GLASS
    frame = bpy.data.objects.get(base)
    bm = bmesh.new(); bm.from_mesh(obj.data)
    for _ in range(8):
        long_edges = [e for e in bm.edges if e.calc_length() > FINE_M * 1.6]
        if not long_edges:
            break
        bmesh.ops.subdivide_edges(bm, edges=long_edges, cuts=1,
                                  use_grid_fill=True)
    bm.to_mesh(obj.data); bm.free()

    mesh = obj.data
    mw = obj.matrix_world
    rot = mw.to_3x3()
    centres = [mw @ p.center for p in mesh.polygons]

    covered = [False] * len(mesh.polygons)
    if frame is not None and not base.startswith("STAIR"):
        fw = frame.matrix_world
        verts = [fw @ v.co for v in frame.data.vertices]
        polys = [tuple(p.vertices) for p in frame.data.polygons]
        tree = BVHTree.FromPolygons(verts, polys, all_triangles=False)
        pivot = sum(centres, Vector()) / len(centres)
        for i, poly in enumerate(mesh.polygons):
            n = rot @ poly.normal
            radial = Vector((centres[i].x, centres[i].y, 0.0)).normalized()
            out = n if n.dot(radial) > 0 else -n
            hit = tree.ray_cast(centres[i] + out * 0.005, out, COVER_M)
            covered[i] = hit[0] is not None

    # flood fill the open cells into apparent panes
    edge_faces = {}
    for i, poly in enumerate(mesh.polygons):
        for k in poly.edge_keys:
            edge_faces.setdefault(k, []).append(i)
    region = [-1] * len(mesh.polygons)
    next_id = 0
    for i in range(len(mesh.polygons)):
        if covered[i] or region[i] >= 0:
            continue
        stack = [i]; region[i] = next_id
        while stack:
            f = stack.pop()
            for k in mesh.polygons[f].edge_keys:
                for g in edge_faces[k]:
                    if not covered[g] and region[g] < 0:
                        region[g] = next_id; stack.append(g)
        next_id += 1
    # a covered cell breaks with the pane next to it, so the hole runs
    # frame to frame instead of stopping at the muntin's edge
    frontier = [i for i in range(len(mesh.polygons)) if region[i] >= 0]
    while frontier:
        nxt = []
        for f in frontier:
            for k in mesh.polygons[f].edge_keys:
                for g in edge_faces[k]:
                    if region[g] < 0:
                        region[g] = region[f]; nxt.append(g)
        frontier = nxt
    for f in range(len(mesh.polygons)):
        if region[f] < 0:                       # isolated fully covered patch
            region[f] = next_id; next_id += 1

    groups = {}
    for f, r in enumerate(region):
        groups.setdefault(r, []).append(f)
    for faces in groups.values():
        centre = sum((centres[f] for f in faces), Vector()) / len(faces)
        area = sum(mesh.polygons[f].area for f in faces)
        panes.append({"obj": obj.name, "faces": faces,
                      "centre": centre, "area": area})
print("### apparent panes: %d" % len(panes))

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
    quota = max(1, round((N_SEEDS or len(alive) // 34) * len(cells) / max(1, len(alive))))
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

"""Glaze the openings in the two domes.

The panes over 1F and 2F were deleted with the rest of the glazing, but
unlike the walls the domes lost nothing else, so the difference against the
pre-deletion export had nothing to recover -- the openings are simply holes
in the dome mesh now.

A hole is a boundary loop, and the loops separate cleanly: the dome's own
rims are flat rings lying in a horizontal plane, while every window opening
follows the curve and so spans a metre or two in height. Each window loop
gets a face, and they land in one glass object per dome.
"""
import bmesh
import bpy
import numpy as np
from mathutils import Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
MASTER = ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1.blend"
GLASS = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
RIM_HEIGHT = 0.30          # a loop flatter than this is a rim, not a window


def loops_of(mesh):
    bm = bmesh.new(); bm.from_mesh(mesh)
    bm.edges.ensure_lookup_table()
    border = [e for e in bm.edges if len(e.link_faces) == 1]
    seen, out = set(), []
    for e in border:
        if e.index in seen:
            continue
        stack, edges = [e], []
        seen.add(e.index)
        while stack:
            cur = stack.pop(); edges.append(cur)
            for v in cur.verts:
                for ne in v.link_edges:
                    if ne.index not in seen and len(ne.link_faces) == 1:
                        seen.add(ne.index); stack.append(ne)
        out.append(edges)
    return bm, out


def ordered(edges):
    """Walk a closed edge loop into a vertex ring, or None if it is not one."""
    link = {}
    for e in edges:
        for v in e.verts:
            link.setdefault(v, []).append(e)
    if any(len(v) != 2 for v in link.values()):
        return None
    start = next(iter(link))
    ring, prev_edge, cur = [start], None, start
    while True:
        nxt_edge = next((e for e in link[cur] if e is not prev_edge), None)
        if nxt_edge is None:
            return None
        nxt = nxt_edge.other_vert(cur)
        if nxt is start:
            return ring
        ring.append(nxt)
        prev_edge, cur = nxt_edge, nxt
        if len(ring) > len(edges) + 1:
            return None


bpy.ops.wm.open_mainfile(filepath=GLASS)
col = bpy.data.collections["GlassRecovered"]

for name in ("1F", "2F"):
    dome = bpy.data.objects.get(name)
    if dome is None:
        print("### %s missing" % name)
        continue
    mw = dome.matrix_world
    bm, loops = loops_of(dome.data)
    glass_bm = bmesh.new()
    made = rims = 0
    for edges in loops:
        verts = {v for e in edges for v in e.verts}
        zs = [ (mw @ v.co).z for v in verts ]
        if max(zs) - min(zs) < RIM_HEIGHT:
            rims += 1
            continue
        ring = ordered(edges)
        if ring is None:
            print("###   %s: skipped a %d-edge loop that is not a simple ring"
                  % (name, len(edges)))
            continue
        new = [glass_bm.verts.new(mw @ v.co) for v in ring]
        try:
            glass_bm.faces.new(new)
            made += 1
        except ValueError:
            for v in new:
                glass_bm.verts.remove(v)
    bm.free()

    if not made:
        glass_bm.free()
        print("### %s: nothing to glaze" % name)
        continue
    mesh = bpy.data.meshes.new(name + "-GLASS")
    glass_bm.to_mesh(mesh); glass_bm.free()
    obj = bpy.data.objects.new(name + "-GLASS", mesh)
    col.objects.link(obj)
    area = sum(p.area for p in mesh.polygons)
    print("### %s-GLASS: %d panes (%.1f m2), %d rims left open"
          % (name, made, area, rims))

bpy.ops.wm.save_mainfile()
print("### saved")

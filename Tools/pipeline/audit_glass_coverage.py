"""Prove the recovered glazing covers every opening -- or show where it fails.

A missed pane is, in the unbroken state, an opening you can see straight
through. So each panel gets a 6 cm grid of rays fired at it from outside;
every ray must stop in the frame or in the glass. The ones that pass clean
through are collected, clustered, and marked in the scene as red spheres, so
the audit is a number AND a picture rather than a claim.

    audit_glass_coverage.py -- <glass.blend> [render.png]
"""
import bpy
import sys
import numpy as np
from mathutils import Vector
from mathutils.bvhtree import BVHTree

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
GRID = 0.06
MIN_CLUSTER = 4          # a lone miss on an edge is aliasing, not a hole

argv = sys.argv[sys.argv.index("--") + 1:]
GLASS_BLEND = argv[0]
RENDER = argv[1] if len(argv) > 1 else None

bpy.ops.wm.open_mainfile(filepath=ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1.blend")
with bpy.data.libraries.load(GLASS_BLEND) as (src, dst):
    dst.objects = [n for n in src.objects if n.endswith("-GLASS")]
glass = {}
for ob in dst.objects:
    if ob is not None:
        bpy.context.scene.collection.objects.link(ob)
        glass[ob.name[:-6]] = ob
# appended objects carry stale world matrices until the depsgraph runs, and a
# BVH built from those puts the glass at the wrong coordinates entirely
bpy.context.view_layer.update()


def bvh(obj):
    mw = obj.matrix_world
    verts = [mw @ v.co for v in obj.data.vertices]
    return BVHTree.FromPolygons(verts, [tuple(p.vertices) for p in obj.data.polygons],
                                all_triangles=False)


PANELS = sorted(n for n in glass
                if not n.startswith("STAIR"))     # the balustrade is separate
all_misses = []
for name in PANELS:
    panel = bpy.data.objects[name]
    ftree, gtree = bvh(panel), bvh(glass[name])
    mw = panel.matrix_world
    verts = [mw @ v.co for v in panel.data.vertices]
    pivot = sum(verts, Vector()) / len(verts)
    out = Vector((pivot.x, pivot.y, 0.0)).normalized()
    across = Vector((-out.y, out.x, 0.0))
    lat = [v.dot(across) for v in verts]
    hts = [v.z for v in verts]
    depth = [v.dot(out) for v in verts]
    reach = (max(depth) - min(depth)) + 2.0

    frame_hits = glass_hits = 0
    misses = []
    a = min(lat) + 0.03
    while a < max(lat):
        z = min(hts) + 0.03
        while z < max(hts):
            origin = out * (max(depth) + 1.0) + across * a + Vector((0, 0, z))
            f = ftree.ray_cast(origin, -out, reach)
            g = gtree.ray_cast(origin, -out, reach)
            if f[0] is None and g[0] is None:
                # outside the panel silhouette entirely? then ignore: the grid
                # is a bounding rectangle and panels have arched tops
                misses.append(origin - out * (1.0 + (max(depth) - min(depth)) / 2))
            elif g[0] is not None and (f[0] is None or g[3] < f[3]):
                glass_hits += 1
            else:
                frame_hits += 1
            z += GRID
        a += GRID

    # silhouette rays never touch the panel's bbox interior; separate them by
    # probing a fat cylinder: keep only misses whose neighbours include hits
    kept = []
    for m in misses:
        near_frame = ftree.find_nearest(m, 0.35)
        if near_frame[0] is not None:
            kept.append(m)
    # cluster
    used = [False] * len(kept)
    clusters = []
    for i in range(len(kept)):
        if used[i]:
            continue
        stack = [i]; used[i] = True; group = [kept[i]]
        while stack:
            j = stack.pop()
            for k in range(len(kept)):
                if not used[k] and (kept[k] - kept[j]).length < GRID * 1.9:
                    used[k] = True; stack.append(k); group.append(kept[k])
        if len(group) >= MIN_CLUSTER:
            clusters.append(group)
    n_holes = len(clusters)
    hole_pts = [sum(g, Vector()) / len(g) for g in clusters]
    all_misses += [(name, len(g), c) for g, c in zip(clusters, hole_pts)]
    print("### %-8s rays: frame=%6d glass=%6d  uncovered clusters=%d %s"
          % (name, frame_hits, glass_hits, n_holes,
             ["(%.1f,%.1f,z%.1f)x%d" % (c.x, c.y, c.z, len(g))
              for g, c in zip(clusters, hole_pts)]))

print("### TOTAL uncovered clusters: %d" % len(all_misses))

if RENDER:
    import math, os
    from mathutils import Matrix
    red = bpy.data.materials.new("Miss"); red.use_nodes = True
    nt = red.node_tree; nt.nodes.clear()
    e = nt.nodes.new("ShaderNodeEmission")
    e.inputs["Color"].default_value = (1, 0, 0, 1); e.inputs["Strength"].default_value = 6
    o = nt.nodes.new("ShaderNodeOutputMaterial"); nt.links.new(e.outputs[0], o.inputs[0])
    for _, size, centre in all_misses:
        bpy.ops.mesh.primitive_uv_sphere_add(radius=0.3, location=centre)
        bpy.context.active_object.data.materials.append(red)
    green = bpy.data.materials.new("GlassAudit"); green.use_nodes = True
    nt = green.node_tree; nt.nodes.clear()
    e = nt.nodes.new("ShaderNodeEmission"); e.inputs["Color"].default_value = (0.2, 0.95, 0.5, 1)
    o = nt.nodes.new("ShaderNodeOutputMaterial"); nt.links.new(e.outputs[0], o.inputs[0])
    for ob in glass.values():
        ob.data.materials.clear(); ob.data.materials.append(green)
    cam_d = bpy.data.cameras.new("C"); cam_d.lens = 50
    cam = bpy.data.objects.new("C", cam_d); bpy.context.scene.collection.objects.link(cam)
    bpy.context.scene.camera = cam
    w = bpy.data.worlds.new("W"); w.use_nodes = True
    w.node_tree.nodes["Background"].inputs[0].default_value = (0.10, 0.11, 0.13, 1)
    bpy.context.scene.world = w
    s = bpy.context.scene
    s.render.engine = 'BLENDER_EEVEE_NEXT'
    s.render.image_settings.file_format = 'PNG'
    s.render.resolution_x, s.render.resolution_y = 1200, 1000
    ctr = Vector((0, 0, 18)); fov = 2 * math.atan(18.0 / cam_d.lens)
    eye = ctr + Vector((0.8, 0.65, 0.25)).normalized() * (26 / math.tan(fov / 2) * 1.35)
    UP = Vector((0, 0, 1))
    f = (ctr - eye).normalized(); r = f.cross(UP).normalized(); u = r.cross(f).normalized()
    cam.matrix_world = Matrix(((r.x, u.x, -f.x, eye.x), (r.y, u.y, -f.y, eye.y),
                               (r.z, u.z, -f.z, eye.z), (0, 0, 0, 1)))
    s.render.filepath = RENDER
    bpy.ops.render.render(write_still=True)
    print("### rendered %s" % RENDER)

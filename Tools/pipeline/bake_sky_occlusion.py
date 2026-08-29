"""Bake how much sky each vertex of the assembled greenhouse can see.

This is the input the position-driven weathering layer needs: a piece under
the dome is dry no matter how weathered its module material is, and a piece
on the outer face is soaked. It has to be baked on the assembled building,
because it is a property of where the piece stands, not of its shape -- so it
cannot live in the module's UV texture. Vertex colours are per-instance and
almost free.

R = sky visibility (0 fully sheltered, 1 open to the sky)
G = the same value biased by how far the surface points up, which is what
    drives standing water and moss
B = 1 - sky visibility, kept so a shader can reach shelter without a subtract
"""
import math
import sys

import bpy
from mathutils import Vector
from mathutils.bvhtree import BVHTree

RAYS = 64
REACH = 80.0          # metres; past this, anything above is effectively sky
EPS = 0.02
BLEND = "SourceArt/Blender/GreenHouse1/GreenHouse1_Assembled.blend"
LAYER = "SkyOcclusion"

bpy.ops.wm.open_mainfile(filepath=BLEND)
meshes = [o for o in bpy.data.objects if o.type == "MESH" and not o.hide_render]

# one BVH over the whole building: a wall is sheltered by the dome, not by itself
verts, faces = [], []
for obj in meshes:
    mw = obj.matrix_world
    base = len(verts)
    verts.extend([mw @ v.co for v in obj.data.vertices])
    for poly in obj.data.polygons:
        idx = [base + i for i in poly.vertices]
        for k in range(1, len(idx) - 1):
            faces.append((idx[0], idx[k], idx[k + 1]))
bvh = BVHTree.FromPolygons(verts, faces, all_triangles=True)
print("### bvh: %d verts, %d tris" % (len(verts), len(faces)))

# a deterministic cosine-weighted hemisphere: no RNG, so the bake is repeatable
directions = []
golden = math.pi * (3.0 - math.sqrt(5.0))
for i in range(RAYS):
    z = math.sqrt((i + 0.5) / RAYS)          # cosine weighting toward the zenith
    r = math.sqrt(max(0.0, 1.0 - z * z))
    a = golden * i
    directions.append(Vector((r * math.cos(a), r * math.sin(a), z)))

UP = Vector((0, 0, 1))
done = 0
for obj in meshes:
    mw = obj.matrix_world
    nm = mw.to_3x3().inverted().transposed()
    mesh = obj.data
    colour = mesh.color_attributes.get(LAYER)
    if colour is None:
        colour = mesh.color_attributes.new(LAYER, 'FLOAT_COLOR', 'POINT')
    for v in mesh.vertices:
        origin_n = (nm @ v.normal).normalized()
        origin = (mw @ v.co) + origin_n * EPS
        seen = valid = 0
        for d in directions:
            if d.dot(origin_n) <= 0.0:        # pointing into the surface
                continue
            valid += 1
            if bvh.ray_cast(origin, d, REACH)[0] is None:
                seen += 1
        sky = (seen / valid) if valid else 0.0
        up = max(0.0, origin_n.dot(UP))
        colour.data[v.index].color = (sky, sky * up, 1.0 - sky, 1.0)
    done += 1
    if done % 10 == 0:
        print("### %d/%d objects" % (done, len(meshes)))
        sys.stdout.flush()

bpy.ops.wm.save_mainfile()
print("### sky occlusion baked into '%s' on %d objects" % (LAYER, len(meshes)))

"""Helpers shared by the Blender-side stages.

Only imported from inside Blender's interpreter (it imports bpy).
"""

import os
import sys
import math

import bpy
import bmesh
from mathutils import Vector


def stage_argv():
    """Blender passes everything after a bare '--' to the script."""
    if "--" in sys.argv:
        return sys.argv[sys.argv.index("--") + 1:]
    return []


def ensure_rdpipe_on_path():
    """Let 'from rdpipe import ...' work no matter where Blender was launched."""
    here = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    if here not in sys.path:
        sys.path.insert(0, here)


def resolve_objects(names, report=None):
    """Turn a list of object names into mesh objects, reporting misses.

    An empty list means 'every mesh object that is not obviously scratch
    geometry' -- but the caller is expected to pass names explicitly for any
    real run; the fallback exists so an inspect run on an unknown file still
    says something useful.
    """
    out = []
    for n in names:
        o = bpy.data.objects.get(n)
        if o is None:
            if report:
                report.error("object.missing", n,
                             "no object named %r in %s" % (n, bpy.data.filepath))
            continue
        if o.type != "MESH":
            if report:
                report.error("object.not_mesh", n,
                             "object %r is a %s, not a MESH" % (n, o.type))
            continue
        out.append(o)
    return out


def evaluated_mesh(obj, depsgraph):
    """Mesh with modifiers applied, as a throwaway copy.

    Inspection has to look at what will actually be exported, and the exporter
    runs with Apply Modifiers on (see the FBX settings in
    docs/architecture/tooling/Blender到Unity导出管线.md section 4).
    """
    eval_obj = obj.evaluated_get(depsgraph)
    return eval_obj.to_mesh()


def free_evaluated(obj, depsgraph):
    obj.evaluated_get(depsgraph).to_mesh_clear()


def is_identity_rotation(obj, tol=1e-4):
    return all(abs(a) < tol for a in obj.rotation_euler)


def is_unit_scale(obj, tol=1e-4):
    return all(abs(s - 1.0) < tol for s in obj.scale)


def is_uniform_scale(obj, tol=1e-4):
    s = obj.scale
    return abs(s[0] - s[1]) < tol and abs(s[1] - s[2]) < tol


def has_delta_transform(obj, tol=1e-6):
    return (any(abs(v) > tol for v in obj.delta_location)
            or any(abs(v) > tol for v in obj.delta_rotation_euler)
            or any(abs(v - 1.0) > tol for v in obj.delta_scale))


def world_area(mesh, matrix):
    """Surface area in square metres, in world space."""
    total = 0.0
    for poly in mesh.polygons:
        vs = [matrix @ mesh.vertices[i].co for i in poly.vertices]
        for i in range(1, len(vs) - 1):
            total += (vs[i] - vs[0]).cross(vs[i + 1] - vs[0]).length * 0.5
    return total


def uv_area(mesh, uv_layer):
    """Area covered in UV space (0-1 square = 1.0)."""
    total = 0.0
    data = uv_layer.data
    for poly in mesh.polygons:
        uvs = [Vector(data[li].uv) for li in poly.loop_indices]
        for i in range(1, len(uvs) - 1):
            a, b, c = uvs[0], uvs[i], uvs[i + 1]
            total += abs((b - a).cross(c - a)) * 0.5
    return total


def per_face_texel_density(mesh, matrix, uv_layer, resolution):
    """Texels per world metre, per face.  Returns a list, skipping degenerate
    faces (a face with no world area or no UV area has no meaningful density)."""
    out = []
    data = uv_layer.data
    for poly in mesh.polygons:
        vs = [matrix @ mesh.vertices[i].co for i in poly.vertices]
        uvs = [Vector(data[li].uv) for li in poly.loop_indices]
        wa = 0.0
        ua = 0.0
        for i in range(1, len(vs) - 1):
            wa += (vs[i] - vs[0]).cross(vs[i + 1] - vs[0]).length * 0.5
            ua += abs((uvs[i] - uvs[0]).cross(uvs[i + 1] - uvs[0])) * 0.5
        if wa <= 1e-9 or ua <= 1e-12:
            continue
        out.append(math.sqrt(ua) * resolution / math.sqrt(wa))
    return out


def non_manifold_edges(obj):
    """Count of non-manifold edges on the *base* mesh."""
    bm = bmesh.new()
    try:
        bm.from_mesh(obj.data)
        return sum(1 for e in bm.edges if not e.is_manifold)
    finally:
        bm.free()


def loose_geometry(obj):
    bm = bmesh.new()
    try:
        bm.from_mesh(obj.data)
        loose_verts = sum(1 for v in bm.verts if not v.link_edges)
        loose_edges = sum(1 for e in bm.edges if not e.link_faces)
        return loose_verts, loose_edges
    finally:
        bm.free()


def degenerate_faces(obj, area_eps=1e-9):
    bm = bmesh.new()
    try:
        bm.from_mesh(obj.data)
        return sum(1 for f in bm.faces if f.calc_area() < area_eps)
    finally:
        bm.free()

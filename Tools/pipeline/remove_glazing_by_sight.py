"""Delete the panes that still block the small openings on every wall panel.

Five general rules were tried and none survives this mesh: the panes differ
in size, one is a single polygon whose tab covers one opening and not its
mirror twin, the frame curves so "set back from the outer skin" has no single
value, and 1963 non-manifold edges make any parity argument unsound.

What is solid ground: a ray fired at an opening tells you exactly what blocks
it, and the eight wall panels are one module copied around the octagon --
they align to 0.0001 m. So the blockers are found once on a reference panel
by sight, then carried to the others by rigid alignment.

    remove_glazing_by_sight.py -- [--dry] <file.blend> [<file.blend> ...]
"""
import bmesh
import bpy
import math
import sys
from mathutils import Matrix, Vector
from mathutils.bvhtree import BVHTree

REFERENCE = "L-W1"
# centres of the two small openings that stayed blocked, and the height of
# the row, in the reference panel's own coordinates
OPENINGS = ((-2.036, 10.376), (2.077, 10.376))
TOL = 0.02


def is_wall(name):
    core = name[:-2] if name.endswith("_T") else name
    return ("-W" in core and "WIN" not in core and "COLUMN" not in core) \
        or core == "GreenHouse1Wall"


def blockers(obj, openings):
    """Every face a ray meets on its way through each opening.

    The tree is built from the mesh rather than using Object.ray_cast, which
    needs an evaluated mesh and so refuses on the hidden master copies that
    sit alongside the placed instances in the assembly.
    """
    mesh = obj.data
    verts = [obj.matrix_world @ v.co for v in mesh.vertices]
    polys = [tuple(p.vertices) for p in mesh.polygons]
    tree = BVHTree.FromPolygons(verts, polys, all_triangles=False)

    found = set()
    for y, z in openings:
        point = Vector((-40.0, y, z))
        direction = Vector((1.0, 0.0, 0.0))
        for _ in range(8):
            loc, _, idx, _ = tree.ray_cast(point, direction, 60.0)
            if loc is None:
                break
            found.add(idx)
            point = loc + direction * 0.001
    return found


def rigid_candidates():
    out = []
    for k in range(8):
        rot = Matrix.Rotation(math.radians(45 * k), 3, 'Z')
        out.append(rot)
        out.append(rot @ Matrix.Diagonal(Vector((-1.0, 1.0, 1.0))).to_3x3())
    return out


argv = sys.argv[sys.argv.index("--") + 1:]
dry = "--dry" in argv
for path in [a for a in argv if a != "--dry"]:
    bpy.ops.wm.open_mainfile(filepath=path)
    ref = next((o for o in bpy.data.objects
                if o.type == "MESH" and o.name.split("_")[0] == REFERENCE), None)
    if ref is None:
        ref = next(o for o in bpy.data.objects if o.type == "MESH" and is_wall(o.name))
    doomed_ref = blockers(ref, OPENINGS)
    if not doomed_ref:
        print("### %s: nothing blocks the openings" % path.rsplit("/", 1)[-1])
        continue
    ref_centres = [ref.data.polygons[i].center.copy() for i in doomed_ref]
    ref_areas = [ref.data.polygons[i].area for i in doomed_ref]
    ref_pivot = sum((p.center for p in ref.data.polygons), Vector()) / len(ref.data.polygons)

    report = []
    for obj in bpy.data.objects:
        if obj.type != "MESH" or not is_wall(obj.name) or len(obj.data.polygons) < 100:
            continue
        centres = [p.center.copy() for p in obj.data.polygons]
        pivot = sum(centres, Vector()) / len(centres)
        best, best_err = None, 1e9
        for M in rigid_candidates():
            moved = [M @ (c - ref_pivot) for c in ref_centres]
            err = sum(min((m - (c - pivot)).length for c in centres) for m in moved)
            if err < best_err:
                best_err, best = err, M
        hits = []
        for m, area in zip([best @ (c - ref_pivot) for c in ref_centres], ref_areas):
            target = m + pivot
            near = min(range(len(centres)), key=lambda i: (centres[i] - target).length)
            if (centres[near] - target).length < TOL and \
                    abs(obj.data.polygons[near].area - area) < max(area * 0.05, 0.01):
                hits.append(near)
        if hits:
            report.append((obj.name, sorted(set(hits)), best_err))
            if not dry:
                bm = bmesh.new(); bm.from_mesh(obj.data)
                bm.faces.ensure_lookup_table()
                bmesh.ops.delete(bm, geom=[bm.faces[i] for i in set(hits)], context='FACES')
                bm.to_mesh(obj.data); obj.data.update(); bm.free()
    if not dry:
        bpy.ops.wm.save_mainfile()
    print("### %s%s  reference blockers=%s"
          % (path.rsplit("/", 1)[-1], " (dry run)" if dry else "", sorted(doomed_ref)))
    for name, hits, err in report:
        print("###    %-14s faces=%s  align_err=%.4f" % (name, hits, err))

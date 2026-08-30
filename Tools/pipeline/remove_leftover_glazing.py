"""Delete the glazing pane that survived the cull on every greenhouse panel.

Each wall and window panel carries exactly one face that looks back towards
the middle of the building, sitting between the frame's two skins -- where a
pane of glass sits -- and with nothing at its mirror position. Every other
comparable face on the panel looks outwards. From outside it is culled, so
the outside view is symmetric; from inside it renders, so one small opening
reads solid and its twin does not.

Deleting it restores symmetry in both views. Flipping it would not: the pane
would then appear from outside on one side only.

Deleting a face leaves every other face's UVs untouched, so the baked
textures stay valid and only the FBX has to be exported again.

    remove_leftover_glazing.py -- <file.blend> [<file.blend> ...]
"""
import bmesh
import bpy
import sys

MIN_AREA = 0.05
INWARD = 0.9


def is_panel(name):
    core = name[:-2] if name.endswith("_T") else name
    if "COLUMN" in core:
        return False
    return ("-W" in core) or core in ("GreenHouse1Wall", "GreenHouse1Window")


def clean(path):
    bpy.ops.wm.open_mainfile(filepath=path)
    removed = []
    for obj in bpy.data.objects:
        if obj.type != "MESH" or not is_panel(obj.name):
            continue
        mesh = obj.data
        if len(mesh.polygons) < 100:
            continue
        bm = bmesh.new(); bm.from_mesh(mesh)
        bm.faces.ensure_lookup_table()
        doomed = []
        for face in bm.faces:
            if face.calc_area() <= MIN_AREA:
                continue
            centre = obj.matrix_world @ face.calc_center_median()
            normal = (obj.matrix_world.to_3x3() @ face.normal).normalized()
            radial = centre.copy(); radial.z = 0.0
            if radial.length < 1e-6:
                continue
            radial.normalize()
            if -normal.dot(radial) > INWARD:
                doomed.append(face)
        if doomed:
            bmesh.ops.delete(bm, geom=doomed, context='FACES')
            bm.to_mesh(mesh); mesh.update()
            removed.append((obj.name, len(doomed)))
        bm.free()
    bpy.ops.wm.save_mainfile()
    print("### %s: removed %d faces on %d panels%s"
          % (path.rsplit("/", 1)[-1], sum(n for _, n in removed), len(removed),
             "" if not removed else " (" + ", ".join(
                 "%s x%d" % (n, k) for n, k in removed[:4]) + (", ..." if len(removed) > 4 else "") + ")"))


for target in sys.argv[sys.argv.index("--") + 1:]:
    clean(target)

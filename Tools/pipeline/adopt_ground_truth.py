"""Copy the hand-corrected preview's meshes back into the source files.

The preview is a generated file, so work done in it is normally thrown
away on the next run. When it has been edited by hand it becomes the
authority instead, and the generators downstream of it are the ones that
have to catch up: this pushes its meshes into the master and the glass
file so a rebuild reproduces the corrections rather than reverting them.

Only the faces the truth has dropped are deleted, matched by their vertex
positions rather than by index. Rebuilding each mesh wholesale would be
simpler but would discard the UVs, and the module textures are baked
against those. Materials and transforms stay as the destination has them:
the preview recolours everything and its palette must not travel back.

    adopt_ground_truth.py -- <truth.blend> <target.blend> [<target.blend> ...]
"""
import bmesh
import bpy
import sys

argv = sys.argv[sys.argv.index("--") + 1:]
TRUTH, TARGETS = argv[0], argv[1:]

bpy.ops.wm.open_mainfile(filepath=TRUTH)
source = {}
for obj in bpy.data.objects:
    if obj.type != "MESH":
        continue
    mesh = obj.data
    # keyed by the vertex ring so a face can be recognised in the target
    # whatever order its own file happens to store them in
    key = lambda p: tuple(sorted(tuple(round(c, 5) for c in mesh.vertices[i].co)
                                 for i in p.vertices))
    source[obj.name] = {key(p) for p in mesh.polygons}
print("### truth carries %d meshes" % len(source))

for target in TARGETS:
    bpy.ops.wm.open_mainfile(filepath=target)
    changed = skipped = 0
    for obj in bpy.data.objects:
        if obj.type != "MESH":
            continue
        base = obj.name[:-2] if obj.name.endswith("_T") else obj.name
        entry = source.get(obj.name) or source.get(base)
        if entry is None:
            skipped += 1
            continue
        mesh = obj.data
        before = len(mesh.polygons)
        if before == len(entry):
            continue
        # Delete only what the truth no longer has. Rebuilding the mesh from
        # scratch would drop the UVs with it, and the module textures are
        # baked against those -- deleting faces leaves every remaining face's
        # UVs exactly where they were.
        key = lambda p: tuple(sorted(tuple(round(c, 5) for c in mesh.vertices[i].co)
                                     for i in p.vertices))
        doomed = [p.index for p in mesh.polygons if key(p) not in entry]
        if not doomed:
            continue
        bm = bmesh.new(); bm.from_mesh(mesh)
        bm.faces.ensure_lookup_table()
        bmesh.ops.delete(bm, geom=[bm.faces[i] for i in doomed], context='FACES')
        bm.to_mesh(mesh); bm.free()
        mesh.update()
        changed += 1
        print("###   %-18s %d -> %d faces (%d removed)"
              % (obj.name, before, len(mesh.polygons), len(doomed)))
    bpy.ops.wm.save_mainfile()
    print("### %s: %d meshes replaced, %d not in the truth"
          % (target.rsplit("/", 1)[-1], changed, skipped))

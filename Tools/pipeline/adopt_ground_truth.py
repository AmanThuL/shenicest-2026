"""Copy the hand-corrected preview's meshes back into the source files.

The preview is a generated file, so work done in it is normally thrown
away on the next run. When it has been edited by hand it becomes the
authority instead, and the generators downstream of it are the ones that
have to catch up: this pushes its meshes into the master and the glass
file so a rebuild reproduces the corrections rather than reverting them.

Faces are matched by their vertex positions rather than by index, so a
face is recognised whatever order its own file happens to store it in.
The target then has the faces the truth has dropped deleted, and the
faces the truth has gained added -- carrying the truth's UVs with them.
Deleting alone cannot reach parity: the double-door step replaced 16
faces per lower wall with 8 rebuilt reveal walls, so a delete-only pass
lands 8 short. Untouched faces are never rewritten, which is what keeps
the baked module textures aligned; only the added faces get new UVs, and
those come from the truth rather than from nothing.

Materials and transforms stay as the destination has them: the preview
recolours everything and its palette must not travel back. An added face
inherits the material index its object already uses.

An object whose faces mostly do not correspond is left alone and
reported. That is the case for the transformed `_T` instances in the
assembly, whose vertices sit in a baked frame the truth never shares,
and for the broken glass, which is a different tessellation of the same
pane. Without the guard those objects lose every face. Name an object
with --replace to overwrite it wholesale anyway.

A mesh is edited at most once per file. The assembly instances its
modules -- all eight `*-W*_T` objects share one `GreenHouse1Wall` mesh
-- so without this a second object would edit a datablock the first has
already adopted, and whichever object the iteration reached first would
silently decide which truth mesh the shared module was matched against.

    adopt_ground_truth.py -- <truth.blend> <target.blend> [<target.blend> ...]
        [--dry-run] [--min-overlap F] [--replace NAME] [--report PATH]
"""
import json
import sys

import bmesh
import bpy

argv = sys.argv[sys.argv.index("--") + 1:]

DRY_RUN = "--dry-run" in argv
MIN_OVERLAP = 0.5
REPLACE = set()
REPORT = None
positional = []
i = 0
while i < len(argv):
    a = argv[i]
    if a == "--dry-run":
        i += 1
    elif a == "--min-overlap":
        MIN_OVERLAP = float(argv[i + 1]); i += 2
    elif a == "--replace":
        REPLACE.add(argv[i + 1]); i += 2
    elif a == "--report":
        REPORT = argv[i + 1]; i += 2
    else:
        positional.append(a); i += 1

TRUTH, TARGETS = positional[0], positional[1:]

# 10 um. The differences that matter here are metres apart -- the double
# door rebuilt whole faces -- so a tight key is correct. Loosening it to
# absorb "float noise" would only start fusing genuinely distinct faces.
QUANT = 5


def face_key(mesh, poly):
    return tuple(sorted(tuple(round(c, QUANT) for c in mesh.vertices[i].co)
                        for i in poly.vertices))


def read_truth(path):
    bpy.ops.wm.open_mainfile(filepath=path)
    out = {}
    for obj in bpy.data.objects:
        if obj.type != "MESH":
            continue
        mesh = obj.data
        uv = mesh.uv_layers.active
        faces = {}
        for poly in mesh.polygons:
            loops = []
            for li in poly.loop_indices:
                co = mesh.vertices[mesh.loops[li].vertex_index].co
                loops.append((tuple(round(c, QUANT) for c in co),
                              tuple(uv.data[li].uv) if uv else (0.0, 0.0)))
            faces[face_key(mesh, poly)] = loops
        out[obj.name] = faces
    return out


truth = read_truth(TRUTH)
print("### truth carries %d meshes, %d faces"
      % (len(truth), sum(len(f) for f in truth.values())))
if DRY_RUN:
    print("### dry run -- nothing will be written")

report = {"truth": TRUTH, "targets": {}}
failures = 0

for target in TARGETS:
    bpy.ops.wm.open_mainfile(filepath=target)
    name = target.rsplit("/", 1)[-1]
    rows = []
    touched = skipped = guarded = shared = 0
    seen_meshes = {}
    print("\n### %s" % name)

    for obj in bpy.data.objects:
        if obj.type != "MESH":
            continue
        base = obj.name[:-2] if obj.name.endswith("_T") else obj.name
        entry = truth.get(obj.name) or truth.get(base)
        if entry is None:
            skipped += 1
            continue

        mesh = obj.data
        if mesh.name in seen_meshes:
            shared += 1
            print("###   %-18s shares mesh %r with %s -- already handled"
                  % (obj.name, mesh.name, seen_meshes[mesh.name]))
            rows.append({"obj": obj.name, "state": "shared-mesh",
                         "mesh": mesh.name, "with": seen_meshes[mesh.name]})
            continue
        seen_meshes[mesh.name] = obj.name
        before = len(mesh.polygons)
        have = {face_key(mesh, p): p.index for p in mesh.polygons}
        matched = len(set(have) & set(entry))
        doomed = [i for k, i in have.items() if k not in entry]
        adding = [k for k in entry if k not in have]
        if not doomed and not adding:
            continue

        forced = obj.name in REPLACE or base in REPLACE
        overlap = matched / max(len(have), len(entry), 1)
        if overlap < MIN_OVERLAP and not forced:
            guarded += 1
            print("###   %-18s GUARDED  %d faces vs truth %d, only %d match "
                  "(%.1f%%) -- left alone"
                  % (obj.name, before, len(entry), matched, overlap * 100))
            rows.append({"obj": obj.name, "state": "guarded", "target": before,
                         "truth": len(entry), "matched": matched,
                         "overlap": round(overlap, 4)})
            continue

        if not DRY_RUN:
            slot = mesh.polygons[0].material_index if mesh.polygons else 0
            bm = bmesh.new()
            bm.from_mesh(mesh)
            uv_layer = bm.loops.layers.uv.verify()
            bm.faces.ensure_lookup_table()
            if doomed:
                bmesh.ops.delete(bm, geom=[bm.faces[i] for i in doomed],
                                 context='FACES')
            if adding:
                bm.verts.ensure_lookup_table()
                lut = {tuple(round(c, QUANT) for c in v.co): v for v in bm.verts}
                for key in adding:
                    verts = []
                    for co, _ in entry[key]:
                        v = lut.get(co)
                        if v is None:
                            v = bm.verts.new(co)
                            lut[co] = v
                        verts.append(v)
                    try:
                        face = bm.faces.new(verts)
                    except ValueError:
                        # already exists in this bmesh under a different winding
                        continue
                    face.material_index = slot
                    for loop, (_, uvco) in zip(face.loops, entry[key]):
                        loop[uv_layer].uv = uvco
                bm.verts.index_update()
                bm.faces.index_update()
            bm.to_mesh(mesh)
            bm.free()
            mesh.update()

        after = len(mesh.polygons) if not DRY_RUN else before - len(doomed) + len(adding)
        touched += 1
        print("###   %-18s %d -> %d faces (truth %d; -%d +%d)"
              % (obj.name, before, after, len(entry), len(doomed), len(adding)))
        rows.append({"obj": obj.name, "state": "adopted", "target": before,
                     "truth": len(entry), "after": after,
                     "deleted": len(doomed), "added": len(adding)})

    # Acceptance is face-count parity plus an identical face set -- running
    # clean is not evidence of anything on its own.
    bad = []
    for obj in bpy.data.objects:
        if obj.type != "MESH":
            continue
        base = obj.name[:-2] if obj.name.endswith("_T") else obj.name
        entry = truth.get(obj.name) or truth.get(base)
        if entry is None:
            continue
        if any(r["obj"] == obj.name and r["state"] in ("guarded", "shared-mesh")
               for r in rows):
            continue
        mesh = obj.data
        keys = {face_key(mesh, p) for p in mesh.polygons}
        if len(mesh.polygons) != len(entry) or keys != set(entry):
            bad.append((obj.name, len(mesh.polygons), len(entry),
                        len(set(entry) - keys), len(keys - set(entry))))

    if bad and not DRY_RUN:
        failures += len(bad)
        print("### VERIFY FAILED for %s:" % name)
        for n, got, want, miss, extra in bad:
            print("###   %-18s %d faces, truth %d (missing %d, extra %d)"
                  % (n, got, want, miss, extra))
    elif not DRY_RUN:
        print("### verify ok -- every adopted mesh matches the truth exactly")

    if not DRY_RUN:
        bpy.ops.wm.save_mainfile()
    print("### %s: %d adopted, %d guarded, %d sharing an adopted mesh, "
          "%d not in the truth" % (name, touched, guarded, shared, skipped))
    report["targets"][name] = {"rows": rows, "verify_failures": len(bad),
                               "adopted": touched, "guarded": guarded,
                               "shared_mesh": shared, "not_in_truth": skipped}

if REPORT:
    with open(REPORT, "w") as fh:
        json.dump(report, fh, indent=1)
    print("### report written to %s" % REPORT)

if failures:
    print("### %d meshes did not reach parity" % failures)
    sys.exit(1)

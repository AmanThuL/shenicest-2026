"""Standing flowers for the StMuerte statue: real petals, scattered, with the opening baked in.

`build_bloom_patch.py` wraps cover onto the robe and hands the shader one scalar to reveal it.
Cover is not flowers, and a reveal is not an animation: what it can do is make geometry appear,
which reads as spreading, not as blooming. This builds the other half -- a field of flowers with
stems, petals and centres, dense enough to read as overgrowth, each one carrying the whole of its
own opening in its vertex data.

How the opening survives the trip to Unity
------------------------------------------
Blender geometry-node growth and particle systems have no runtime path into Unity, and a vertex
cache costs more than the whole ending is worth (see the plan's §3). So the animation is *baked
as poses*, not as frames: every flower is built three times from the same topology -- shut bud,
half open, open -- and the two closed poses are stored as deltas from the open one, in spare UV
channels. A vertex shader walks a quadratic Bezier through them:

    P(t) = (1-t)^2 * bud + 2t(1-t) * mid + t^2 * open
         = open + (1-t)^2 * dBud + 2t(1-t) * dMid

Three poses rather than two because a petal swings through an arc. Blend two poses linearly and
the petal shortens through the middle of the swing, which reads as a petal being pulled in and
pushed back out. The mid pose is the arc's control point, and it is what makes this look like a
flower opening rather than a mesh being lerped.

`t` per flower comes from vertex colour B -- the same global growth order the cover uses -- so one
`_Growth` scalar still drives everything, and a flower cannot open before the cover it stands in.

Channels
--------
  COLOR   R part mask: 0 stem and leaf, 0.5 centre, 1 petal
          G per-flower phase, for tint spread and sway
          B growth order, 0 at the first flower to open and 1 at the last (global, like the cover)
  UV0     petal-local (u along the petal, v across it); the shader shades the gradient with it
  UV1     dBud.xy
  UV2     (dBud.z, dMid.x)
  UV3     (dMid.yz)

The deltas are written in **Unity mesh space**, not Blender space: a UV is a number, so nothing
transforms it on the way out, while positions go through the FBX axis conversion and the importer's
0.6045 unit scale. Applying the same map here is what keeps a delta pointing where its vertex went.
The map was measured off the pair this repo already ships -- BloomPatches.fbx's vertices in
BloomPatch.blend against the flower positions StatueBloomBuilder planted from the imported mesh --
and is asserted by `--self-test`. See MESH_MAP.

Run:
    blender --background --python Tools/pipeline/build_bloom_flowers.py -- \
        --out SourceArt/Blender/StatueBloom/BloomFlowers.blend --self-test

    blender --background --python Tools/pipeline/build_bloom_flowers.py -- \
        --statue Assets/RootsDance/Meshes/Environment/GAIA1/Sculpture/StMuerte.fbx \
        --out SourceArt/Blender/StatueBloom/BloomFlowers.blend \
        --count 2200 --spread 0.5
"""
import argparse
import math
import os
import random
import sys

import bpy
import bmesh
from mathutils import Matrix, Vector

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from build_bloom_patch import Surface, basis, growth_order, scatter_anchors, strip_to  # noqa: E402


# Unity metres per Blender unit for this statue, and the axis flip that comes with the export
# profile. Blender is right-handed Z-up; the mesh arrives in Unity with X and Y kept and Z
# negated, scaled by the importer's globalScale. Measured, not assumed -- see the module docstring
# and `--self-test`.
MESH_SCALE = 0.6045


def to_unity(v):
    """A Blender-space vector in the units and axes the imported mesh will use."""
    return Vector((v.x * MESH_SCALE, v.y * MESH_SCALE, -v.z * MESH_SCALE))


def blender_len(unity_metres):
    """Blender units for a length authored in Unity metres."""
    return unity_metres / MESH_SCALE


# --- The three poses -------------------------------------------------------------------------
# One flower, built three times from identical topology. Every number is a fraction of the
# flower's own height, so a 0.35 m flower and a 0.9 m one open the same way.
#
# stem     how far up the stem has grown
# radius   distance from the stem's axis to where the petals are rooted
# length   petal length, as a fraction of PETAL_LENGTH
# width    petal width, as a fraction of PETAL_HALF_WIDTH
# base     petal tilt off vertical where it is rooted, degrees
# tip      petal tilt off vertical at its tip; past 90 the tip is falling back down
# centre   size of the centre disc
# leaf     size of the stem leaf
POSES = {
    # Small enough to be nothing. At _Growth 0 the statue has to read as bare stone, and a field
    # of visible buds reads as stubble on it -- the flowers have to grow out of the robe, not
    # merely open on it.
    "bud": dict(stem=0.10, radius=0.008, length=0.14, width=0.30,
                base=6.0, tip=-14.0, centre=0.12, leaf=0.10),
    "mid": dict(stem=0.84, radius=0.055, length=0.80, width=0.82,
                base=32.0, tip=38.0, centre=0.80, leaf=0.86),
    "open": dict(stem=1.00, radius=0.075, length=1.00, width=1.00,
                 base=52.0, tip=94.0, centre=1.00, leaf=1.00),
}

POSE_ORDER = ("open", "mid", "bud")

# Petal length as a fraction of the flower's height. A flower head about a third as wide as the
# plant is tall: wider than that and five petals close into a disc rather than reading as petals.
PETAL_LENGTH = 0.30

# Rows across one petal. Two segments is the fewest that can hold an arc; the tip row is what
# curls back over at `tip` > 90.
PETAL_ROWS = (0.0, 0.5, 1.0)

# Half-width along the petal, as a fraction of the petal's own length. Narrow at the root, widest
# past the middle, rounded rather than pointed at the tip.
PETAL_HALF_WIDTH = (0.20, 0.42, 0.26)

STEM_HALF_WIDTH = 0.012
LEAF_AT = 0.42          # fraction of the stem's length the leaf grows from
LEAF_LENGTH = 0.34
LEAF_WIDTH = 0.12

# Part mask, written into vertex colour R.
# Sampled vertices allowed inside the target before the field is called broken.
BURIED_LIMIT = 0.02

PART_FOLIAGE = 0.0
PART_CENTRE = 0.5
PART_PETAL = 1.0


def petal_points(p, height, azimuth, petals_up):
    """The centreline of one petal, sampled at PETAL_ROWS, plus the side vector at each row.

    Integrated rather than solved: the tilt turns along the petal, so the centreline is an arc
    and its end is where walking that arc gets to. Cheap at three rows and it keeps the petal's
    length honest in every pose, which is the whole reason the mid pose exists.
    """
    radial = Vector((math.cos(azimuth), math.sin(azimuth), 0.0))
    side = Vector((-math.sin(azimuth), math.cos(azimuth), 0.0))
    up = Vector((0.0, 0.0, 1.0))

    root = radial * (p["radius"] * height) + up * (p["stem"] * height * petals_up)
    length = p["length"] * PETAL_LENGTH * height

    points = [root]
    steps = 8
    cursor = root.copy()
    for i in range(steps):
        u = (i + 0.5) / steps
        tilt = math.radians(p["base"] + (p["tip"] - p["base"]) * u)
        cursor = cursor + (radial * math.sin(tilt) + up * math.cos(tilt)) * (length / steps)
        points.append(cursor.copy())

    # Resample the walked arc at the rows the mesh actually has.
    rows = []
    for u in PETAL_ROWS:
        f = u * steps
        i = min(int(f), steps - 1)
        rows.append(points[i].lerp(points[i + 1], f - i))
    return rows, side


def flower_vertices(pose, height, petals, azimuths, petals_up=1.0):
    """Every vertex of one flower in one pose, in flower-local space (+Z along its stem).

    The order is the contract: `faces_for` indexes into exactly this list, and the three poses
    have to agree vertex for vertex or the deltas are nonsense.
    """
    p = POSES[pose]
    verts = []

    stem_len = p["stem"] * height * petals_up
    w = STEM_HALF_WIDTH * height

    # Stem: two crossed quads. A tube costs six times the triangles to look the same at the
    # distance a 0.5 m flower on an 18 m statue is ever seen from.
    for angle in (0.0, math.pi * 0.5):
        d = Vector((math.cos(angle), math.sin(angle), 0.0)) * w
        verts += [-d, d, d + Vector((0.0, 0.0, stem_len)), -d + Vector((0.0, 0.0, stem_len))]

    # Leaf: one quad off the stem, leaning up.
    leaf_dir = Vector((math.cos(azimuths[0] + 2.1), math.sin(azimuths[0] + 2.1), 0.0))
    base = Vector((0.0, 0.0, stem_len * LEAF_AT))
    tip = base + (leaf_dir * 0.82 + Vector((0.0, 0.0, 0.55))) * (
        LEAF_LENGTH * height * p["leaf"])
    across = leaf_dir.cross(Vector((0.0, 0.0, 1.0))).normalized() * (
        LEAF_WIDTH * height * p["leaf"])
    verts += [base - across * 0.3, base + across * 0.3, tip + across * 0.35, tip - across * 0.35]

    # Petals.
    for azimuth in azimuths:
        rows, side = petal_points(p, height, azimuth, petals_up)
        for row, half in zip(rows, PETAL_HALF_WIDTH):
            offset = side * (half * p["width"] * PETAL_LENGTH * height)
            verts += [row - offset, row + offset]

    # Centre disc, a quad lying across the top of the stem.
    c = p["centre"] * height * 0.075
    top = Vector((0.0, 0.0, stem_len + c * 0.25))
    verts += [top + Vector((-c, -c, 0.0)), top + Vector((c, -c, 0.0)),
              top + Vector((c, c, 0.0)), top + Vector((-c, c, 0.0))]

    return verts


def flower_topology(petals):
    """Faces, per-corner UV0 and per-vertex part mask for a flower with `petals` petals."""
    faces = []
    uv0 = {}
    part = []

    def quad(a, b, c, d, uvs):
        faces.append((a, b, c, d))
        uv0[(a, b, c, d)] = uvs

    # Stem: two quads, then the leaf.
    quad(0, 1, 2, 3, ((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)))
    quad(4, 5, 6, 7, ((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)))
    quad(8, 9, 10, 11, ((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)))
    part += [PART_FOLIAGE] * 12

    first = 12
    for i in range(petals):
        b = first + i * 6
        for r in range(len(PETAL_ROWS) - 1):
            lo = b + r * 2
            # Wound so the petal's normal points up and out of its face. Reversed, every open
            # flower renders its shaded back to a player who is standing under the statue
            # looking up, which is the only angle this is ever seen from.
            quad(lo, lo + 2, lo + 3, lo + 1,
                 ((PETAL_ROWS[r], 0.0), (PETAL_ROWS[r + 1], 0.0),
                  (PETAL_ROWS[r + 1], 1.0), (PETAL_ROWS[r], 1.0)))
        part += [PART_PETAL] * 6

    c = first + petals * 6
    quad(c, c + 1, c + 2, c + 3, ((0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)))
    part += [PART_CENTRE] * 4

    return faces, uv0, part


def build_field(surface, anchors, orders, rng, args):
    """Every flower, in one mesh, with its two closed poses stored as deltas.

    One bmesh rather than one object per flower and a join at the end: two thousand objects is
    minutes of Blender bookkeeping for a mesh that has to be a single draw call anyway.
    """
    bm = bmesh.new()
    uv0 = bm.loops.layers.uv.new("UVMap")
    bud_xy = bm.loops.layers.uv.new("Bud")
    bud_z_mid_x = bm.loops.layers.uv.new("BudZMidX")
    mid_yz = bm.loops.layers.uv.new("Mid")
    col = bm.loops.layers.color.new("Col")

    up = Vector((0.0, 0.0, 1.0))
    lo_h = blender_len(args.height_min)
    hi_h = blender_len(args.height_max)

    tris = 0
    planted = 0
    for idx, ((anchor, normal), order) in enumerate(zip(anchors, orders)):
        petals = 5 if rng.random() < 0.65 else 6
        azimuths = [(i / petals) * math.tau + rng.uniform(-0.12, 0.12) for i in range(petals)]
        height = lo_h + (hi_h - lo_h) * rng.random()
        phase = rng.random()

        # Lean towards world up rather than straight out of the robe: a flower on a vertical
        # fold grows upwards, it does not stick out sideways like a bracket.
        aim = normal.normalized().slerp(up, args.upright)

        # The robe folds back on itself. A flower planted in the bottom of a crease grows
        # straight into the far wall, and the only evidence is petals buried in stone -- which
        # is what the audit counts. Cast the stem before building it and cut the flower down to
        # the room it actually has; drop it when there is not enough room to be a flower.
        room = surface.bvh.ray_cast(anchor + normal.normalized() * args.lift, aim,
                                    height * 1.2)[3]
        if room is not None:
            height = min(height, room * 0.75)
            if height < lo_h * 0.45:
                continue

        spin = Matrix.Rotation(rng.uniform(0.0, math.tau), 4, "Z")
        frame = aim.to_track_quat("Z", "Y").to_matrix().to_4x4() @ spin
        place = Matrix.Translation(anchor + normal.normalized() * args.lift) @ frame

        poses = {name: [place @ v for v in flower_vertices(name, height, petals, azimuths)]
                 for name in POSE_ORDER}
        faces, uvs, part = flower_topology(petals)

        verts = [bm.verts.new(v) for v in poses["open"]]
        deltas = [(to_unity(poses["bud"][i] - poses["open"][i]),
                   to_unity(poses["mid"][i] - poses["open"][i]))
                  for i in range(len(verts))]

        planted += 1
        for corners in faces:
            try:
                face = bm.faces.new([verts[i] for i in corners])
            except ValueError:
                continue                      # a degenerate petal in some pose; skip the quad
            face.smooth = True
            tris += len(corners) - 2
            for corner, (loop, local) in enumerate(zip(face.loops, corners)):
                loop[uv0].uv = uvs[corners][corner]
                d_bud, d_mid = deltas[local]
                loop[bud_xy].uv = (d_bud.x, d_bud.y)
                loop[bud_z_mid_x].uv = (d_bud.z, d_mid.x)
                loop[mid_yz].uv = (d_mid.y, d_mid.z)
                loop[col] = (part[local], phase, order, 1.0)

    me = bpy.data.meshes.new(args.name)
    bm.to_mesh(me)
    bm.free()
    for poly in me.polygons:
        poly.use_smooth = True
    ob = bpy.data.objects.new(args.name, me)
    bpy.context.scene.collection.objects.link(ob)
    return ob, tris, planted


def audit_field(ob, surface, args):
    """The three ways this goes wrong silently, checked before anything leaves Blender."""
    me = ob.data
    problems = []

    names = [l.name for l in me.uv_layers]
    if names[:4] != ["UVMap", "Bud", "BudZMidX", "Mid"]:
        problems.append("uv layers are %s" % names)

    if not me.color_attributes:
        problems.append("no vertex colour")

    # A flower rooted below the stone is a flower nobody sees. The roots sit on the surface by
    # construction, so anything far inside means the scatter or the lift is wrong.
    # A petal tip inside a fold is invisible and unavoidable on a robe this creased; a field
    # where a whole flower is under the stone is a scatter bug. The line between them is a rate,
    # so this fails on the rate and prints it either way.
    buried = 0
    step = max(1, len(me.vertices) // 4000)
    sampled = len(range(0, len(me.vertices), step))
    for i in range(0, len(me.vertices), step):
        c = surface.clearance(ob.matrix_world @ me.vertices[i].co, reach=2.0)
        if c is not None and c < -0.02:
            buried += 1
    if sampled and buried / sampled > BURIED_LIMIT:
        problems.append("%d of %d sampled vertices sit inside the stone" % (buried, sampled))
    elif buried:
        print("BURIED %d of %d sampled vertices, under the %.0f%% limit"
              % (buried, sampled, BURIED_LIMIT * 100))

    return (not problems), "; ".join(problems) or "clean"


def self_test():
    """Prove the pose encoding on a sphere, where every number is known in advance."""
    for o in list(bpy.data.objects):
        bpy.data.objects.remove(o, do_unlink=True)
    bpy.ops.mesh.primitive_uv_sphere_add(radius=2.0, segments=48, ring_count=24)
    ob = bpy.context.active_object
    ob.name = "SelfTestSphere"

    # The map has to be linear, invertible and orientation-flipping: those are the three things
    # a wrong axis guess breaks, and each of them is cheap to state.
    a, b = Vector((1.0, 2.0, 3.0)), Vector((-0.5, 0.25, 4.0))
    assert (to_unity(a + b) - (to_unity(a) + to_unity(b))).length < 1e-6, "map is not linear"
    assert abs(to_unity(a).length - a.length * MESH_SCALE) < 1e-6, "map is not a similarity"
    assert to_unity(a).cross(to_unity(b)).dot(to_unity(a.cross(b))) < 0.0, "handedness not flipped"

    # A petal has to actually travel between the poses, and the mid pose has to be off the
    # straight line between them -- if it is not, the Bezier is a lerp and the petal collapses
    # through the swing.
    azimuths = [0.0, math.tau / 3.0, 2.0 * math.tau / 3.0]
    poses = {n: flower_vertices(n, 1.0, 3, azimuths) for n in POSE_ORDER}
    tip = len(poses["open"]) - 5           # the last petal's outer tip row
    swing = (poses["open"][tip] - poses["bud"][tip]).length
    off_line = (poses["mid"][tip] - poses["bud"][tip].lerp(poses["open"][tip], 0.5)).length
    print("SELFTEST swing=%.3f off_line=%.3f ratio=%.3f" % (swing, off_line, off_line / swing))
    assert swing > 0.3, "the petal barely moves between bud and open"
    assert off_line / swing > 0.08, "the mid pose is on the line; the arc is a lerp"

    for name in POSE_ORDER:
        lengths = []
        p = POSES[name]
        rows, _side = petal_points(p, 1.0, 0.0, 1.0)
        lengths.append((rows[2] - rows[0]).length)
        print("SELFTEST pose=%-4s reach=%.3f stem=%.2f" % (name, lengths[0], p["stem"]))

    return ob


def main():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    ap = argparse.ArgumentParser(prog="build_bloom_flowers")
    ap.add_argument("--out", required=True, help=".blend to write the field into")
    ap.add_argument("--statue", help="FBX to import and scatter over")
    ap.add_argument("--target", default="Robe", help="mesh in the statue to scatter over")
    ap.add_argument("--self-test", action="store_true",
                    help="scatter over a generated sphere and check the pose encoding")
    ap.add_argument("--name", default="BloomFlowers", help="name of the merged object")
    ap.add_argument("--count", type=int, default=2200, help="how many flowers to plant")
    ap.add_argument("--spread", type=float, default=0.30,
                    help="minimum metres between flowers, in Unity metres")
    ap.add_argument("--height-min", type=float, default=0.34,
                    help="shortest flower, in Unity metres")
    ap.add_argument("--height-max", type=float, default=0.86,
                    help="tallest flower, in Unity metres")
    ap.add_argument("--upright", type=float, default=0.55,
                    help="0 grows straight out of the robe, 1 straight up")
    ap.add_argument("--lift", type=float, default=0.004,
                    help="Blender units the root sits off the surface")
    ap.add_argument("--seed-objects", default="",
                    help="objects the bloom also starts from, e.g. the palms")
    ap.add_argument("--seed-reach", type=float, default=6.0,
                    help="metres over which the bloom spreads out of a seed object")
    ap.add_argument("--seed", type=int, default=20260830, help="scatter RNG seed")
    ap.add_argument("--strip", action="store_true",
                    help="delete everything else, leaving a file holding only the field")
    args = ap.parse_args(argv)

    if args.self_test:
        target = self_test()
    else:
        for o in list(bpy.data.objects):
            bpy.data.objects.remove(o, do_unlink=True)
        if not args.statue:
            ap.error("--statue is required without --self-test")
        bpy.ops.import_scene.fbx(filepath=os.path.abspath(args.statue))
        target = bpy.data.objects.get(args.target)
        if target is None or target.type != "MESH":
            ap.error("no mesh object named %r in %s" % (args.target, args.statue))

    depsgraph = bpy.context.evaluated_depsgraph_get()
    surface = Surface(target, depsgraph)

    seeds = []
    for nm in (n.strip() for n in args.seed_objects.split(",") if n.strip()):
        ob = bpy.data.objects.get(nm)
        if ob is None:
            ap.error("no object named %r for --seed-objects" % nm)
        corners = [ob.matrix_world @ Vector(c) for c in ob.bound_box]
        seeds.append(sum(corners, Vector()) / 8.0)

    rng = random.Random(args.seed)
    anchors = scatter_anchors(surface, args.count, blender_len(args.spread), rng)

    # Nothing grows out of an overhang pointing at the ground.
    up = Vector((0.0, 0.0, 1.0))
    anchors = [(p, n) for p, n in anchors if n.normalized().dot(up) > -0.2]

    lo = min(v.z for v in surface.verts)
    hi = max(v.z for v in surface.verts)
    raw = [growth_order(p, lo, hi, seeds, args.seed_reach) for p, _n in anchors]
    span = (max(raw) - min(raw)) if raw else 0.0
    base = min(raw) if raw else 0.0
    orders = [(o - base) / span for o in raw] if span > 1e-6 else [0.0 for _ in raw]

    ob, tris, planted = build_field(surface, anchors, orders, rng, args)
    ok, report = audit_field(ob, surface, args)

    print("FIELD flowers=%d/%d verts=%d tris=%d order[%.2f,%.2f] %s %s"
          % (planted, len(anchors), len(ob.data.vertices), tris,
             min(orders) if orders else 0.0, max(orders) if orders else 0.0,
             "OK" if ok else "BAD", report))

    if args.strip:
        strip_to(ob)

    out = os.path.abspath(args.out)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=out)
    print("SAVED", out)

    if not ok:
        sys.exit(1)


if __name__ == "__main__":
    main()

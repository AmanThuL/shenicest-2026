"""Parameterised procedural 菌丝 — mycelium filling a volume, as real swept-tube geometry.

The fibre primitives (swept tubes, fractal path noise, catenary sag, bundled fibrils,
droplets) come from `generate_spider_silk.py`; this file is the **layout**: what grows
where inside a box, what it hangs off, how it branches, and how it fuses.

Morphology reproduced:

* rhizomorph cords — the visible structural strands are not single hyphae but bundles of
  them running in parallel and slowly twisting; they span the volume and carry the load.
* hyphae — thinner filaments branching off the cords at an acute angle, several per cord,
  recursively, each generation thinner than its parent.
* anastomosis — hyphae do not only end in space: a share of them fuse into another strand
  they pass near, which is what turns a set of threads into a network.
* apical tips — free growing ends, tapering, that curl as they lose tension.
* guttation droplets — mycelium exudes metabolic water; the droplets sit on the cords by
  the same Plateau-Rayleigh spacing the silk module already derives, just far sparser.
* substrate coupling — strands land on whatever mesh is already in the volume (here the
  cloth landscape under the chapter house floor) by raycast, not on an assumed flat plane.
  The existing model is never touched.

Coordinates are written in **Unity world metres** (the chapter house after its 1.511 import
scale and the builder's grounding), and converted to the open .blend's space on output, so
the numbers in PARAMS are the numbers you read off the Unity Inspector.

Run inside a running Blender that has the blockout open:

    exec(open("Tools/blender/generate_mycelium.py").read()); generate()
"""

import argparse
import math
import os
import sys
import types

import bpy
import numpy as np

_HERE = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else os.getcwd()


def _load_silk():
    """The fibre primitives live next door; this file only owns the layout."""
    path = os.path.join(_HERE, "generate_spider_silk.py")
    if not os.path.exists(path):
        path = "Tools/blender/generate_spider_silk.py"
    module = {"__name__": "silk", "__file__": path}
    exec(compile(open(path).read(), path, "exec"), module)
    return types.SimpleNamespace(**module)


SILK = _load_silk()

# --------------------------------------------------------------------------------------
# parameters — everything about the layout is here
# --------------------------------------------------------------------------------------

PARAMS = {
    "seed": 5,
    "collection": "Mycelium",

    # --- the volume it grows in, Unity world metres ------------------------------------
    # Default: the chapter house undercroft — between the cloth landscape and the
    # underside of the hall floor. Measured, not guessed.
    "bounds_min": [-9.00, 1.13, -4.94],
    "bounds_max": [9.00, 4.50, 8.80],
    "margin": 0.12,                 # keep growth off the exact bounding planes

    # --- containment --------------------------------------------------------------------
    # Path noise, apical tips and the breathing offset all move geometry after the layout
    # has chosen where a strand goes, so the volume has to be enforced on the finished
    # points, not on the anchors. `clip_clearance` is added on top of the margin because a
    # tube's surface sticks out past its centreline by its radius, and a droplet by more.
    "clip": True,
    "clip_clearance": 0.06,
    # Boxes nothing may grow into, in Unity metres: (xmin,xmax, ymin,ymax, zmin,zmax).
    # Default: the metal bridge, so the walkway stays clear even if it is ever lowered
    # into the undercroft.
    "avoid_boxes": [[-0.32, 0.60, 4.57, 5.10, -2.52, 4.34]],
    "avoid_margin": 0.08,

    # --- substrate --------------------------------------------------------------------
    "probe_substrate": True,        # raycast onto whatever mesh is already in the volume
    "probe_from": 4.40,             # cast down from just under the ceiling
    "substrate_fallback": 2.45,     # used where the ray hits nothing
    "substrate_offset": 0.02,       # sink the anchor slightly into the surface

    # --- layout: where the cords go ----------------------------------------------------
    # The cords are the scaffold the network hangs on. `emit_cords` decides whether that
    # scaffold is also *drawn*: off, the cord paths still route the layout and the hyphae
    # still branch off them, but only the fine filaments become geometry.
    "emit_cords": False,
    "cord_count": 52,
    "cord_ceiling_to_floor": 0.45,  # share of cords hanging straight down to the substrate
    "cord_ceiling_to_ceiling": 0.3,  # share slung along the underside of the floor
    "cord_wall_to_wall": 0.25,      # the rest: spanning the volume sideways
    "cord_span_min": 0.8,
    "cord_span_max": 14.0,
    "cord_sag": 0.16,               # slack, as a fraction of the span
    "cord_sag_jitter": 0.7,

    # --- layout: clustering ------------------------------------------------------------
    # Mycelium is not evenly sown: it thickens where the substrate feeds it. Anchors are
    # pulled toward a handful of colony centres instead of being uniform.
    "cluster_count": 14,
    "cluster_pull": 0.42,           # 0 = uniform scatter, 1 = everything on the centres
    "cluster_radius": 3.0,
    "cluster_to_wall": 0.2,        # share of centres placed against a wall/corner

    # --- layout: branching -------------------------------------------------------------
    "hyphae_per_cord": 9,
    "branch_depth": 1,              # generations of branching off a cord
    "branch_falloff": 0.42,         # children per generation, multiplied
    "branch_length": 1.5,           # mean hypha length, metres
    "branch_length_jitter": 0.7,
    "branch_sag": 0.22,
    "fusion_chance": 0.4,           # anastomosis: hypha ends on another strand
    "tip_chance": 0.25,             # free apical tip instead of an anchored end
    "tip_length": 0.45,

    # --- layout: veils -----------------------------------------------------------------
    "veil_count": 20,               # sheets of fine hyphae slung between two cords
    "veil_strands": 8,

    # --- fibre thickness (Unity metres) -------------------------------------------------
    "cord_radius": 0.016,
    "cord_fibrils": 4,
    "cord_twist": 0.9,              # bundle turns per metre
    "hypha_radius": 0.005,
    "hypha_fibrils": 1,
    "tube_sides": 3,
    "generation_taper": 0.6,        # each branch generation is this much of its parent

    # --- noise ---------------------------------------------------------------------------
    "wind_noise": 0.05,
    "radius_jitter": 0.45,
    "path_samples_per_m": 4,

    # --- breathing ----------------------------------------------------------------------
    # The mat is alive: a slow swell driven by two out-of-phase 3D noise fields, baked as
    # shape keys so it survives the FBX trip into Unity. Vertices near an attachment are
    # pinned; the free middle of a span moves most, which is how a slack filament breathes.
    "breathe": True,
    "breathe_amplitude": 0.30,     # metres of travel at a fully free vertex
    "breathe_period": 96,           # frames for one full cycle
    "breathe_field": 1.7,           # spatial scale of the swell, metres
    "breathe_pin": 0.15,            # distance from an anchor over which motion ramps in

    # --- guttation droplets -------------------------------------------------------------
    "guttation": True,
    "guttation_on_cords_only": False,
    "guttation_chance": 0.25,      # share of eligible strands that carry droplets
    "guttation_film": 0.012,        # sets both spacing and droplet size, via Rayleigh
    "guttation_dropout": 0.85,
}


# --------------------------------------------------------------------------------------
# space
# --------------------------------------------------------------------------------------

# Unity world -> the blockout .blend's own space (import scale 1.511, builder grounding).
IMPORT_SCALE = 1.511
GROUND_OFFSET = (5.3867664, 3.9445543, -1.5252357)


def to_blend(points):
    p = np.asarray(points, dtype=float).reshape(-1, 3)
    out = np.empty_like(p)
    out[:, 0] = (p[:, 0] - GROUND_OFFSET[0]) / IMPORT_SCALE
    out[:, 1] = (p[:, 2] - GROUND_OFFSET[2]) / IMPORT_SCALE
    out[:, 2] = (p[:, 1] - GROUND_OFFSET[1]) / IMPORT_SCALE
    return out


def to_unity(points):
    p = np.asarray(points, dtype=float).reshape(-1, 3)
    out = np.empty_like(p)
    out[:, 0] = p[:, 0] * IMPORT_SCALE + GROUND_OFFSET[0]
    out[:, 1] = p[:, 2] * IMPORT_SCALE + GROUND_OFFSET[1]
    out[:, 2] = p[:, 1] * IMPORT_SCALE + GROUND_OFFSET[2]
    return out


def substrate_y(x, z, p):
    """Height of whatever is already modelled at (x, z) — the existing mesh is read, never
    modified. Falls back to a flat level where the ray leaves the model."""
    if not p["probe_substrate"]:
        return p["substrate_fallback"]
    origin = to_blend([x, p["probe_from"], z])[0]
    down = to_blend([x, p["probe_from"] - 1.0, z])[0] - origin
    n = np.linalg.norm(down)
    if n < 1e-9:
        return p["substrate_fallback"]
    hit, loc, _, _, _, _ = bpy.context.scene.ray_cast(
        bpy.context.evaluated_depsgraph_get(),
        tuple(origin), tuple(down / n), distance=60.0)
    if not hit:
        return p["substrate_fallback"]
    return loc.z * IMPORT_SCALE + GROUND_OFFSET[1]


# --------------------------------------------------------------------------------------
# layout helpers
# --------------------------------------------------------------------------------------

def push_out(points, box, margin):
    """Move any point inside an avoid box to its nearest face, along the shallowest axis."""
    lo = np.array([box[0] - margin, box[2] - margin, box[4] - margin])
    hi = np.array([box[1] + margin, box[3] + margin, box[5] + margin])
    inside = np.all((points > lo) & (points < hi), axis=1)
    if not inside.any():
        return points
    out = points.copy()
    sel = out[inside]
    to_lo = sel - lo
    to_hi = hi - sel
    depth = np.minimum(to_lo, to_hi)
    axis = np.argmin(depth, axis=1)
    rows = np.arange(len(sel))
    take_lo = to_lo[rows, axis] < to_hi[rows, axis]
    sel[rows, axis] = np.where(take_lo, lo[axis], hi[axis])
    out[inside] = sel
    return out


def clip_points(points, p):
    """Enforce the volume on finished geometry — after noise, tips and everything else."""
    if not p["clip"]:
        return points
    c = p["clip_clearance"] + p["margin"]
    lo = [p["bounds_min"][i] + c for i in range(3)]
    hi = [p["bounds_max"][i] - c for i in range(3)]
    out = np.clip(np.asarray(points, dtype=float), lo, hi)
    for box in p["avoid_boxes"]:
        out = push_out(out, box, p["avoid_margin"] + p["clip_clearance"])
    return out


def _inset(p):
    m = p["margin"]
    lo = [p["bounds_min"][i] + m for i in range(3)]
    hi = [p["bounds_max"][i] - m for i in range(3)]
    return lo, hi


def colony_centres(p, rng):
    """Where the mat is thick. Some centres hug a wall, the rest sit in the volume."""
    lo, hi = _inset(p)
    centres = []
    for _ in range(int(p["cluster_count"])):
        x = lo[0] + rng.random() * (hi[0] - lo[0])
        z = lo[2] + rng.random() * (hi[2] - lo[2])
        if rng.random() < p["cluster_to_wall"]:
            if rng.random() < 0.5:
                x = lo[0] if rng.random() < 0.5 else hi[0]
            else:
                z = lo[2] if rng.random() < 0.5 else hi[2]
        centres.append((x, z))
    return centres


def plan_point(p, rng, centres):
    """An (x, z) drawn uniformly, then pulled toward a colony centre."""
    lo, hi = _inset(p)
    x = lo[0] + rng.random() * (hi[0] - lo[0])
    z = lo[2] + rng.random() * (hi[2] - lo[2])
    if centres and rng.random() < p["cluster_pull"]:
        cx, cz = centres[int(rng.integers(0, len(centres)))]
        r = p["cluster_radius"] * rng.random() ** 1.6
        a = rng.random() * math.tau
        x = min(max(cx + math.cos(a) * r, lo[0]), hi[0])
        z = min(max(cz + math.sin(a) * r, lo[2]), hi[2])
    return x, z


def ceiling_point(p, rng, centres):
    x, z = plan_point(p, rng, centres)
    return np.array([x, p["bounds_max"][1] - p["margin"] * 0.25, z])


def floor_point(p, rng, centres):
    x, z = plan_point(p, rng, centres)
    return np.array([x, substrate_y(x, z, p) + p["substrate_offset"], z])


def wall_point(p, rng, centres):
    lo, hi = _inset(p)
    x, z = plan_point(p, rng, centres)
    if rng.random() < 0.5:
        x = lo[0] if rng.random() < 0.5 else hi[0]
    else:
        z = lo[2] if rng.random() < 0.5 else hi[2]
    y_floor = substrate_y(x, z, p)
    y = y_floor + rng.random() * max(0.15, hi[1] - y_floor)
    return np.array([x, min(y, hi[1]), z])


# --------------------------------------------------------------------------------------
# fibre parameter sets
# --------------------------------------------------------------------------------------

def fibre_params(p, radius, fibrils, twist):
    q = dict(SILK.PARAMS)
    q.update({
        "fibril_radius": radius,
        "fibril_count": int(fibrils),
        "bundle_spread": radius * 1.35 if fibrils > 1 else 0.0,
        "bundle_turns": twist,
        "tube_sides": int(p["tube_sides"]),
        "radius_jitter": p["radius_jitter"],
        "path_samples_per_m": p["path_samples_per_m"],
        "wind_noise": p["wind_noise"],
        "sag_jitter": p["cord_sag_jitter"],
        "film_radius": p["guttation_film"],
        "droplet_dropout": p["guttation_dropout"],
        "droplet_aspect": 1.15,
        "droplet_segments": 6,
        "droplet_rings": 4,
        "glue": True,
    })
    return q


def apical_tip(root, direction, p, q, rng):
    """A free growing end: it falls away from its branch and the slack tip coils."""
    length = p["tip_length"] * (0.6 + rng.random() * 0.9)
    n = 26
    t = np.linspace(0.0, 1.0, n)
    d = np.asarray(direction, dtype=float)
    d[1] = 0.0
    norm = np.linalg.norm(d)
    if norm < 1e-9:
        return None
    d /= norm
    pts = np.asarray(root, dtype=float) + d * (length * t)[:, None]
    pts[:, 1] -= length * (0.5 + rng.random() * 0.8) * t ** 1.7
    up = np.array([0.0, 1.0, 0.0])
    u = np.cross(d, up)
    u /= max(np.linalg.norm(u), 1e-9)
    v = np.cross(d, u)
    curl = np.clip((t - (0.45 + rng.random() * 0.2)) / 0.5, 0.0, 1.0)
    phase = curl * (1.5 + rng.random() * 3.0) * math.tau
    coil = length * (0.05 + rng.random() * 0.08) * curl
    pts += (np.outer(np.cos(phase), u) + np.outer(np.sin(phase), v)) * coil[:, None]
    return SILK.wind_noise(pts, length * 0.08, rng, q)


# --------------------------------------------------------------------------------------
# growth
# --------------------------------------------------------------------------------------

def grow(p, rng, cord_buf, hypha_buf, drop_buf):
    centres = colony_centres(p, rng)
    cord_q = fibre_params(p, p["cord_radius"], p["cord_fibrils"], p["cord_twist"])
    strand_points = []          # every sampled point of everything already grown
    anchors = []                # attachment points, used to pin the breathing

    # --- cords ------------------------------------------------------------------------
    modes = np.array([p["cord_ceiling_to_floor"],
                      p["cord_ceiling_to_ceiling"],
                      p["cord_wall_to_wall"]], dtype=float)
    modes = modes / max(modes.sum(), 1e-9)

    for _ in range(int(p["cord_count"])):
        mode = int(rng.choice(3, p=modes))
        for _attempt in range(6):
            if mode == 0:
                a = ceiling_point(p, rng, centres)
                b = floor_point(p, rng, centres)
            elif mode == 1:
                a = ceiling_point(p, rng, centres)
                b = ceiling_point(p, rng, centres)
            else:
                a = wall_point(p, rng, centres)
                b = wall_point(p, rng, centres)
            span = float(np.linalg.norm(b - a))
            if p["cord_span_min"] <= span <= p["cord_span_max"]:
                break
        pts = clip_points(SILK.resample(a, b, p["cord_sag"], cord_q, rng), p)
        if p["emit_cords"]:
            wet = p["guttation"] and rng.random() < p["guttation_chance"]
            SILK.build_thread(cord_buf, drop_buf, pts, cord_q, glue=wet, rng=rng)
        strand_points.append(pts)
        anchors.append(pts[0]); anchors.append(pts[-1])

    # --- hyphae, generation by generation ---------------------------------------------
    parents = list(strand_points)
    count = float(p["hyphae_per_cord"])
    radius = p["hypha_radius"]

    for generation in range(int(p["branch_depth"]) + 1):
        q = fibre_params(p, radius, p["hypha_fibrils"], p["cord_twist"] * 1.6)
        children = []
        for parent in parents:
            for _ in range(int(round(count))):
                i = int(rng.integers(1, max(2, len(parent) - 1)))
                root = parent[i]
                length = p["branch_length"] * (1.0 + (rng.random() - 0.5)
                                               * 2.0 * p["branch_length_jitter"])
                length *= p["branch_falloff"] ** generation

                if rng.random() < p["fusion_chance"] and len(strand_points) > 1:
                    # anastomosis: end on a point of another strand within reach
                    other = strand_points[int(rng.integers(0, len(strand_points)))]
                    cand = other[int(rng.integers(0, len(other)))]
                    if 0.15 < float(np.linalg.norm(cand - root)) < length * 2.2:
                        target = cand
                    else:
                        target = None
                else:
                    target = None

                if target is None:
                    # grow away from the parent at an acute angle, then let it fall
                    tangent = parent[min(i + 1, len(parent) - 1)] - parent[i - 1]
                    tangent /= max(np.linalg.norm(tangent), 1e-9)
                    rand = rng.normal(size=3)
                    rand -= tangent * float(np.dot(rand, tangent))
                    rand /= max(np.linalg.norm(rand), 1e-9)
                    angle = p["branch_angle"] if "branch_angle" in p else 0.55
                    direction = tangent * math.cos(angle) + rand * math.sin(angle)
                    target = root + direction * length
                    target[1] -= length * rng.random() * 0.7
                    lo, hi = _inset(p)
                    target = np.array([min(max(target[k], lo[k]), hi[k]) for k in range(3)])
                    if target[1] <= substrate_y(target[0], target[2], p):
                        target[1] = substrate_y(target[0], target[2], p) \
                            + p["substrate_offset"]

                if float(np.linalg.norm(target - root)) < 0.08:
                    continue
                pts = clip_points(SILK.resample(root, target, p["branch_sag"], q, rng), p)
                wet = (p["guttation"] and not p["guttation_on_cords_only"]
                       and rng.random() < p["guttation_chance"])
                SILK.build_thread(hypha_buf, drop_buf, pts, q, glue=wet, rng=rng)
                children.append(pts)
                strand_points.append(pts)
                anchors.append(pts[0]); anchors.append(pts[-1])

                if rng.random() < p["tip_chance"]:
                    drift = rng.normal(size=3)
                    drift[1] = -abs(drift[1]) * 0.5
                    tip = apical_tip(target, drift, p, q, rng)
                    if tip is not None:
                        SILK.build_thread(hypha_buf, drop_buf, clip_points(tip, p), q,
                                          glue=False, rng=rng)

        parents = children
        count *= p["branch_falloff"]
        radius *= p["generation_taper"]
        if not parents:
            break

    # --- veils: fine sheets slung between two cords ------------------------------------
    veil_q = fibre_params(p, p["hypha_radius"] * 0.55, 1, p["cord_twist"] * 2.0)
    for _ in range(int(p["veil_count"])):
        if len(strand_points) < 2:
            break
        a = strand_points[int(rng.integers(0, len(strand_points)))]
        b = strand_points[int(rng.integers(0, len(strand_points)))]
        for k in range(int(p["veil_strands"])):
            t = (k + 0.5) / p["veil_strands"]
            pa = a[int(t * (len(a) - 1))]
            pb = b[int((1.0 - t) * (len(b) - 1))]
            if not 0.2 < float(np.linalg.norm(pb - pa)) < 3.0:
                continue
            pts = clip_points(SILK.resample(pa, pb, p["branch_sag"] * 1.6, veil_q, rng), p)
            SILK.build_thread(hypha_buf, drop_buf, pts, veil_q, glue=False, rng=rng)

    return len(strand_points), anchors


# --------------------------------------------------------------------------------------
# breathing
# --------------------------------------------------------------------------------------

def noise_field(points, rng, cells=8):
    """Trilinearly interpolated 3D value noise over the object's own bounding box."""
    grid = rng.random((cells + 2, cells + 2, cells + 2, 3)) * 2.0 - 1.0
    lo = points.min(axis=0)
    hi = points.max(axis=0)
    span = np.maximum(hi - lo, 1e-6)
    t = (points - lo) / span * cells
    i = np.clip(np.floor(t).astype(int), 0, cells)
    f = t - i
    f = f * f * (3.0 - 2.0 * f)
    out = np.zeros_like(points)
    for dx in (0, 1):
        for dy in (0, 1):
            for dz in (0, 1):
                w = ((f[:, 0] if dx else 1.0 - f[:, 0])
                     * (f[:, 1] if dy else 1.0 - f[:, 1])
                     * (f[:, 2] if dz else 1.0 - f[:, 2]))
                out += grid[i[:, 0] + dx, i[:, 1] + dy, i[:, 2] + dz] * w[:, None]
    return out


def action_fcurves(action):
    """Return curves from legacy Actions or Blender 4.4+ layered Actions."""
    if hasattr(action, "fcurves"):
        return action.fcurves
    return [curve
            for layer in action.layers
            for strip in layer.strips
            for channelbag in strip.channelbags
            for curve in channelbag.fcurves]


def add_breathing(obj, anchors, p, rng):
    """Two out-of-phase shape keys; their sine drivers cross, so the swell wanders."""
    mesh = obj.data
    count = len(mesh.vertices)
    if count == 0:
        return
    co = np.empty(count * 3)
    mesh.vertices.foreach_get("co", co)
    co = co.reshape(-1, 3)

    # pin near the attachments: a vertex on an anchor barely moves, mid-span moves fully
    if len(anchors):
        from mathutils import kdtree
        tree = kdtree.KDTree(len(anchors))
        for k, a in enumerate(anchors):
            tree.insert((float(a[0]), float(a[1]), float(a[2])), k)
        tree.balance()
        weight = np.array([min(1.0, tree.find(tuple(v))[2] / max(p["breathe_pin"], 1e-4))
                           for v in co])
    else:
        weight = np.ones(count)
    weight = weight ** 1.1

    amp = p["breathe_amplitude"] / IMPORT_SCALE   # PARAMS are Unity metres, mesh is blend
    scale = max(p["breathe_field"] / IMPORT_SCALE, 1e-3)

    obj.shape_key_add(name="Basis", from_mix=False)
    period = max(2, int(p["breathe_period"]))
    for index, name in enumerate(("Breathe_A", "Breathe_B")):
        key = obj.shape_key_add(name=name, from_mix=False)
        offset = noise_field(co / scale, rng) * (amp * weight)[:, None]
        if p["clip"]:
            # The key's slider swings negative as well as positive, so the offset has to
            # stay inside the volume in *both* directions: take whichever of the two
            # clamped offsets is the shorter, per axis.
            forward = to_blend(clip_points(to_unity(co + offset), p)) - co
            backward = co - to_blend(clip_points(to_unity(co - forward), p))
            offset = np.where(np.abs(forward) < np.abs(backward), forward, backward)
        key.data.foreach_set("co", (co + offset).ravel())
        key.slider_min = -1.0
        # a quarter-period apart: A peaks while B is crossing zero
        phase = index * period // 4
        for step in range(5):
            frame = 1 + phase + step * period // 4
            key.value = math.sin(step * math.pi * 0.5)
            key.keyframe_insert("value", frame=frame)
        for fc in action_fcurves(obj.data.shape_keys.animation_data.action):
            for kp in fc.keyframe_points:
                kp.interpolation = 'BEZIER'
            if not fc.modifiers:
                fc.modifiers.new('CYCLES')
    bpy.context.scene.frame_start = 1
    bpy.context.scene.frame_end = period


# --------------------------------------------------------------------------------------
# scene
# --------------------------------------------------------------------------------------

def make_materials():
    def mat(name, colour, rough):
        m = bpy.data.materials.get(name) or bpy.data.materials.new(name)
        m.use_nodes = True
        bsdf = m.node_tree.nodes.get("Principled BSDF")
        if bsdf:
            bsdf.inputs["Base Color"].default_value = colour
            bsdf.inputs["Roughness"].default_value = rough
        m.diffuse_color = colour
        return m
    return {
        "cord": mat("Mycelium_Cord", (0.82, 0.79, 0.70, 1.0), 0.62),
        "hypha": mat("Mycelium_Hypha", (0.90, 0.89, 0.84, 1.0), 0.45),
        "drop": mat("Mycelium_Guttation", (0.93, 0.96, 0.98, 1.0), 0.05),
    }


def get_collection(name):
    coll = bpy.data.collections.get(name)
    if coll is None:
        coll = bpy.data.collections.new(name)
        bpy.context.scene.collection.children.link(coll)

    for obj in list(coll.objects):
        bpy.data.objects.remove(obj, do_unlink=True)
    return coll


def _emit(buffer, name, collection, material):
    if not buffer.verts:
        return None
    buffer.verts = [tuple(v) for v in to_blend(buffer.verts)]
    return buffer.to_object(name, collection, material)


def generate(params=None):
    p = dict(PARAMS)
    if params:
        p.update(params)
    p.setdefault("branch_angle", 0.55)
    rng = np.random.default_rng(p["seed"])
    coll = get_collection(p["collection"])
    materials = make_materials()

    cords, hyphae, drops = SILK.MeshBuffer(), SILK.MeshBuffer(), SILK.MeshBuffer()
    strands, anchors = grow(p, rng, cords, hyphae, drops)

    made = [o for o in (
        _emit(cords, "Mycelium_Cords", coll, materials["cord"]),
        _emit(hyphae, "Mycelium_Hyphae", coll, materials["hypha"]),
        _emit(drops, "Mycelium_Guttation", coll, materials["drop"]),
    ) if o is not None]

    if p["breathe"] and made:
        pinned = to_blend(np.asarray(anchors)) if anchors else np.zeros((0, 3))
        for o in made:
            add_breathing(o, pinned, p, np.random.default_rng(p["seed"] + 17))

    # In background mode the view layer's object bases are synced lazily, and the FBX
    # exporter refuses to select an object that is not in view_layer.objects yet.
    bpy.context.view_layer.update()
    _ = bpy.context.view_layer.layer_collection.children

    total = sum(len(o.data.vertices) for o in made)
    print("[mycelium] %d strands, %d objects, %d verts" % (strands, len(made), total))
    return made


def _cli_args(argv):
    parser = argparse.ArgumentParser(description="procedural mycelium")
    for key, value in PARAMS.items():
        if isinstance(value, bool) or key == "collection":
            continue
        if isinstance(value, list) and value and isinstance(value[0], list):
            continue          # avoid_boxes: nested, edit it in PARAMS, not on the CLI
        flag = "--" + key.replace("_", "-")
        if isinstance(value, list):
            parser.add_argument(flag, type=str, default=None,
                                help="three comma-separated metres")
        else:
            parser.add_argument(flag, type=type(value), default=None)
    parsed = vars(parser.parse_args(argv))
    out = {}
    for key, value in parsed.items():
        if value is None:
            continue
        out[key] = [float(v) for v in value.split(",")] \
            if isinstance(PARAMS[key], list) else value
    return out


if __name__ == "__main__":
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    generate(_cli_args(argv))

"""Parameterised procedural spider silk — real swept tube geometry, never a plane.

Morphology reproduced (see the header comment of each builder for the source structure):

* dragline / major-ampullate thread  — a *pair* of fibrils spun from two spigots, laid
  side by side and slowly twisted around the thread axis; near-straight under the web's
  pre-tension, sub-micron diameter, gentle diameter jitter along the length.
* capture spiral — flagelliform axial fibre pair coated in aggregate glue that breaks up
  by the Plateau-Rayleigh instability into the classic BOAS ("beads on a string") array:
  regularly spaced prolate droplets, a thin residual film with a small sub-droplet between
  each pair, spacing lambda ~= 9 * r_film, droplet radius derived from volume conservation.
* segment sag — every span between two attachment points hangs as a catenary; the capture
  spiral sags visibly, the radii and frame threads barely.
* orb web — hub, free zone, radii, frame polygon, anchor lines, and a capture spiral that
  is *not* flat: the hub is pulled out of the frame plane, so the whole sheet is a shallow
  cone, which is what an orb web actually is.
* attachment disc — the splayed fan of fine piriform fibres that cements a thread down.

Everything is driven by the PARAMS dict / the argparse flags; nothing is modelled by hand.

Run inside a running Blender:

    exec(open("Tools/blender/generate_spider_silk.py").read())

Run headless:

    /Applications/Blender.app/Contents/MacOS/Blender --background \
      --python Tools/blender/generate_spider_silk.py -- --preset web --seed 7
"""

import argparse
import math
import sys

import bpy
import numpy as np

# --------------------------------------------------------------------------------------
# parameters
# --------------------------------------------------------------------------------------

PARAMS = {
    # --- global -----------------------------------------------------------------------
    "seed": 11,
    "collection": "SpiderSilk",

    # --- fibre bundle -----------------------------------------------------------------
    # A silk "thread" is a bundle: dragline = 2 fibrils, flagelliform axis = 2, a cribellate
    # hackled band would be dozens. They braid around the axis at `bundle_turns` per metre.
    "fibril_count": 2,
    "fibril_radius": 0.0011,        # metres, at the model's display scale
    "bundle_spread": 0.0016,        # centre-to-axis distance of each fibril
    "bundle_turns": 1.6,            # helical turns per metre of thread
    "tube_sides": 6,                # cross-section resolution -> this is what makes it 3D
    "radius_jitter": 0.6,          # relative diameter variation along the length
    "path_samples_per_m": 44,

    # --- irregularity -----------------------------------------------------------------
    # Nothing a spider spins is regular: every number below is a *mean* that fractal
    # value noise wanders around. Turn them all to 0 to get the clean lab specimen back.
    # The defaults are tuned for a web that has been hit and not repaired — good for a
    # derelict, wrong for a web a spider is still using. A web still in service:
    #   --wind-noise 0.035 --radial-wander 1.6 --sag-jitter 0.6 --spiral-wobble 0.12
    #   --cone-jitter 0.5 --spiral-gap-chance 0.10 --loose-ends 8
    "noise_octaves": 4,
    "noise_base": 3,                # control points in the coarsest octave
    "noise_gain": 0.55,
    "sag_jitter": 0.8,             # per-span slack varies +/- this fraction
    "radial_wander": 3.2,           # radii bow sideways instead of running true
    "spiral_wobble": 0.22,          # capture spiral radius noise, fraction of pitch
    "cone_jitter": 0.9,            # the sheet is a dented cone, not a lathe cone
    "spiral_gap_chance": 0.16,      # sticky segments missing: prey, wind, repair
    "radius_gap_chance": 0.08,
    "droplet_dropout": 0.3,        # beads that never formed or got wiped off
    "loose_ends": 12,                # snapped threads hanging free with a curled tip

    # --- catenary / slack -------------------------------------------------------------
    "sag_capture": 0.09,           # sag as a fraction of span, sticky spiral
    "sag_radius": 0.004,            # radii are pre-tensioned, nearly straight
    "sag_frame": 0.012,
    "wind_noise": 0.055,            # 3D deflection amplitude, keeps threads out of a plane

    # --- BOAS glue droplets (Plateau-Rayleigh) ----------------------------------------
    "glue": True,
    "film_radius": 0.0026,          # radius of the aggregate-glue cylinder before breakup
    "rayleigh_lambda": 9.02,        # fastest-growing wavelength, in units of film radius
    "droplet_aspect": 1.55,         # prolate: stretched along the thread axis
    "droplet_size_jitter": 0.8,
    "droplet_place_jitter": 0.6,   # spacing is regular but not machine-regular
    "sub_droplet_ratio": 0.28,      # the small droplet sitting on the film between two beads
    "droplet_segments": 8,
    "droplet_rings": 5,

    # --- orb web ----------------------------------------------------------------------
    "web_radius": 1.0,
    "radii_count": 26,
    "radii_angle_jitter": 0.75,     # radians * (2pi/n); spiders are not protractors
    "frame_sides": 6,
    "frame_jitter": 0.32,
    "hub_radius": 0.055,
    "free_zone": 0.16,              # no capture spiral inside this radius
    "spiral_pitch": 0.055,
    "spiral_pitch_growth": 1.06,    # pitch widens outwards
    "cone_depth": 0.13,             # hub pulled off the frame plane -> the web is a cone
    "anchor_count": 4,
    "anchor_length": 0.55,

    # --- close-up study strand --------------------------------------------------------
    "study_length": 1.2,
    "study_scale": 3.0,             # the study strand is drawn thicker than web threads
}

RNG = np.random.default_rng(PARAMS["seed"])


# --------------------------------------------------------------------------------------
# curve maths
# --------------------------------------------------------------------------------------

def catenary(p0, p1, sag_ratio, samples):
    """Sample the true catenary hanging between p0 and p1 with the given sag/span ratio.

    Solves s = a * (cosh(L / 2a) - 1) for the catenary parameter a by Newton iteration,
    then hangs the curve along -Z. Falls back to the parabolic approximation for tiny sag,
    where the solve is ill-conditioned and the two curves are indistinguishable anyway.
    """
    p0 = np.asarray(p0, dtype=float)
    p1 = np.asarray(p1, dtype=float)
    t = np.linspace(0.0, 1.0, samples)[:, None]
    line = p0 + (p1 - p0) * t
    span = float(np.linalg.norm(p1 - p0))
    sag = sag_ratio * span
    if span < 1e-6 or sag < 1e-6:
        return line

    if sag / span < 0.02:
        drop = 4.0 * sag * t[:, 0] * (1.0 - t[:, 0])
    else:
        a = span * span / (8.0 * sag)  # parabolic seed
        for _ in range(24):
            u = span / (2.0 * a)
            f = a * (math.cosh(u) - 1.0) - sag
            df = math.cosh(u) - 1.0 - u * math.sinh(u)
            if abs(df) < 1e-12:
                break
            a -= f / df
            a = max(a, 1e-6)
        x = (t[:, 0] - 0.5) * span
        drop = a * (np.cosh(span / (2.0 * a)) - np.cosh(x / a))

    line[:, 2] -= drop
    return line


def value_noise(t, rng, control_points):
    """Smoothstep-interpolated random control points — one octave of value noise."""
    control_points = max(1, int(control_points))
    ctrl = rng.random(control_points + 2) * 2.0 - 1.0
    x = np.clip(t, 0.0, 1.0) * control_points
    i = np.clip(np.floor(x).astype(int), 0, control_points)
    f = x - i
    f = f * f * (3.0 - 2.0 * f)
    return ctrl[i] * (1.0 - f) + ctrl[i + 1] * f


def fbm(t, rng, octaves=4, base=3, gain=0.55, lacunarity=2.0):
    """Fractal value noise: the coarse wander plus the fine fray, in one signal."""
    out = np.zeros_like(np.asarray(t, dtype=float))
    amp, norm, points = 1.0, 0.0, float(base)
    for _ in range(max(1, int(octaves))):
        out += amp * value_noise(t, rng, points)
        norm += amp
        amp *= gain
        points *= lacunarity
    return out / max(norm, 1e-9)


def wind_noise(points, amplitude, rng, p=None):
    """Fractal 3D deflection so no thread is ever straight or ever lies in a plane."""
    if amplitude <= 0.0:
        return points
    p = p or PARAMS
    t = np.linspace(0.0, 1.0, len(points))
    envelope = np.sin(np.pi * t) ** 0.7  # pinned at both attachment points
    offset = np.stack([fbm(t, rng, p["noise_octaves"], p["noise_base"], p["noise_gain"])
                       for _ in range(3)], axis=1)
    return points + offset * (amplitude * envelope)[:, None]


def periodic_noise(angle, phases, freqs, weights):
    """Seamless noise around a circle — used for the web's dented cone profile."""
    a = np.asarray(angle, dtype=float)
    out = np.zeros_like(a)
    for ph, fr, w in zip(phases, freqs, weights):
        out = out + w * np.sin(a * fr + ph)
    return out


def frames(points):
    """Rotation-minimising (parallel transport) frames — no twist artefacts on the sweep."""
    tangents = np.gradient(points, axis=0)
    lengths = np.linalg.norm(tangents, axis=1, keepdims=True)
    tangents = tangents / np.maximum(lengths, 1e-12)

    seed = np.array([0.0, 0.0, 1.0])
    if abs(float(np.dot(seed, tangents[0]))) > 0.9:
        seed = np.array([1.0, 0.0, 0.0])
    normal = seed - tangents[0] * float(np.dot(seed, tangents[0]))
    normal /= max(np.linalg.norm(normal), 1e-12)

    normals = np.empty_like(tangents)
    normals[0] = normal
    for i in range(1, len(points)):
        a, b = tangents[i - 1], tangents[i]
        axis = np.cross(a, b)
        s = np.linalg.norm(axis)
        if s < 1e-9:
            normals[i] = normals[i - 1]
            continue
        axis /= s
        angle = math.atan2(s, float(np.dot(a, b)))
        v = normals[i - 1]
        normals[i] = (v * math.cos(angle)
                      + np.cross(axis, v) * math.sin(angle)
                      + axis * float(np.dot(axis, v)) * (1.0 - math.cos(angle)))
        normals[i] -= tangents[i] * float(np.dot(tangents[i], normals[i]))
        normals[i] /= max(np.linalg.norm(normals[i]), 1e-12)

    binormals = np.cross(tangents, normals)
    return tangents, normals, binormals


# --------------------------------------------------------------------------------------
# mesh accumulation
# --------------------------------------------------------------------------------------

class MeshBuffer:
    """Collects verts/faces so a whole web is one mesh instead of a thousand objects."""

    def __init__(self):
        self.verts = []
        self.faces = []

    def add(self, verts, faces):
        base = len(self.verts)
        self.verts.extend(verts)
        self.faces.extend([[i + base for i in f] for f in faces])

    def to_object(self, name, collection, material=None):
        mesh = bpy.data.meshes.new(name)
        mesh.from_pydata([tuple(v) for v in self.verts], [], self.faces)
        mesh.validate(verbose=False)
        mesh.polygons.foreach_set("use_smooth", [True] * len(mesh.polygons))
        mesh.update()
        obj = bpy.data.objects.new(name, mesh)
        if material is not None:
            obj.data.materials.append(material)
        collection.objects.link(obj)
        return obj


def sweep_tube(buffer, points, radii, sides, cap=True):
    """The core of 'not a plane': a closed circular cross-section swept along a 3D path."""
    tangents, normals, binormals = frames(points)
    theta = np.linspace(0.0, math.tau, sides, endpoint=False)
    cos_t, sin_t = np.cos(theta), np.sin(theta)

    ring_count = len(points)
    verts = np.empty((ring_count * sides, 3))
    for i in range(ring_count):
        offset = (np.outer(cos_t, normals[i]) + np.outer(sin_t, binormals[i])) * radii[i]
        verts[i * sides:(i + 1) * sides] = points[i] + offset

    faces = []
    for i in range(ring_count - 1):
        a, b = i * sides, (i + 1) * sides
        for j in range(sides):
            k = (j + 1) % sides
            faces.append([a + j, a + k, b + k, b + j])
    if cap:
        faces.append(list(range(sides))[::-1])
        last = (ring_count - 1) * sides
        faces.append([last + j for j in range(sides)])
    buffer.add(verts, faces)


def add_spheroid(buffer, centre, frame, radius, aspect, segments, rings):
    """A glue droplet: prolate along the thread tangent, as surface tension leaves it."""
    tangent, normal, binormal = frame
    verts = [centre + tangent * radius * aspect]
    for r in range(1, rings):
        polar = math.pi * r / rings
        sp, cp = math.sin(polar), math.cos(polar)
        for s in range(segments):
            az = math.tau * s / segments
            verts.append(centre
                         + tangent * (radius * aspect * cp)
                         + normal * (radius * sp * math.cos(az))
                         + binormal * (radius * sp * math.sin(az)))
    verts.append(centre - tangent * radius * aspect)

    faces = []
    for s in range(segments):
        faces.append([0, 1 + (s + 1) % segments, 1 + s])
    for r in range(rings - 2):
        a, b = 1 + r * segments, 1 + (r + 1) * segments
        for s in range(segments):
            t = (s + 1) % segments
            faces.append([a + s, a + t, b + t, b + s])
    last = len(verts) - 1
    base = 1 + (rings - 2) * segments
    for s in range(segments):
        faces.append([last, base + s, base + (s + 1) % segments])
    buffer.add(np.asarray(verts), faces)


# --------------------------------------------------------------------------------------
# silk builders
# --------------------------------------------------------------------------------------

def build_thread(fibre_buffer, glue_buffer, points, p, scale=1.0, glue=False, rng=None):
    """One silk thread: a braided fibril bundle, optionally wearing its BOAS glue array."""
    rng = rng or RNG
    tangents, normals, binormals = frames(points)
    n = len(points)
    t = np.linspace(0.0, 1.0, n)

    # arc length drives the braid, so the twist rate is per metre and not per segment
    seg = np.linalg.norm(np.diff(points, axis=0), axis=1)
    arc = np.concatenate([[0.0], np.cumsum(seg)])

    count = max(1, int(p["fibril_count"]))
    spread = p["bundle_spread"] * scale if count > 1 else 0.0
    base_radius = p["fibril_radius"] * scale
    jitter = 1.0 + p["radius_jitter"] * fbm(t, rng, p["noise_octaves"] + 1,
                                            p["noise_base"] + 2, p["noise_gain"])

    for f in range(count):
        phase = math.tau * f / count
        angle = arc * math.tau * p["bundle_turns"] + phase
        offset = (normals * (np.cos(angle) * spread)[:, None]
                  + binormals * (np.sin(angle) * spread)[:, None])
        sweep_tube(fibre_buffer, points + offset, base_radius * jitter, p["tube_sides"])

    if not (glue and p["glue"]):
        return

    # --- Plateau-Rayleigh breakup ----------------------------------------------------
    # A glue cylinder of radius r is unstable to wavelengths above 2*pi*r; the fastest
    # growing one is lambda = 9.02 r, which is the spacing the beads inherit. Volume is
    # conserved: pi r^2 lambda of film becomes one sphere, R = (3 r^2 lambda / 4)^(1/3).
    film = p["film_radius"] * scale
    lam = p["rayleigh_lambda"] * film
    drop_radius = (0.75 * film * film * lam) ** (1.0 / 3.0)
    total = float(arc[-1])
    positions = np.arange(lam * 0.5, total, lam)
    for s in positions:
        s_j = s + (rng.random() - 0.5) * lam * p["droplet_place_jitter"] * 2.0
        s_j = min(max(s_j, 0.0), total)
        i = int(np.searchsorted(arc, s_j))
        i = min(max(i, 0), n - 1)
        frame = (tangents[i], normals[i], binormals[i])
        if rng.random() < p["droplet_dropout"]:
            continue
        size = drop_radius * (1.0 + (rng.random() - 0.5) * p["droplet_size_jitter"] * 2.0)
        add_spheroid(glue_buffer, points[i], frame, size, p["droplet_aspect"],
                     p["droplet_segments"], p["droplet_rings"])

        # the residual film between two beads carries a much smaller satellite droplet
        s_mid = s_j + lam * (0.35 + rng.random() * 0.3)
        if s_mid < total and rng.random() > p["droplet_dropout"] * 2.0:
            j = min(int(np.searchsorted(arc, s_mid)), n - 1)
            add_spheroid(glue_buffer, points[j],
                         (tangents[j], normals[j], binormals[j]),
                         size * p["sub_droplet_ratio"], 1.15,
                         max(4, p["droplet_segments"] // 2), 3)


def build_attachment_disc(buffer, origin, direction, p, rng, scale=1.0, fibres=14):
    """Piriform attachment disc: a splayed fan of fine fibres cementing a thread down."""
    direction = np.asarray(direction, dtype=float)
    direction = direction / max(np.linalg.norm(direction), 1e-9)
    up = np.array([0.0, 0.0, 1.0])
    if abs(float(np.dot(up, direction))) > 0.9:
        up = np.array([1.0, 0.0, 0.0])
    side = np.cross(direction, up)
    side /= max(np.linalg.norm(side), 1e-9)
    other = np.cross(direction, side)
    length = p["bundle_spread"] * 22.0 * scale
    for i in range(fibres):
        az = math.tau * i / fibres + rng.random() * 0.2
        spread = side * math.cos(az) + other * math.sin(az)
        end = (np.asarray(origin, dtype=float)
               + direction * length * (0.25 + rng.random() * 0.35)
               + spread * length * (0.5 + rng.random() * 0.6))
        pts = np.linspace(np.asarray(origin, dtype=float), end, 6)
        r = np.linspace(p["fibril_radius"] * scale * 0.45,
                        p["fibril_radius"] * scale * 0.12, 6)
        sweep_tube(buffer, pts, r, 4)


# --------------------------------------------------------------------------------------
# assemblies
# --------------------------------------------------------------------------------------

def resample(p0, p1, sag, p, rng, scale=1.0, wander=1.0):
    """One span, sampled with its own slack and its own share of the fraying."""
    span = float(np.linalg.norm(np.asarray(p1) - np.asarray(p0)))
    samples = max(8, int(span * p["path_samples_per_m"]) + 5)
    sag = sag * max(0.0, 1.0 + (rng.random() - 0.5) * 2.0 * p["sag_jitter"])
    pts = catenary(p0, p1, sag, samples)
    amplitude = (p["wind_noise"] * scale * span * wander
                 * (0.4 + rng.random() * 1.2))
    return wind_noise(pts, amplitude, rng, p)


def build_loose_end(fibre_buffer, glue_buffer, anchor, direction, p, rng, scale=1.0):
    """A snapped thread: it falls, and the free tip relaxes into a shrinking coil."""
    length = p["web_radius"] * (0.1 + rng.random() * 0.3)
    n = 44
    t = np.linspace(0.0, 1.0, n)
    direction = np.asarray(direction, dtype=float)
    direction[2] = 0.0
    direction /= max(np.linalg.norm(direction), 1e-9)

    pts = np.asarray(anchor, dtype=float) + direction * (length * t)[:, None]
    pts[:, 2] -= length * (0.5 + rng.random() * 0.8) * t ** 1.7

    up = np.array([0.0, 0.0, 1.0])
    u = np.cross(direction, up)
    u /= max(np.linalg.norm(u), 1e-9)
    v = np.cross(direction, u)

    curl = np.clip((t - (0.45 + rng.random() * 0.2)) / 0.5, 0.0, 1.0)
    turns = 1.5 + rng.random() * 3.0
    phase = curl * turns * math.tau
    coil = length * (0.03 + rng.random() * 0.05) * curl
    pts += (np.outer(np.cos(phase), u) + np.outer(np.sin(phase), v)) * coil[:, None]

    pts = wind_noise(pts, length * 0.06, rng, p)
    build_thread(fibre_buffer, glue_buffer, pts, p, scale=scale, glue=True, rng=rng)


def build_orb_web(p, rng, collection, materials):
    """Hub, radii, frame, anchors and the sticky spiral — assembled as a shallow cone."""
    fibre = MeshBuffer()
    glue = MeshBuffer()

    n_rad = int(p["radii_count"])
    step = math.tau / n_rad
    angles = (np.arange(n_rad) * step
              + (rng.random(n_rad) - 0.5) * step * p["radii_angle_jitter"])

    # frame polygon: the anchored outline the radii pull against
    n_frame = int(p["frame_sides"])
    frame_angles = (np.arange(n_frame) * math.tau / n_frame
                    + (rng.random(n_frame) - 0.5) * 0.25)
    frame_angles = np.sort(frame_angles % math.tau)
    frame_r = p["web_radius"] * (1.0 - rng.random(n_frame) * p["frame_jitter"])

    # the cone is dented: a few seamless harmonics around the rim, plus a radial ripple
    dent_phases = rng.random(3) * math.tau
    dent_freqs = np.array([2.0, 3.0, 5.0]) + np.floor(rng.random(3) * 2.0)
    dent_weights = np.array([1.0, 0.55, 0.3]) * rng.random(3) * 2.0

    def cone_z(radius, angle=0.0):
        """The hub is pulled out of the frame plane; the sheet is a dented cone."""
        u = max(0.0, 1.0 - radius / max(p["web_radius"], 1e-6))
        base = p["cone_depth"] * u ** 1.4
        dent = float(periodic_noise(angle, dent_phases, dent_freqs, dent_weights))
        return base + p["cone_depth"] * p["cone_jitter"] * dent * (1.0 - u) * u * 2.0

    def frame_point(angle):
        """Where a ray at `angle` crosses the frame polygon."""
        k = int(np.searchsorted(frame_angles, angle % math.tau)) - 1
        a0, r0 = frame_angles[k % n_frame], frame_r[k % n_frame]
        a1, r1 = frame_angles[(k + 1) % n_frame], frame_r[(k + 1) % n_frame]
        span = (a1 - a0) % math.tau
        u = ((angle - a0) % math.tau) / max(span, 1e-6)
        r = r0 + (r1 - r0) * min(max(u, 0.0), 1.0)
        return np.array([math.cos(angle) * r, math.sin(angle) * r, cone_z(r, angle)])

    def hub_point(angle):
        r = p["hub_radius"]
        return np.array([math.cos(angle) * r, math.sin(angle) * r, cone_z(r, angle)])

    # frame threads (thickest silk in the web)
    heavy = dict(p, fibril_radius=p["fibril_radius"] * 1.7, fibril_count=2)
    for i in range(n_frame):
        a = np.array([math.cos(frame_angles[i]) * frame_r[i],
                      math.sin(frame_angles[i]) * frame_r[i],
                      cone_z(frame_r[i], frame_angles[i])])
        j = (i + 1) % n_frame
        b = np.array([math.cos(frame_angles[j]) * frame_r[j],
                      math.sin(frame_angles[j]) * frame_r[j],
                      cone_z(frame_r[j], frame_angles[j])])
        build_thread(fibre, glue, resample(a, b, p["sag_frame"], p, rng), heavy)

    # anchor / bridge lines running off the frame to the substrate
    for i in range(int(p["anchor_count"])):
        k = int(rng.integers(0, n_frame))
        a = np.array([math.cos(frame_angles[k]) * frame_r[k],
                      math.sin(frame_angles[k]) * frame_r[k],
                      cone_z(frame_r[k], frame_angles[k])])
        out = a / max(np.linalg.norm(a[:2]), 1e-6)
        b = a + np.array([out[0], out[1], 0.0]) * p["anchor_length"]
        b[2] += (rng.random() - 0.5) * p["anchor_length"] * 0.8
        build_thread(fibre, glue, resample(a, b, p["sag_frame"] * 0.4, p, rng), heavy)
        build_attachment_disc(fibre, b, a - b, p, rng)

    # radii: dry dragline, pre-tensioned, almost straight
    for a in angles:
        if rng.random() < p["radius_gap_chance"]:
            continue
        h, f = hub_point(a), frame_point(a)
        build_thread(fibre, glue,
                     resample(h, f, p["sag_radius"], p, rng,
                              wander=p["radial_wander"]), p)

    # hub spiral: the dense non-sticky centre the spider sits on
    hub_pts = []
    for i in range(n_rad * 3 + 1):
        a = i * step / 3.0
        r = p["hub_radius"] * (0.25 + 0.75 * i / (n_rad * 3.0))
        r *= 1.0 + (rng.random() - 0.5) * 0.25
        hub_pts.append([math.cos(a) * r, math.sin(a) * r, cone_z(r, a)])
    build_thread(fibre, glue, wind_noise(np.asarray(hub_pts), 0.004, rng, p), p)

    # capture spiral: sticky, sags between radii, pitch widening outwards
    radius = p["free_zone"]
    pitch = p["spiral_pitch"]
    turn = 0
    while radius < p["web_radius"] * 0.94:
        for i in range(n_rad):
            a0 = angles[i] + turn * step
            a1 = angles[(i + 1) % n_rad] + turn * step
            if a1 < a0:
                a1 += math.tau
            if rng.random() < p["spiral_gap_chance"]:
                continue
            wob = p["spiral_wobble"] * pitch
            r0 = radius + pitch * (i / n_rad) + (rng.random() - 0.5) * 2.0 * wob
            r1 = radius + pitch * ((i + 1) / n_rad) + (rng.random() - 0.5) * 2.0 * wob
            limit = min(np.linalg.norm(frame_point(a0)[:2]),
                        np.linalg.norm(frame_point(a1)[:2])) * 0.93
            if r1 > limit:
                continue
            a = np.array([math.cos(a0) * r0, math.sin(a0) * r0, cone_z(r0, a0)])
            b = np.array([math.cos(a1) * r1, math.sin(a1) * r1, cone_z(r1, a1)])
            build_thread(fibre, glue, resample(a, b, p["sag_capture"], p, rng),
                         p, glue=True, rng=rng)
        radius += pitch
        pitch *= p["spiral_pitch_growth"] * (1.0 + (rng.random() - 0.5) * 0.18)
        turn += 1

    # snapped threads left hanging off the sheet
    for _ in range(int(p["loose_ends"])):
        a = rng.random() * math.tau
        r = p["free_zone"] + rng.random() * (p["web_radius"] - p["free_zone"]) * 0.95
        anchor = np.array([math.cos(a) * r, math.sin(a) * r, cone_z(r, a)])
        drift = np.array([math.cos(a + (rng.random() - 0.5) * 1.6),
                          math.sin(a + (rng.random() - 0.5) * 1.6), 0.0])
        build_loose_end(fibre, glue, anchor, drift, p, rng)

    objs = [fibre.to_object("Silk_Web_Fibre", collection, materials["fibre"])]
    if glue.verts:
        objs.append(glue.to_object("Silk_Web_Glue", collection, materials["glue"]))
    return objs


def build_study_strand(p, rng, collection, materials, origin=(0.0, 0.0, 0.0)):
    """A single capture thread, blown up so the BOAS structure is readable."""
    scale = p["study_scale"]
    fibre = MeshBuffer()
    glue = MeshBuffer()
    a = np.asarray(origin, dtype=float)
    b = a + np.array([p["study_length"], 0.0, 0.0])
    pts = resample(a, b, p["sag_capture"], p, rng, scale=scale)
    build_thread(fibre, glue, pts, p, scale=scale, glue=True, rng=rng)
    build_attachment_disc(fibre, a, b - a, p, rng, scale=scale)
    build_attachment_disc(fibre, b, a - b, p, rng, scale=scale)
    objs = [fibre.to_object("Silk_Study_Fibre", collection, materials["fibre"])]
    if glue.verts:
        objs.append(glue.to_object("Silk_Study_Glue", collection, materials["glue"]))
    return objs


# --------------------------------------------------------------------------------------
# scene plumbing
# --------------------------------------------------------------------------------------

def make_materials():
    fibre = bpy.data.materials.get("Silk_Fibre") or bpy.data.materials.new("Silk_Fibre")
    fibre.use_nodes = True
    bsdf = fibre.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        bsdf.inputs["Base Color"].default_value = (0.86, 0.88, 0.9, 1.0)
        bsdf.inputs["Roughness"].default_value = 0.28
        if "Transmission Weight" in bsdf.inputs:
            bsdf.inputs["Transmission Weight"].default_value = 0.35
        if "IOR" in bsdf.inputs:
            bsdf.inputs["IOR"].default_value = 1.55

    glue = bpy.data.materials.get("Silk_Glue") or bpy.data.materials.new("Silk_Glue")
    glue.use_nodes = True
    bsdf = glue.node_tree.nodes.get("Principled BSDF")
    if bsdf:
        bsdf.inputs["Base Color"].default_value = (0.93, 0.96, 1.0, 1.0)
        bsdf.inputs["Roughness"].default_value = 0.03
        if "Transmission Weight" in bsdf.inputs:
            bsdf.inputs["Transmission Weight"].default_value = 0.85
        if "IOR" in bsdf.inputs:
            bsdf.inputs["IOR"].default_value = 1.42
    return {"fibre": fibre, "glue": glue}


def get_collection(name):
    coll = bpy.data.collections.get(name)
    if coll is None:
        coll = bpy.data.collections.new(name)
        bpy.context.scene.collection.children.link(coll)
    for obj in list(coll.objects):
        bpy.data.objects.remove(obj, do_unlink=True)
    return coll


def generate(preset="all", params=None):
    p = dict(PARAMS)
    if params:
        p.update(params)
    rng = np.random.default_rng(p["seed"])
    coll = get_collection(p["collection"])
    materials = make_materials()
    made = []
    if preset in ("all", "web"):
        made += build_orb_web(p, rng, coll, materials)
    if preset in ("all", "study"):
        offset = (-p["study_length"] * 0.5, -p["web_radius"] * 1.7, 0.0) \
            if preset == "all" else (0.0, 0.0, 0.0)
        made += build_study_strand(p, rng, coll, materials, origin=offset)
    total = sum(len(o.data.vertices) for o in made)
    print("[spider-silk] %d objects, %d verts" % (len(made), total))
    return made


def _cli_args(argv):
    parser = argparse.ArgumentParser(description="procedural spider silk")
    parser.add_argument("--preset", default="all", choices=("all", "web", "study"))
    for key, value in PARAMS.items():
        if isinstance(value, bool) or key == "collection":
            continue
        parser.add_argument("--" + key.replace("_", "-"), type=type(value), default=None)
    parsed = parser.parse_args(argv)
    overrides = {k: v for k, v in vars(parsed).items() if k != "preset" and v is not None}
    return parsed.preset, overrides


if __name__ == "__main__":
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    preset, overrides = _cli_args(argv)
    generate(preset, overrides)

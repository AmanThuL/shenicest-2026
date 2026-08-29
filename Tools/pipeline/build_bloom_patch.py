"""Bloom patches: the algae patch outline, wrapped onto a curved surface.

`build_algae_patch.py` cuts an irregular patch out of a grid in the XY plane and gives it
±11 mm of surface noise. That is enough for a flat corridor wall and wrong for the StMuerte
statue, whose robe curves in both directions over 300 m². Everything about the outline is
kept -- the implicit field, the isoline snap that kills the staircase edge, the rim falloff --
and one step is inserted before the mesh is built: every vertex is dropped onto the target
surface along the patch normal, and takes that surface's normal with it.

The vertex colour contract is the one BioluminescentAlgae.shader already reads, with one
change in what B means:

  R  rim falloff, 1 well inside the patch and 0 at the authored outline
  G  a constant per patch, so neighbouring patches do not pulse or open as one
  B  growth order -- **global** here, not per-patch

Algae patches each open from their own seed because they are scattered and independent. A
statue that blooms has one front that climbs it, so B is mostly the global order handed in by
the caller (normalised height, distance from the palms, whatever the scatter decides) with a
little of the local seed distance mixed in so each patch still opens outwards rather than all
at once. One _Growth scalar then drives the whole statue, which is the entire point: see
docs/design/implementation/StMuerte圣像开花_实施计划.md §2.

Colours are written LINEAR. The Unity importer must be left on DATA, not sRGB, or the rim
falloff bends and the outline moves -- the same trap the algae shader header documents.

Run:
    blender --background --python Tools/pipeline/build_bloom_patch.py -- \
        --out SourceArt/Blender/StatueBloom/BloomPatch.blend --self-test

    blender --background SourceArt/Blender/GAIA1/GAIA1_v8.blend \
        --python Tools/pipeline/build_bloom_patch.py -- \
        --out SourceArt/Blender/StatueBloom/BloomPatch.blend --target Robe
"""
import argparse
import math
import os
import random
import sys

import bisect

import bpy
import bmesh
from mathutils import Vector, noise
from mathutils.bvhtree import BVHTree

# Metres of surface per texture tile. Same constant as the algae patches, so detail density
# reads the same on a 0.45 m patch and a 2 m one.
TILE = 0.45

# How much of the local seed distance is blended into the global growth order. Enough that a
# patch opens outwards instead of appearing whole; small enough that the global front stays
# legible across the statue.
LOCAL_MIX = 0.15


# An edge longer than this many times its nominal grid spacing was stretched across a gap in
# the target rather than laid on it. 2.5 leaves normal curvature alone -- wrapping a 2 m patch
# onto the robe puts honest edges at about 1.5x -- and catches the bridges.
MAX_EDGE_STRETCH = 2.5

# The most the relief noise can lift a vertex off the target. Matches `relief` below.
RELIEF_CEILING = 0.011 + 0.0045

# A triangle smaller than this fraction of a nominal grid triangle is degenerate.
DEGENERATE_FRACTION = 1e-4

# Below this clearance a patch risks z-fighting with the surface it sits on. Reported, not
# failed: a crease legitimately brings the opposite wall this close.
GRAZE_WARN = 0.0005

# Islands smaller than this fraction of the patch's faces are crumbs left behind by tearing.
MIN_ISLAND_FRACTION = 0.04


def drop_small_islands(bm):
    """Delete disconnected crumbs, keeping the patch's substantial pieces.

    Tearing along a fold legitimately splits one patch into two or three clumps; it also
    leaves single-quad specks along the tear. The first is wanted, the second is litter.
    """
    seen = set()
    islands = []
    for f in bm.faces:
        if f in seen:
            continue
        stack, island = [f], []
        seen.add(f)
        while stack:
            cur = stack.pop()
            island.append(cur)
            for e in cur.edges:
                for nb in e.link_faces:
                    if nb not in seen:
                        seen.add(nb)
                        stack.append(nb)
        islands.append(island)
    if len(islands) < 2:
        return
    floor = max(2, int(len(bm.faces) * MIN_ISLAND_FRACTION))
    doomed = [f for isl in islands if len(isl) < floor for f in isl]
    if doomed:
        bmesh.ops.delete(bm, geom=doomed, context="FACES")
        bmesh.ops.delete(bm, geom=[v for v in bm.verts if not v.link_faces], context="VERTS")


def boundary_rim(bm, step, width):
    """Falloff from whatever boundary the patch has after tearing, in metres.

    Breadth-first over the edge graph from the boundary inwards. Hop count times the nominal
    spacing is close enough to a geodesic here: the grid is uniform and the distances involved
    are a few centimetres.
    """
    rim = {}
    frontier = []
    for v in bm.verts:
        if any(e.is_boundary for e in v.link_edges):
            rim[v] = 0.0
            frontier.append(v)
    if not frontier:
        return {v: 1.0 for v in bm.verts}
    hop = step / MAX_EDGE_STRETCH
    while frontier:
        nxt = []
        for v in frontier:
            for e in v.link_edges:
                w = e.other_vert(v)
                d = rim[v] + hop
                if w not in rim or rim[w] > d:
                    rim[w] = d
                    nxt.append(w)
        frontier = nxt
    return {v: smoothstep(0.0, max(width, 1e-4), d) for v, d in rim.items()}


def grid_res(size, spacing):
    """Grid divisions across a patch of `size` metres at `spacing` metres per vertex.

    The algae builder fixes this at 2 cm because those patches are read from arm's length on a
    corridor wall. Most of an 18.8 m statue is not, and 2 cm on a 2 m patch is 9216 quads --
    two hundred of those would put 1.5M triangles on one prop. The caller picks the spacing;
    the clamps keep a patch from degenerating or exploding whatever it picks.
    """
    return max(12, min(96, int(size / max(spacing, 1e-3))))


def smoothstep(e0, e1, x):
    t = min(1.0, max(0.0, (x - e0) / (e1 - e0))) if e1 > e0 else 0.0
    return t * t * (3 - 2 * t)


class Outline:
    """The implicit field whose zero isoline is the patch edge. Lifted from the algae builder."""

    def __init__(self, seed):
        rng = random.Random(seed)
        self.rng = rng
        self.lobes = []
        for _ in range(rng.randint(3, 6)):
            a = rng.uniform(0, math.tau)
            r = rng.uniform(0.0, 0.26)
            self.lobes.append((Vector((math.cos(a) * r, math.sin(a) * r)), rng.uniform(0.17, 0.31)))
        self.o1 = Vector((rng.uniform(-90, 90), rng.uniform(-90, 90), rng.uniform(-90, 90)))
        self.o2 = Vector((rng.uniform(-90, 90), rng.uniform(-90, 90), rng.uniform(-90, 90)))
        self.o3 = Vector((rng.uniform(-90, 90), rng.uniform(-90, 90), rng.uniform(-90, 90)))
        self.seedpt = Vector((rng.uniform(-.3, .3), rng.uniform(-.3, .3)))

    def field(self, u, v):
        p = Vector((u, v))
        best = -9.9
        for c, rad in self.lobes:
            best = max(best, 1.0 - (p - c).length / rad)
        best += noise.fractal(Vector((u * 5.5, v * 5.5, 0.0)) + self.o1, 0.5, 2.0, 4) * 0.30
        best += noise.fractal(Vector((u * 17.0, v * 17.0, 0.0)) + self.o1, 0.5, 2.0, 3) * 0.055
        return best

    def snap(self, u, v, size):
        """Walk a boundary vertex onto the field==0 isoline (kills the staircase edge)."""
        e = 0.004
        g = Vector(((self.field(u + e, v) - self.field(u - e, v)),
                    (self.field(u, v + e) - self.field(u, v - e))))
        if g.length < 1e-6:
            return u, v
        g.normalize()
        f0 = self.field(u, v)
        d = -g if f0 > 0 else g
        lo, hi = 0.0, 0.0
        step = 0.6 / (size / 0.02)
        for _ in range(24):
            hi += step
            if self.field(u + d.x * hi, v + d.y * hi) * f0 <= 0:
                break
        else:
            return u, v
        for _ in range(18):
            mid = (lo + hi) / 2
            if self.field(u + d.x * mid, v + d.y * mid) * f0 <= 0:
                hi = mid
            else:
                lo = mid
        t = (lo + hi) / 2
        return u + d.x * t, v + d.y * t


def plane_points(outline, size, spacing):
    """Grid vertices of the cut-out patch, in patch-local metres.

    Returns (quads, info) where quads are (i,j) grid cells kept and info maps a grid index to
    (local_xy, rim_falloff, local_seed_distance).
    """
    res = grid_res(size, spacing)
    F = {}
    for j in range(res + 1):
        for i in range(res + 1):
            F[(i, j)] = outline.field(i / res - 0.5, j / res - 0.5)

    keep = set()
    for j in range(res):
        for i in range(res):
            if (F[(i, j)] + F[(i + 1, j)] + F[(i + 1, j + 1)] + F[(i, j + 1)]) / 4.0 > 0.0:
                keep.add((i, j))

    used = set()
    for (i, j) in keep:
        used |= {(i, j), (i + 1, j), (i + 1, j + 1), (i, j + 1)}
    border = {(i, j) for (i, j) in used
              if not all(((i + dx, j + dy) in keep) for dx in (-1, 0) for dy in (-1, 0))}

    info = {}
    for (i, j) in used:
        u, v = i / res - 0.5, j / res - 0.5
        if (i, j) in border:
            u, v = outline.snap(u, v, size)
        rim = max(smoothstep(0.0, 0.30, outline.field(u, v)), 0.0)
        local = min(1.0, (Vector((u, v)) - outline.seedpt).length / 0.75)
        info[(i, j)] = (Vector((u * size, v * size)), rim, local)
    return keep, info


def relief(outline, p, rim, size):
    """The millimetre-scale bumpiness the patch carries on top of the surface it sits on."""
    coarse = noise.fractal(Vector((p.x * 3.0, p.y * 3.0, 0.0)) + outline.o2, 0.5, 2.0, 3) * 0.011
    fine = noise.fractal(Vector((p.x * 9.0, p.y * 9.0, 0.0)) + outline.o3, 0.6, 2.0, 4) * 0.0045
    return (coarse + fine) * rim


class Surface:
    """Ray-castable target. Wraps a BVH over the evaluated mesh of one object.

    Hits report the *interpolated* vertex normal, not the face normal the BVH returns. A face
    normal is constant across a triangle, so patches wrapped with it facet visibly wherever the
    target is coarser than the patch -- which the robe is, at 74k tris across 6 m.
    """

    def __init__(self, obj, depsgraph):
        ev = obj.evaluated_get(depsgraph)
        me = ev.to_mesh()
        mw = obj.matrix_world
        nm = mw.to_3x3().inverted_safe().transposed()
        self.verts = [mw @ v.co for v in me.vertices]
        self.vnormals = [(nm @ v.normal).normalized() for v in me.vertices]
        me.calc_loop_triangles()
        self.tris = [tuple(t.vertices) for t in me.loop_triangles]
        self.face_normals = [(nm @ t.normal).normalized() for t in me.loop_triangles]
        self.bvh = BVHTree.FromPolygons(self.verts, self.tris, all_triangles=True)
        self.cum_area = []
        run = 0.0
        for ia, ib, ic in self.tris:
            run += (self.verts[ib] - self.verts[ia]).cross(
                self.verts[ic] - self.verts[ia]).length * 0.5
            self.cum_area.append(run)
        self.total_area = run
        ev.to_mesh_clear()

    def _smooth_normal(self, point, index, fallback):
        """Barycentric blend of the hit triangle's three vertex normals."""
        if index is None or index >= len(self.tris):
            return fallback
        ia, ib, ic = self.tris[index]
        a, b, c = self.verts[ia], self.verts[ib], self.verts[ic]
        n = (b - a).cross(c - a)
        total = n.length_squared
        if total < 1e-12:
            return fallback
        wa = (b - point).cross(c - point).dot(n) / total
        wb = (c - point).cross(a - point).dot(n) / total
        wc = 1.0 - wa - wb
        blended = (self.vnormals[ia] * wa + self.vnormals[ib] * wb + self.vnormals[ic] * wc)
        if blended.length < 1e-6:
            return fallback
        return blended.normalized()

    def sample(self, rng):
        """A uniformly-distributed point on the surface, with its interpolated normal.

        Triangles are drawn in proportion to area, so a densely tessellated fold does not
        attract more clumps than a flat panel of the same size.
        """
        r = rng.random() * self.total_area
        idx = bisect.bisect_left(self.cum_area, r)
        idx = min(idx, len(self.tris) - 1)
        ia, ib, ic = self.tris[idx]
        a, b, c = self.verts[ia], self.verts[ib], self.verts[ic]
        u, v = rng.random(), rng.random()
        if u + v > 1.0:
            u, v = 1.0 - u, 1.0 - v
        point = a + (b - a) * u + (c - a) * v
        return point, self._smooth_normal(point, idx, (b - a).cross(c - a).normalized())

    def clearance(self, point, reach=1.0):
        """Signed distance from `point` to the target: negative means inside the stone."""
        loc, nrm, idx, _d = self.bvh.find_nearest(point, reach)
        if loc is None:
            return None
        d = point - loc
        n = self.face_normals[idx] if idx is not None and idx < len(self.face_normals) else nrm
        return math.copysign(d.length, d.dot(n)) if d.length > 1e-9 else 0.0

    def drop(self, origin, direction, reach):
        """Cast towards the surface; fall back to the nearest point when nothing is hit."""
        loc, nrm, idx, _d = self.bvh.ray_cast(origin, direction, reach)
        if loc is not None:
            return loc, self._smooth_normal(loc, idx, nrm), True
        # Casting the other way catches a vertex that started underneath the surface, which
        # happens wherever the patch is bigger than the local radius of curvature.
        loc, nrm, idx, _d = self.bvh.ray_cast(origin, -direction, reach)
        if loc is not None:
            return loc, self._smooth_normal(loc, idx, nrm), True
        loc, nrm, idx, _d = self.bvh.find_nearest(origin, reach)
        if loc is not None:
            return loc, self._smooth_normal(loc, idx, nrm), False
        return None, None, False


def basis(normal, up_hint=Vector((0.0, 0.0, 1.0))):
    """An orthonormal frame with +Z along `normal`. Patch V runs uphill wherever it can."""
    n = normal.normalized()
    t = up_hint - n * up_hint.dot(n)
    if t.length < 1e-4:
        t = Vector((1.0, 0.0, 0.0)) - n * n.x
    t.normalize()
    return t.cross(n).normalized(), t, n


def build_patch(name, size, seed, surface, anchor, normal, order, spacing, lift=0.004):
    """One patch, cut flat and dropped onto `surface` around `anchor`.

    `order` is the global growth time at the anchor, 0 where the bloom starts and 1 where it
    ends. It is written into vertex colour B together with a little of the patch's own seed
    distance, so the front crosses the statue and each patch still opens outwards.
    """
    outline = Outline(seed)
    keep, info = plane_points(outline, size, spacing)
    tangent, bitangent, n = basis(normal)
    reach = size * 2.0 + 0.5

    placed = {}
    for key, (p, rim, local) in info.items():
        origin = anchor + tangent * p.x + bitangent * p.y + n * (size * 0.75)
        hit, hit_n, on_surface = surface.drop(origin, -n, reach)
        if hit is None or hit_n is None:
            continue
        # A hit whose surface faces away from the patch is the far side of the model showing
        # through a gap. Dropping the vertex is better than stitching the patch through solid.
        if hit_n.dot(n) < 0.15:
            continue
        # The relief noise is signed: on a flat wall a trough is just a dip in the film, and
        # the algae builder keeps it. On a curved target a trough goes *inside* the stone, so
        # troughs clamp to zero instead. Where the noise dips, the clump simply lies against
        # the surface -- which is what a real one does, and it reads as contact rather than as
        # something hovering. `lift` is only the gap that keeps the two out of z-fighting.
        off = lift + max(0.0, relief(outline, p, rim, size))
        final = hit + hit_n * off
        # Where the target is thin -- the deep folds along the hem -- a hit can be on the far
        # wall of a crease, and offsetting along its normal puts the vertex inside the solid.
        # The ray hit is not enough on its own to tell; the nearest-surface test is. Dropping
        # these costs a few vertices at the edge of a clump and is the difference between a
        # patch that lies on the robe and one that is buried in it.
        gap = surface.clearance(final, reach=size * 2.0 + 1.0)
        if gap is not None and gap < 0.0:
            continue
        placed[key] = (final, hit_n, rim, local, on_surface)

    if not placed:
        return None, 0, 0.0

    bm = bmesh.new()
    lay_col = bm.loops.layers.color.new("Col")
    lay_uv = bm.loops.layers.uv.new("UVMap")
    vkey = {}
    vmap = {}
    for key, (co, _hn, _rim, _local, _ok) in placed.items():
        v = bm.verts.new(co)
        vmap[key] = v
        vkey[v] = key

    # The flat grid was uniform, so any edge much longer than its nominal spacing is one that
    # got stretched across a gap in the target -- the two sides of a fold in the robe, most
    # often. Bridging those is the one way this generator produces geometry that is visibly
    # wrong: a sheet spanning a crease, lit as if it were lying on something. Dropping the face
    # instead tears the patch along the fold, which is what a real clump growing over a crease
    # does anyway.
    res = grid_res(size, spacing)
    span_limit = (size / res) * MAX_EDGE_STRETCH
    min_tri_area = ((size / res) ** 2) * 0.5 * DEGENERATE_FRACTION

    for (i, j) in keep:
        corners = ((i, j), (i + 1, j), (i + 1, j + 1), (i, j + 1))
        if not all(k in vmap for k in corners):
            continue
        vs = [vmap[k] for k in corners]
        if any((vs[a].co - vs[(a + 1) % 4].co).length > span_limit for a in range(4)):
            continue
        # Triangles, not quads. A grid quad stays planar in the plane it was cut in; wrapped
        # onto a fold its four corners stop being coplanar, and on strong curvature it can
        # cross itself outright. Blender then derives a face normal that disagrees with the
        # surface the clump lies on, HDRP culls that face, and the clump has a hole in it.
        # Triangles are planar by construction, so each one can be wound to face outwards and
        # stay that way. The short diagonal keeps the two halves from becoming slivers.
        d02 = (vs[0].co - vs[2].co).length
        d13 = (vs[1].co - vs[3].co).length
        pairs = (((0, 1, 2), (0, 2, 3)) if d02 <= d13 else ((0, 1, 3), (1, 2, 3)))
        for tri in pairs:
            t = [vs[i] for i in tri]
            cross = (t[1].co - t[0].co).cross(t[2].co - t[0].co)
            # A sliver whose three corners wrapped onto nearly the same spot has no meaningful
            # normal -- its winding is numerical noise, so it cannot be oriented and shows up
            # as a stray back-face. It also draws nothing: these measure zero square
            # millimetres against a 1300 mm2 median. Drop them rather than orient them.
            if cross.length * 0.5 < min_tri_area:
                continue
            facing = sum((placed[corners[i]][1] for i in tri), Vector()) / 3.0
            if cross.dot(facing) < 0.0:
                t.reverse()
            try:
                bm.faces.new(t)
            except ValueError:
                continue

    bmesh.ops.delete(bm, geom=[v for v in bm.verts if not v.link_faces], context="VERTS")
    drop_small_islands(bm)
    if not bm.faces:
        bm.free()
        return None, 0, 0.0

    # Rim has to follow the boundary the patch actually ended up with, not the one the implicit
    # field drew. Where a fold tore it, the authored rim is still 1.0 along the new edge, and
    # the shader's clip would leave that edge hard while every other edge erodes softly.
    rim_final = boundary_rim(bm, span_limit, 0.075 * size)

    phase = outline.rng.random()
    for face in bm.faces:
        for lp in face.loops:
            key = vkey[lp.vert]
            p, authored_rim, local = info[key]
            rim = min(authored_rim, rim_final[lp.vert])
            grow = min(1.0, max(0.0, order * (1.0 - LOCAL_MIX) + local * LOCAL_MIX))
            lp[lay_col] = (rim, phase, grow, 1.0)
            lp[lay_uv].uv = (p.x / TILE, p.y / TILE)

    # Read the indices off the bmesh before it is freed: to_mesh keeps the order, and the
    # custom-normal call below wants one normal per mesh vertex in exactly that order.
    # vkey still holds the verts that tearing deleted; iterate the bmesh, not the dict.
    bm.verts.index_update()
    normals = [placed[vkey[v]][1] for v in bm.verts]

    me = bpy.data.meshes.new(name)
    bm.to_mesh(me)
    bm.free()

    # Carry the target's normals, not the patch's own. Without this the patch shades as the
    # crumpled sheet it geometrically is instead of as something lying on stone.
    me.normals_split_custom_set_from_vertices(normals)

    ob = bpy.data.objects.new(name, me)
    bpy.context.collection.objects.link(ob)
    me.calc_loop_triangles()
    projected = sum(1 for v in placed.values() if v[4])
    return ob, len(me.loop_triangles), projected / max(len(placed), 1)




def scatter_anchors(surface, count, min_dist, rng, tries_per_anchor=40):
    """Poisson-ish surface scatter: area-weighted samples, rejected when too close.

    Dart throwing rather than a proper Poisson disc. The target here is a few dozen clumps on
    a statue, where the cost of a rejected dart is nothing and the difference from a perfect
    disc is invisible under the clumps' own irregular outlines.
    """
    cell = max(min_dist, 1e-3)
    buckets = {}
    anchors = []
    for _ in range(count):
        for _try in range(tries_per_anchor):
            point, normal = surface.sample(rng)
            key = (int(point.x // cell), int(point.y // cell), int(point.z // cell))
            crowded = False
            for dx in (-1, 0, 1):
                for dy in (-1, 0, 1):
                    for dz in (-1, 0, 1):
                        for other in buckets.get((key[0] + dx, key[1] + dy, key[2] + dz), ()):
                            if (other - point).length < min_dist:
                                crowded = True
                                break
                        if crowded:
                            break
                    if crowded:
                        break
                if crowded:
                    break
            if crowded:
                continue
            buckets.setdefault(key, []).append(point)
            anchors.append((point, normal))
            break
    return anchors


def growth_order(point, low, high, seeds, reach):
    """When the bloom reaches `point`, as 0 at the first stone to flower and 1 at the last.

    Two fronts, whichever arrives first: one climbing from the base, one spreading out of the
    seed points the caller names -- the palms, where the water already falls. A statue that
    only filled bottom-up would ignore the thing its own silhouette is about.
    """
    span = max(high - low, 1e-6)
    climb = min(1.0, max(0.0, (point.z - low) / span))
    if not seeds:
        return climb
    nearest = min((point - s).length for s in seeds)
    return min(climb, min(1.0, nearest / max(reach, 1e-6)))


def audit_patch(ob, surface, size, spacing, lift=0.004):
    """Check a wrapped patch against the three ways this can silently go wrong.

    Every one of these was a real defect during step 1 and 2 of the plan, which is why the
    check ships with the generator rather than beside it: a patch that penetrates the stone,
    floats off it, or bridges a fold all look plausible in the outliner and wrong in game.
    """
    me = ob.data
    mw = ob.matrix_world
    ceiling = lift + RELIEF_CEILING

    # Only a negative gap is a defect. A vertex sitting closer than `lift` is normal wherever
    # the robe folds: inside a crease the nearest surface is the opposite wall, a couple of
    # millimetres away, and the clump is correctly lying on the wall it was cast onto. Failing
    # those rejects the geometry the statue actually has.
    inside = 0
    grazing = 0
    floated = 0
    worst_gap = 0.0
    min_gap = 9e9
    for v in me.vertices:
        gap = surface.clearance(mw @ v.co, reach=size * 2.0 + 1.0)
        if gap is None:
            continue
        if gap < 0.0:
            inside += 1
        elif gap < GRAZE_WARN:
            grazing += 1
        if gap > ceiling + 1e-3:
            floated += 1
        worst_gap = max(worst_gap, gap)
        min_gap = min(min_gap, gap)

    res = grid_res(size, spacing)
    span_limit = (size / res) * MAX_EDGE_STRETCH
    bridged = 0
    for e in me.edges:
        a = mw @ me.vertices[e.vertices[0]].co
        b = mw @ me.vertices[e.vertices[1]].co
        if (a - b).length > span_limit + 1e-4:
            bridged += 1

    ok = not (inside or floated or bridged)
    return ok, ("inside=%d grazing=%d floating=%d bridged=%d gap[%.2f,%.1f]mm"
                % (inside, grazing, floated, bridged, min_gap * 1000.0, worst_gap * 1000.0))



def merge_patches(patches, name):
    """Join every clump into one object.

    They share a material, a growth scalar and a draw call; there is no reason for the scene
    to carry sixty renderers. join() is used rather than a hand-rolled bmesh merge because it
    is the path that keeps custom split normals, vertex colours and UVs intact -- rebuilding
    those by hand is how the target's normals get quietly replaced by the patch's own.
    """
    if not patches:
        return None
    bpy.ops.object.select_all(action="DESELECT")
    for ob in patches:
        ob.select_set(True)
    bpy.context.view_layer.objects.active = patches[0]
    if len(patches) > 1:
        bpy.ops.object.join()
    merged = bpy.context.view_layer.objects.active
    merged.name = name
    merged.data.name = name
    return merged


def strip_to(keep):
    """Delete everything except `keep`, so the source file holds only what is exported."""
    for ob in list(bpy.data.objects):
        if ob is not keep:
            bpy.data.objects.remove(ob, do_unlink=True)


def make_test_sphere(radius=1.5):
    """The §5 step-1 target: a surface whose curvature is known exactly."""
    bpy.ops.mesh.primitive_uv_sphere_add(radius=radius, segments=64, ring_count=32)
    ob = bpy.context.active_object
    ob.name = "SelfTestSphere"
    return ob


def main():
    argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
    ap = argparse.ArgumentParser(prog="build_bloom_patch")
    ap.add_argument("--out", required=True, help=".blend to write the patches into")
    ap.add_argument("--target", help="object in the open .blend to wrap onto")
    ap.add_argument("--self-test", action="store_true",
                    help="wrap onto a generated sphere instead, and audit the fit")
    ap.add_argument("--count", type=int, default=5,
                    help="how many clumps to scatter over the target")
    ap.add_argument("--sizes", default="0.45,0.70,1.00,1.40,2.00",
                    help="patch sizes in metres, drawn from at random")
    ap.add_argument("--spacing", type=float, default=0.05,
                    help="metres per patch vertex; 0.02 is the algae builder's wall density")
    ap.add_argument("--spread", type=float, default=0.6,
                    help="minimum metres between clump anchors")
    ap.add_argument("--seed-objects", default="",
                    help="objects the bloom also starts from, e.g. the palms")
    ap.add_argument("--seed-reach", type=float, default=6.0,
                    help="metres over which the bloom spreads out of a seed object")
    ap.add_argument("--seed", type=int, default=20260830, help="scatter RNG seed")
    ap.add_argument("--merge", default="BloomPatches",
                    help="join the clumps into one object under this name; empty keeps them apart")
    ap.add_argument("--strip", action="store_true",
                    help="delete everything else, leaving a source file holding only the clumps")
    args = ap.parse_args(argv)

    if args.self_test:
        for o in list(bpy.data.objects):
            bpy.data.objects.remove(o, do_unlink=True)
        target = make_test_sphere()
    else:
        if not args.target:
            ap.error("--target is required without --self-test")
        target = bpy.data.objects.get(args.target)
        if target is None or target.type != "MESH":
            ap.error("no mesh object named %r" % args.target)

    depsgraph = bpy.context.evaluated_depsgraph_get()
    surface = Surface(target, depsgraph)

    seeds = []
    for nm in (n.strip() for n in args.seed_objects.split(",") if n.strip()):
        ob = bpy.data.objects.get(nm)
        if ob is None:
            ap.error("no object named %r for --seed-objects" % nm)
        corners = [ob.matrix_world @ Vector(c) for c in ob.bound_box]
        seeds.append(sum(corners, Vector()) / 8.0)

    lo = min(v.z for v in surface.verts)
    hi = max(v.z for v in surface.verts)
    rng = random.Random(args.seed)
    sizes = [float(x) for x in args.sizes.split(",")]

    anchors = scatter_anchors(surface, args.count, args.spread, rng)
    if len(anchors) < args.count:
        print("SCATTER placed %d of %d requested (spread %.2f m is the limit)"
              % (len(anchors), args.count, args.spread))

    # Normalise the scattered orders so _Growth 0->1 spans exactly first clump to last.
    # Unnormalised they stop wherever the scatter happened to stop -- 0.82 on a 60-clump run --
    # and the last fifth of the animation plays to an already-finished statue.
    raw_orders = [growth_order(a, lo, hi, seeds, args.seed_reach) for a, _n in anchors]
    span = max(raw_orders) - min(raw_orders) if raw_orders else 0.0
    base = min(raw_orders) if raw_orders else 0.0
    orders = ([(o - base) / span for o in raw_orders] if span > 1e-6
              else [0.0 for _ in raw_orders])

    built = []
    tris_total = 0
    for idx, (anchor, normal) in enumerate(anchors):
        size = sizes[idx % len(sizes)] if args.self_test else rng.choice(sizes)
        order = orders[idx]
        name = "Bloom_Patch_%03d" % idx
        ob, tris, projected = build_patch(name, size, args.seed + idx * 17, surface,
                                          anchor, normal, order, args.spacing)
        if ob is None:
            print("SKIP %s size=%.2f: nothing survived the wrap" % (name, size))
            continue
        ok, report = audit_patch(ob, surface, size, args.spacing)
        built.append((name, ok))
        tris_total += tris
        if not ok or args.self_test:
            print("BUILT %s size=%.2fm tris=%d order=%.2f projected=%.0f%% | %s %s"
                  % (name, size, tris, order, projected * 100, "OK" if ok else "BAD", report))

    failed = [n for n, ok in built if not ok]
    print("AUDIT patches=%d clean=%d tris=%d order[%.2f,%.2f]"
          % (len(built), len(built) - len(failed), tris_total,
             min(orders) if orders else 0.0, max(orders) if orders else 0.0))

    patches = [o for o in bpy.data.objects if o.name.startswith("Bloom_Patch_")]
    if args.merge and patches:
        merged = merge_patches(patches, args.merge)
        print("MERGED %d clumps into %s: %d verts %d tris"
              % (len(patches), merged.name, len(merged.data.vertices),
                 len(merged.data.loop_triangles) or sum(
                     len(p.vertices) - 2 for p in merged.data.polygons)))
        if args.strip:
            strip_to(merged)

    out = os.path.abspath(args.out)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    bpy.ops.wm.save_as_mainfile(filepath=out)
    print("SAVED", out)

    if failed:
        print("FAILED %s" % ", ".join(failed), file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()

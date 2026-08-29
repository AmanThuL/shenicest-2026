import bpy, bmesh, math, os, random, sys
from mathutils import Vector, noise

argv = sys.argv[sys.argv.index("--")+1:]
BLEND = argv[0]
TILE = 0.45     # metres of wall per wrinkle-texture tile -> consistent detail on every patch

def clear():
    bpy.ops.object.select_all(action='SELECT'); bpy.ops.object.delete(use_global=False)
clear()

def smoothstep(e0, e1, x):
    t = min(1.0, max(0.0, (x-e0)/(e1-e0))) if e1 > e0 else 0.0
    return t*t*(3-2*t)

def build(name, size, seed):
    rng = random.Random(seed)
    lobes = []
    for _ in range(rng.randint(3, 6)):
        a = rng.uniform(0, math.tau); r = rng.uniform(0.0, 0.26)
        lobes.append((Vector((math.cos(a)*r, math.sin(a)*r)), rng.uniform(0.17, 0.31)))
    o1 = Vector((rng.uniform(-90, 90), rng.uniform(-90, 90), rng.uniform(-90, 90)))
    o2 = Vector((rng.uniform(-90, 90), rng.uniform(-90, 90), rng.uniform(-90, 90)))
    o3 = Vector((rng.uniform(-90, 90), rng.uniform(-90, 90), rng.uniform(-90, 90)))
    seedpt = Vector((rng.uniform(-.3, .3), rng.uniform(-.3, .3)))

    def field(u, v):
        p = Vector((u, v)); best = -9.9
        for c, rad in lobes:
            best = max(best, 1.0 - (p-c).length/rad)
        # two noise bands: big lobed outline + small ragged nibbles
        best += noise.fractal(Vector((u*5.5, v*5.5, 0.0))+o1, 0.5, 2.0, 4)*0.30
        best += noise.fractal(Vector((u*17.0, v*17.0, 0.0))+o1, 0.5, 2.0, 3)*0.055
        return best

    def snap(u, v):
        """walk a boundary vertex onto the field==0 isoline (kills the staircase edge)"""
        e = 0.004
        g = Vector(((field(u+e, v)-field(u-e, v)), (field(u, v+e)-field(u, v-e))))
        if g.length < 1e-6: return u, v
        g.normalize()
        f0 = field(u, v)
        d = -g if f0 > 0 else g                       # walk towards the zero crossing
        lo, hi = 0.0, 0.0; step = 0.6/ (size/0.02)
        for _ in range(24):
            hi += step
            if field(u+d.x*hi, v+d.y*hi)*f0 <= 0: break
        else:
            return u, v
        for _ in range(18):                            # bisect
            mid = (lo+hi)/2
            if field(u+d.x*mid, v+d.y*mid)*f0 <= 0: hi = mid
            else: lo = mid
        t = (lo+hi)/2
        return u+d.x*t, v+d.y*t

    res = max(24, min(96, int(size/0.02)))
    bm = bmesh.new()
    lay_col = bm.loops.layers.color.new("Col")
    lay_uv = bm.loops.layers.uv.new("UVMap")
    F = {}
    for j in range(res+1):
        for i in range(res+1):
            F[(i, j)] = field(i/res-0.5, j/res-0.5)
    keep = set()
    for j in range(res):
        for i in range(res):
            if (F[(i,j)]+F[(i+1,j)]+F[(i+1,j+1)]+F[(i,j+1)])/4.0 > 0.0:
                keep.add((i, j))
    used = set()
    for (i, j) in keep:
        used |= {(i,j),(i+1,j),(i+1,j+1),(i,j+1)}
    # a grid vertex is on the border if any of its 4 quads was dropped
    border = {(i,j) for (i,j) in used
              if not all(((i+dx,j+dy) in keep) for dx in (-1,0) for dy in (-1,0))}

    vinfo = {}
    for (i, j) in used:
        u, v = i/res-0.5, j/res-0.5
        if (i, j) in border:
            u, v = snap(u, v)
        f = field(u, v)
        fall = smoothstep(0.0, 0.30, f)
        P = Vector((u*size, v*size))
        coarse = noise.fractal(Vector((P.x*3.0, P.y*3.0, 0.0))+o2, 0.5, 2.0, 3)*0.011
        fine   = noise.fractal(Vector((P.x*9.0, P.y*9.0, 0.0))+o3, 0.6, 2.0, 4)*0.0045
        z = (coarse+fine)*fall
        vt = bm.verts.new((P.x, P.y, z))
        grow = min(1.0, (Vector((u, v))-seedpt).length/0.75)
        vinfo[vt] = (max(fall, 0.0), grow)
        vinfo[(i, j)] = vt
    phase = rng.random()
    for (i, j) in keep:
        try:
            face = bm.faces.new([vinfo[k] for k in ((i,j),(i+1,j),(i+1,j+1),(i,j+1))])
        except ValueError:
            continue
        for lp in face.loops:
            fa, gr = vinfo[lp.vert]
            lp[lay_col] = (fa, phase, gr, 1.0)
            lp[lay_uv].uv = (lp.vert.co.x/TILE, lp.vert.co.y/TILE)   # world-scale UV
    me = bpy.data.meshes.new(name); bm.to_mesh(me); bm.free()
    ob = bpy.data.objects.new(name, me); bpy.context.collection.objects.link(ob)
    me.calc_loop_triangles()
    return ob, len(me.loop_triangles)

SPECS = [("Algae_Patch_A", 0.45, 11), ("Algae_Patch_B", 0.70, 22),
         ("Algae_Patch_C", 1.00, 33), ("Algae_Patch_D", 1.40, 44),
         ("Algae_Patch_E", 2.00, 55)]
x = 0.0
for nm, sz, sd in SPECS:
    ob, tris = build(nm, sz, sd)
    ob.location.x = x; x += sz*0.5+1.4
    print(f"BUILT {nm} size={sz}m tris={tris}")
bpy.ops.wm.save_as_mainfile(filepath=BLEND)
print("SAVED", BLEND)

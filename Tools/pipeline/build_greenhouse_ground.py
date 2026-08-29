"""Build the greenhouse platform material out of two tiles and a radial mask.

Three problems the plain tiling material had, all visible from above:

* the 4 m tile repeated 11 times across a 44.5 m platform on a perfect grid,
  and at grazing angles the repeated joints read as long straight lines --
  the single thing that made the ground look fake;
* the platform was uniform from centre to rim, which no ruin is;
* there were no cracks.

So: the same stone is sampled at two scales whose ratio is not a whole number
and at two different rotations, blended by a large noise, which leaves no
repeat period for the eye to find. A second, broken tile is blended in by
distance from the centre -- a stone platform loses its bedding at the rim
first -- with noise on the radius so the transition is not a clean circle.

    build_greenhouse_ground.py -- [innerRadius] [outerRadius]
"""
import bpy
import math
import os
import sys

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
TEX = ROOT + "/Assets/RootsDance/Textures/Environment"
BLEND = ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1_Assembled.blend"
MATERIAL = "GreenHouse1GroundTile"
INTACT, BROKEN = "GreenHouse1GroundTile", "GreenHouse1GroundBroken"
TARGETS = ("GROUD", "GROUD_T", "STAIR-L", "STAIR-L_T",
           "STAIR-M", "STAIR-M_T", "STAIR-R", "STAIR-R_T")

argv = sys.argv[sys.argv.index("--") + 1:] if "--" in sys.argv else []
R_INNER = float(argv[0]) if argv else 9.0
R_OUTER = float(argv[1]) if len(argv) > 1 else 23.5

bpy.ops.wm.open_mainfile(filepath=BLEND)
mat = bpy.data.materials.get(MATERIAL) or bpy.data.materials.new(MATERIAL)
mat.use_nodes = True
nt = mat.node_tree
nt.nodes.clear()


def node(kind, **attrs):
    n = nt.nodes.new(kind)
    for key, value in attrs.items():
        setattr(n, key, value)
    return n


def mix(fac, a, b):
    """Colour lerp; ShaderNodeMixRGB is legacy but still the clearest here."""
    try:
        m = nt.nodes.new("ShaderNodeMixRGB")
        nt.links.new(fac, m.inputs["Fac"])
        nt.links.new(a, m.inputs["Color1"])
        nt.links.new(b, m.inputs["Color2"])
        return m.outputs["Color"]
    except RuntimeError:
        m = nt.nodes.new("ShaderNodeMix")
        m.data_type = 'RGBA'
        nt.links.new(fac, m.inputs[0])
        nt.links.new(a, m.inputs[6])
        nt.links.new(b, m.inputs[7])
        return m.outputs[2]


geo = node("ShaderNodeNewGeometry")


def projection(tile_m, degrees):
    """World-space box projection at a given tile size and yaw."""
    m = node("ShaderNodeMapping")
    m.inputs["Scale"].default_value = (1.0 / tile_m,) * 3
    m.inputs["Rotation"].default_value = (0.0, 0.0, math.radians(degrees))
    nt.links.new(geo.outputs["Position"], m.inputs["Vector"])
    return m.outputs["Vector"]


def maps(asset, vector):
    """The three exported maps sampled through one projection."""
    out = {}
    for suffix, space in (("BaseMap", "sRGB"), ("Normal", "Non-Color"),
                          ("Mask", "Non-Color")):
        # blend 0: box projection picks its axis from the *shading* normal, and
        # this platform is smooth-shaded, so its vertex normals tilt outwards
        # near the rim. Any blend there pulls in the stretched side projection
        # and lays a band of streaks parallel to every edge.
        tex = node("ShaderNodeTexImage", projection='BOX', projection_blend=0.0)
        tex.image = bpy.data.images.load(
            os.path.join(TEX, "%s_%s.png" % (asset, suffix)), check_existing=True)
        tex.image.colorspace_settings.name = space
        nt.links.new(vector, tex.inputs["Vector"])
        out[suffix] = tex
    return out


def noise(scale, detail=4.0, roughness=0.55):
    n = node("ShaderNodeTexNoise")
    n.inputs["Scale"].default_value = scale
    n.inputs["Detail"].default_value = detail
    n.inputs["Roughness"].default_value = roughness
    nt.links.new(geo.outputs["Position"], n.inputs["Vector"])
    return n


def ramp(fac, low, high):
    r = node("ShaderNodeValToRGB")
    r.color_ramp.elements[0].position = low
    r.color_ramp.elements[1].position = high
    nt.links.new(fac, r.inputs["Fac"])
    return r.outputs["Color"]


# --- two scales of the same stone, no whole-number ratio between them -------
near = maps(INTACT, projection(4.0, 27.0))
far = maps(INTACT, projection(11.3, -13.0))
# features about 18 m across: far larger than either tile, so the blend itself
# never repeats on the tile grid
scale_blend = ramp(noise(0.055).outputs["Fac"], 0.36, 0.64)

intact = {k: mix(scale_blend, near[k].outputs["Color"], far[k].outputs["Color"])
          for k in ("BaseMap", "Normal", "Mask")}
intact_alpha = mix(scale_blend, near["Mask"].outputs["Alpha"],
                   far["Mask"].outputs["Alpha"])

# --- the broken tile, brought in towards the rim ----------------------------
broken = maps(BROKEN, projection(5.3, 41.0))

sep = node("ShaderNodeSeparateXYZ")
nt.links.new(geo.outputs["Position"], sep.inputs["Vector"])
flat = node("ShaderNodeCombineXYZ")
nt.links.new(sep.outputs["X"], flat.inputs["X"])
nt.links.new(sep.outputs["Y"], flat.inputs["Y"])
flat.inputs["Z"].default_value = 0.0
radius = node("ShaderNodeVectorMath", operation='LENGTH')
nt.links.new(flat.outputs["Vector"], radius.inputs["Vector"])

# a clean ring would look drawn on, so the radius is pushed about +-4 m by noise
wobble = node("ShaderNodeMapRange")
nt.links.new(noise(0.09).outputs["Fac"], wobble.inputs["Value"])
wobble.inputs["To Min"].default_value = -4.0
wobble.inputs["To Max"].default_value = 4.0
wobbled = node("ShaderNodeMath", operation='ADD')
nt.links.new(radius.outputs["Value"], wobbled.inputs[0])
nt.links.new(wobble.outputs["Result"], wobbled.inputs[1])

rim = node("ShaderNodeMapRange", clamp=True)
nt.links.new(wobbled.outputs["Value"], rim.inputs["Value"])
rim.inputs["From Min"].default_value = R_INNER
rim.inputs["From Max"].default_value = R_OUTER
rim_fac = ramp(rim.outputs["Result"], 0.15, 0.85)

final = {k: mix(rim_fac, intact[k], broken[k].outputs["Color"])
         for k in ("BaseMap", "Normal", "Mask")}
final_alpha = mix(rim_fac, intact_alpha, broken["Mask"].outputs["Alpha"])

# --- the rim faces need their own, finer sample ----------------------------
# The platform side is only 1.3 m tall. A box projection reads it from the
# side, so a 4 m tile shows barely a third of itself there, and the stone's
# horizontal joints stretch into lines that run the whole perimeter -- the
# straight band that made the edge look drawn on. A much finer, rotated
# sample fits real variation into that height.
rim_tex = maps(BROKEN, projection(1.6, 63.0))

nsep = node("ShaderNodeSeparateXYZ")
nt.links.new(geo.outputs["Normal"], nsep.inputs["Vector"])
upness = node("ShaderNodeMath", operation='ABSOLUTE')
nt.links.new(nsep.outputs["Z"], upness.inputs[0])
sideness = node("ShaderNodeMath", operation='SUBTRACT')
sideness.inputs[0].default_value = 1.0
nt.links.new(upness.outputs["Value"], sideness.inputs[1])
side_fac = ramp(sideness.outputs["Value"], 0.30, 0.62)

final = {k: mix(side_fac, final[k], rim_tex[k].outputs["Color"])
         for k in ("BaseMap", "Normal", "Mask")}
final_alpha = mix(side_fac, final_alpha, rim_tex["Mask"].outputs["Alpha"])

# --- a slow tint over the whole platform, larger than anything else ---------
macro = ramp(noise(0.028, detail=2.0).outputs["Fac"], 0.25, 0.80)
tinted = nt.nodes.new("ShaderNodeMixRGB")
tinted.blend_type = 'MULTIPLY'
tinted.inputs["Fac"].default_value = 0.35
nt.links.new(final["BaseMap"], tinted.inputs["Color1"])
nt.links.new(macro, tinted.inputs["Color2"])

# --- shade -----------------------------------------------------------------
bsdf = node("ShaderNodeBsdfPrincipled")
out = node("ShaderNodeOutputMaterial")
nt.links.new(bsdf.outputs["BSDF"], out.inputs["Surface"])
nt.links.new(tinted.outputs["Color"], bsdf.inputs["Base Color"])

nrm = node("ShaderNodeNormalMap")
nt.links.new(final["Normal"], nrm.inputs["Color"])
nt.links.new(nrm.outputs["Normal"], bsdf.inputs["Normal"])

split = node("ShaderNodeSeparateColor")
nt.links.new(final["Mask"], split.inputs["Color"])
nt.links.new(split.outputs["Red"], bsdf.inputs["Metallic"])
# the Unity mask map carries smoothness in alpha; straight through it mirrors
inv = node("ShaderNodeInvert")
nt.links.new(final_alpha, inv.inputs["Color"])
rough = node("ShaderNodeMapRange", clamp=True)
nt.links.new(inv.outputs["Color"], rough.inputs["Value"])
rough.inputs["To Min"].default_value = 0.62
rough.inputs["To Max"].default_value = 1.0
nt.links.new(rough.outputs["Result"], bsdf.inputs["Roughness"])

hit = []
for obj in bpy.data.objects:
    if obj.type == "MESH" and obj.name in TARGETS:
        obj.data.materials.clear()
        obj.data.materials.append(mat)
        hit.append(obj.name)

bpy.ops.wm.save_mainfile()
print("### ground rebuilt: %d nodes, rim %.1f-%.1f m, objects %s"
      % (len(nt.nodes), R_INNER, R_OUTER, ", ".join(hit)))

"""Give the named objects a world-space tiling material.

Used for anything too large for a unique unwrap to resolve: the plinth, the
ground steps, and the spiral stair -- whose 1963 non-manifold edges an unwrap
would have to be repaired around, while a triplanar projection ignores them.

    apply_tiling.py -- <TileAsset> <metres> <objectPrefix> [<objectPrefix> ...]
"""
import bpy
import os
import sys

argv = sys.argv[sys.argv.index("--") + 1:]
ASSET, TILE_M, PREFIXES = argv[0], float(argv[1]), tuple(argv[2:])

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
TEX = ROOT + "/Assets/RootsDance/Textures/Environment"
bpy.ops.wm.open_mainfile(filepath=ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1_Assembled.blend")

mat = bpy.data.materials.get(ASSET) or bpy.data.materials.new(ASSET)
mat.use_nodes = True
nt = mat.node_tree
nt.nodes.clear()
out = nt.nodes.new("ShaderNodeOutputMaterial")
bsdf = nt.nodes.new("ShaderNodeBsdfPrincipled")
nt.links.new(bsdf.outputs["BSDF"], out.inputs["Surface"])
# world position, not object coordinates: the placed instances carry their
# own transforms, and object space stretches the projection with them -- and
# world space is what makes the material continuous from one object to the next
geo = nt.nodes.new("ShaderNodeNewGeometry")
mapping = nt.nodes.new("ShaderNodeMapping")
mapping.inputs["Scale"].default_value = (1.0 / TILE_M,) * 3
nt.links.new(geo.outputs["Position"], mapping.inputs["Vector"])


def image(suffix, colorspace):
    node = nt.nodes.new("ShaderNodeTexImage")
    node.image = bpy.data.images.load(
        os.path.join(TEX, "%s_%s.png" % (ASSET, suffix)), check_existing=True)
    node.image.colorspace_settings.name = colorspace
    node.projection = "BOX"
    node.projection_blend = 0.25
    nt.links.new(mapping.outputs["Vector"], node.inputs["Vector"])
    return node


nt.links.new(image("BaseMap", "sRGB").outputs["Color"], bsdf.inputs["Base Color"])
nrm_tex = image("Normal", "Non-Color")
nrm = nt.nodes.new("ShaderNodeNormalMap")
nt.links.new(nrm_tex.outputs["Color"], nrm.inputs["Color"])
nt.links.new(nrm.outputs["Normal"], bsdf.inputs["Normal"])
mask = image("Mask", "Non-Color")
sep = nt.nodes.new("ShaderNodeSeparateColor")
nt.links.new(mask.outputs["Color"], sep.inputs["Color"])
nt.links.new(sep.outputs["Red"], bsdf.inputs["Metallic"])
# the Unity mask map carries smoothness in alpha; straight through it mirrors
inv = nt.nodes.new("ShaderNodeInvert")
nt.links.new(mask.outputs["Alpha"], inv.inputs["Color"])
nt.links.new(inv.outputs["Color"], bsdf.inputs["Roughness"])

hit = []
for obj in bpy.data.objects:
    if obj.type == "MESH" and obj.name in PREFIXES:
        obj.data.materials.clear()
        obj.data.materials.append(mat)
        hit.append(obj.name)
bpy.ops.wm.save_mainfile()
print("### %s (%.1f m) applied to: %s" % (ASSET, TILE_M, ", ".join(hit) or "nothing"))

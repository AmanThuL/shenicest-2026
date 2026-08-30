"""GAIA1 v9: swap the old flat-shaded greenhouse for the textured build.

Everything is appended as-is and parented to one empty, which is then placed
at the old building's base centre. Moving the group rigidly is the whole
point: per-object offsets are what dropped the stair and double-shifted the
glazing, because Kabsch-placed instances and FBX glass do not all carry
their position in the translation component.
"""
import bpy
import os
from mathutils import Vector

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
V9 = ROOT + "/SourceArt/Blender/GAIA1/GAIA1_v9.blend"
ASSEMBLED = ROOT + "/SourceArt/Blender/GreenHouse1/GreenHouse1_Assembled.blend"
GLASS = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
TEX = ROOT + "/Assets/RootsDance/Textures/Environment"
BASE_CENTRE = Vector((44.021, 108.062, 6.4507))

bpy.ops.wm.open_mainfile(filepath=V9)

doomed = [o for o in bpy.data.objects
          if o.type == "MESH"
          and any(m.name.startswith("GH_") for m in o.data.materials if m)]
print("### removing %d old greenhouse objects" % len(doomed))
for o in doomed:
    bpy.data.objects.remove(o, do_unlink=True)

# re-running must replace, not stack: clear anything a previous pass installed
for previous in [c for c in bpy.data.collections
                 if c.name == "GreenHouse1" or c.name.startswith("GreenHouse1.")]:
    for o in list(previous.objects):
        bpy.data.objects.remove(o, do_unlink=True)
    bpy.data.collections.remove(previous)
    print("### cleared a previous GreenHouse1 install")

home = bpy.data.collections.new("GreenHouse1")
bpy.context.scene.collection.children.link(home)

anchor = bpy.data.objects.new("GreenHouse1_Anchor", None)
anchor.empty_display_size = 4.0
home.objects.link(anchor)

appended = []
with bpy.data.libraries.load(ASSEMBLED) as (src, dst):
    dst.objects = list(src.objects)
for ob in dst.objects:
    if ob is None or ob.type != "MESH":
        continue
    if ob.hide_render:                       # untextured masters stay behind
        bpy.data.objects.remove(ob, do_unlink=True)
        continue
    home.objects.link(ob)
    # a viewport-disabled object is skipped by the depsgraph, so its world
    # matrix never evaluates: parenting and location both silently do nothing
    # and it sits at the origin. The stair arrived from the assembly this way.
    ob.hide_viewport = False
    appended.append(ob)
print("### building instances: %d" % len(appended))

with bpy.data.libraries.load(GLASS) as (src, dst):
    dst.objects = [n for n in src.objects if n.endswith("-GLASS")]
glass = [ob for ob in dst.objects if ob is not None]
for ob in glass:
    home.objects.link(ob)
    ob.hide_viewport = False
    appended.append(ob)
print("### glass objects: %d" % len(glass))


def glass_material(state, mat):
    mat.use_nodes = True
    mat.blend_method = 'BLEND'
    nt = mat.node_tree
    nt.nodes.clear()
    out = nt.nodes.new("ShaderNodeOutputMaterial")
    bsdf = nt.nodes.new("ShaderNodeBsdfPrincipled")
    nt.links.new(bsdf.outputs["BSDF"], out.inputs["Surface"])
    geo = nt.nodes.new("ShaderNodeNewGeometry")
    mapping = nt.nodes.new("ShaderNodeMapping")
    mapping.inputs["Scale"].default_value = (0.5, 0.5, 0.5)
    nt.links.new(geo.outputs["Position"], mapping.inputs["Vector"])

    def image(suffix, colour_space):
        node = nt.nodes.new("ShaderNodeTexImage")
        node.image = bpy.data.images.load(
            os.path.join(TEX, "GreenHouse1Glass%s_%s.png" % (state, suffix)),
            check_existing=True)
        node.image.colorspace_settings.name = colour_space
        node.projection = 'BOX'
        node.projection_blend = 0.0
        nt.links.new(mapping.outputs["Vector"], node.inputs["Vector"])
        return node

    base = image("BaseMap", "sRGB")
    nt.links.new(base.outputs["Color"], bsdf.inputs["Base Color"])
    nt.links.new(base.outputs["Alpha"], bsdf.inputs["Alpha"])
    normal_tex = image("Normal", "Non-Color")
    normal = nt.nodes.new("ShaderNodeNormalMap")
    normal.inputs["Strength"].default_value = 0.5
    nt.links.new(normal_tex.outputs["Color"], normal.inputs["Color"])
    nt.links.new(normal.outputs["Normal"], bsdf.inputs["Normal"])
    mask = image("Mask", "Non-Color")
    invert = nt.nodes.new("ShaderNodeInvert")
    nt.links.new(mask.outputs["Alpha"], invert.inputs["Color"])
    nt.links.new(invert.outputs["Color"], bsdf.inputs["Roughness"])


STATES = ("Dirty", "Cracked", "Shattered", "Stained")
authored = set()
for ob in glass:
    # never clear the slots: the breakage pass stored each pane's state as a
    # material index, and clearing would reset every face to slot 0
    for index, mat in enumerate(ob.data.materials):
        if mat is not None and mat.name not in authored:
            glass_material(STATES[min(index, 3)], mat)
            authored.add(mat.name)

bpy.context.view_layer.update()
for ob in appended:
    ob.parent = anchor
    ob.matrix_parent_inverse = anchor.matrix_world.inverted()
anchor.location = BASE_CENTRE
bpy.context.view_layer.update()
print("### parented %d objects to the anchor at %s"
      % (len(appended), tuple(round(v, 2) for v in BASE_CENTRE)))

bpy.ops.wm.save_mainfile()
print("### saved %s" % V9)

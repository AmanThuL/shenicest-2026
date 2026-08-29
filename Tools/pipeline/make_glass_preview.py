"""Build a blend you can just open and see which faces are glass.

The working file cannot answer that question: the breakage pass names three
materials but never gives them nodes, so everything opens white. This writes
a sibling preview where glass is cyan, iron is dark grey, both are set for
solid-mode viewport colour as well as rendered, and the viewport is already
switched to material shading -- so the file answers the question on open,
with no setup.

Cyan by state: intact bright, cracked amber, shattered orange, stained
violet. Anything still white is a face with no material, which is itself
worth seeing.
"""
import bpy

ROOT = "/Users/yawen/projects/SheNicest/shenicest-2026-建模专用1"
SRC = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass.blend"
OUT = ROOT + "/SourceArt/Blender/GreenHouse1Glass/GreenHouse1Glass_Preview.blend"

STATE_COLOUR = {
    "Intact": (0.10, 0.85, 1.00),
    "Cracked": (1.00, 0.78, 0.15),
    "Shattered": (1.00, 0.42, 0.10),
    "Stained": (0.72, 0.35, 0.95),
}
IRON = (0.16, 0.17, 0.19)

bpy.ops.wm.open_mainfile(filepath=SRC)


def paint(mat, rgb, emissive):
    mat.use_nodes = True
    nt = mat.node_tree
    nt.nodes.clear()
    out = nt.nodes.new("ShaderNodeOutputMaterial")
    if emissive:
        shader = nt.nodes.new("ShaderNodeEmission")
        shader.inputs["Color"].default_value = (*rgb, 1)
        shader.inputs["Strength"].default_value = 1.6
        nt.links.new(shader.outputs["Emission"], out.inputs["Surface"])
    else:
        shader = nt.nodes.new("ShaderNodeBsdfDiffuse")
        shader.inputs["Color"].default_value = (*rgb, 1)
        nt.links.new(shader.outputs["BSDF"], out.inputs["Surface"])
    # solid mode reads this, so the file is legible without material preview
    mat.diffuse_color = (*rgb, 1)


glass_mats = 0
for mat in bpy.data.materials:
    state = next((s for s in STATE_COLOUR if mat.name.endswith(s)), None)
    if state:
        paint(mat, STATE_COLOUR[state], True)
        glass_mats += 1
    else:
        paint(mat, IRON, False)

iron_mat = bpy.data.materials.new("PreviewIron")
paint(iron_mat, IRON, False)

# the unbroken glazing carries no materials at all -- those are created by
# the breakage pass -- so without a fallback that file opens grey and the
# question "which faces are glass" still has no answer
fallback = bpy.data.materials.new("PreviewGlass")
paint(fallback, STATE_COLOUR["Intact"], True)

col = bpy.data.collections["GlassRecovered"]
glass_names = {o.name for o in col.objects}
glass_faces = frame_faces = 0
for obj in bpy.data.objects:
    if obj.type != "MESH":
        continue
    # anything the depsgraph skips is invisible however it is coloured
    obj.hide_viewport = False
    obj.hide_render = False
    if obj.name in glass_names:
        glass_faces += len(obj.data.polygons)
        slots = [m for m in obj.data.materials if m is not None]
        if not any(any(m.name.endswith(st) for st in STATE_COLOUR) for m in slots):
            obj.data.materials.clear()
            obj.data.materials.append(fallback)
    else:
        frame_faces += len(obj.data.polygons)
        obj.data.materials.clear()
        obj.data.materials.append(iron_mat)

# open on material shading rather than default solid
for screen in bpy.data.screens:
    for area in screen.areas:
        if area.type == 'VIEW_3D':
            for space in area.spaces:
                if space.type == 'VIEW_3D':
                    space.shading.type = 'MATERIAL'
                    space.shading.use_scene_world = False

print("### glass materials coloured: %d" % glass_mats)
print("### glass faces: %d on %d objects" % (glass_faces, len(glass_names)))
print("### frame faces: %d" % frame_faces)
bpy.ops.wm.save_as_mainfile(filepath=OUT)
print("### saved %s" % OUT)
